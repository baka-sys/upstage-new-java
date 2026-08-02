package com.aska.logical.service.code.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpException;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpUtil;
import com.alibaba.fastjson.JSON;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.CovertUtil;
import com.aska.logical.service.code.ILiveCodeService;
import com.aska.logical.service.common.ITaskService;
import com.aska.logical.service.common.TelegramWebhookService;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.repository.entity.*;
import com.aska.repository.mapper.ExclusiveCodeMapper;
import com.aska.repository.mapper.LiveCodeMapper;
import com.aska.repository.mapper.LiveCodeNumberMapper;
import com.aska.repository.mapper.RealmNameMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.net.URL;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

/**
 * <p>
 * 商户域名表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-07-17
 */
@Service
public class LiveCodeServiceImpl extends ServiceImpl<LiveCodeMapper, LiveCode> implements ILiveCodeService {

    @Autowired
    LiveCodeMapper mapper;

    @Autowired
    IOperationAutoService operationAutoService;

    @Autowired
    RealmNameMapper realmNameMapper;

    @Autowired
    LiveCodeNumberMapper liveCodeNumberMapper;

    @Autowired
    ITaskService taskService;

    @Autowired
    TelegramWebhookService telegramWebhookService;

    @Autowired
    ExclusiveCodeMapper exclusiveCodeMapper;

    @Override
    public Page<LiveCode> getDomainPage(String domainName,Integer type, Integer platformType, Integer page, Integer limit) {
        Page<LiveCode> domainPage = new Page<>(page, limit);
        //获取下面的对应域名下面的绑定数量
        Page<LiveCode> result = mapper.selectPageByParams(domainName,type,platformType, domainPage);
        if(type.equals(1) && !result.getRecords().isEmpty()){
            result.getRecords().forEach(liveCode -> {
                // 查询当前卡密占用的信息
                List<User> exclusiveCodeList = exclusiveCodeMapper.selectCarmineListById(liveCode.getId());

                if(!exclusiveCodeList.isEmpty()){
                    List<String> exclusiveCodeListString = exclusiveCodeList.stream().map(User::getCarmine).collect(Collectors.toList());
                    liveCode.setCarmineSet(StrUtil.join(",",exclusiveCodeListString));
                }
            });
        }
        return result;
    }


    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void addBatchDomain(BatchDomain batchDomain) {
        //分割所有域名
        List<String> domains = Arrays.asList(batchDomain.getDomainNames().split(","));
        if (domains == null || domains.size() == 0) {
            throw new CustomException(ResultCode.URL_IS_NOT_NULL);
        }
        LiveCode domain3 = mapper.selectOne(new LambdaQueryWrapper<LiveCode>().in(LiveCode::getDomainName, domains).eq(LiveCode::getDeleted, 0).orderByDesc(LiveCode::getSort).last("limit 1"));
        if (domain3 != null) {
            throw new CustomException(ResultCode.URL_IS_NOT_REPAIR.code(), ResultCode.URL_IS_NOT_REPAIR.message() + "," + domain3.getDomainName());
        }
        // 检测最新一条数据
        LiveCode domain1 = mapper.selectOne(
                new LambdaQueryWrapper<LiveCode>().eq(LiveCode::getType,batchDomain.getType()).eq(LiveCode::getDeleted, 0).orderByDesc(LiveCode::getSort).last("limit 1")
        );
        AtomicReference<Integer> sort = new AtomicReference<>(0);
        if (domain1 != null) {
            sort.set(domain1.getSort());
        }
        //排序
        domains.stream().forEach(domain -> {
            sort.updateAndGet(v -> v + 1);
            try {
                new URL(domain);
            } catch (Exception e) {
                throw new CustomException(ResultCode.URL_INFO_IS_ERROR.code(),ResultCode.URL_INFO_IS_ERROR.message() + domain);
            }
            LiveCode domain2 = new LiveCode();
            domain2.setDomainName(domain);
            domain2.setPlatformType(batchDomain.getPlatformType());
            domain2.setType(batchDomain.getType());
            domain2.setDirect(batchDomain.getDirect());
            domain2.setSort(sort.get());
            domain2.setCreateTime(DateUtil.date());
            mapper.insert(domain2);
            // 添加子表数据
            LiveCodeNumber liveCodeNumber = new LiveCodeNumber();
            liveCodeNumber.setLiveCodeId(domain2.getId());
            liveCodeNumber.setNumber(0);
            liveCodeNumberMapper.insert(liveCodeNumber);
        });
    }

    @Override
    public void updateDomain(LiveCode domain) {
        LiveCode domain1 = mapper.selectById(domain.getId());

        // 域名是否重复
        LiveCode domain2 = mapper.selectOne(new LambdaQueryWrapper<LiveCode>().eq(LiveCode::getDomainName, domain.getDomainName()).ne(LiveCode::getId, domain.getId()));
        if (domain2 != null) {
            throw new CustomException(ResultCode.URL_IS_NOT_REPAIR);
        }
        if (domain1 == null) {
            throw new CustomException(ResultCode.URL_INFO_IS_ERROR);
        }
        domain.setUpdateTime(DateUtil.date());
        mapper.updateById(domain);
    }

    @Override
    public void updateStatus(Long id) {
        LiveCode domain = mapper.selectById(id);
        domain.setStatus(domain.getStatus() == 0 ? 1 : 0);
        domain.setUpdateTime(DateUtil.date());
        mapper.updateById(domain);
    }

    /**
     * 删除域名
     *
     * @param id
     */
    @Override
    public void delete(Long id) {
        LiveCode domain = mapper.selectById(id);
        domain.setDeleted(1);
        domain.setDeleteTime(DateUtil.date());
        mapper.updateById(domain);
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchDelete(String ids) {
        List<Long> idsList = CovertUtil.covertLongList(ids);
        QueryWrapper<LiveCode> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().in(LiveCode::getId, idsList);
        LiveCode domain = new LiveCode();
        domain.setDeleted(1);
        domain.setDeleteTime(DateUtil.date());
        mapper.update(domain, queryWrapper);
    }


    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchReset(String ids,Integer type) {
        List<Long> idsList = CovertUtil.covertLongList(ids);

        // 检测最新一条数据
        LiveCode domain1 = mapper.selectOne(
                new LambdaQueryWrapper<LiveCode>().eq(LiveCode::getType,type).eq(LiveCode::getDeleted, 0).orderByDesc(LiveCode::getSort).last("limit 1")
        );

        AtomicReference<Integer> sort = new AtomicReference<>(0);
        if (domain1 != null) {
            sort.set(domain1.getSort());
        }

        idsList.stream().forEach(id -> {
            sort.updateAndGet(v -> v + 1);
            LiveCode domain = mapper.selectById(id);
            domain.setSort(sort.get());
            domain.setNumber(0);
            domain.setUpdateTime(DateUtil.date());
            mapper.updateById(domain);
        });
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void sortTop(Long id) {
        LiveCode domain = mapper.selectById(id);
        Integer sort = domain.getSort();
        QueryWrapper<LiveCode> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .le(LiveCode::getSort, sort)
                .eq(LiveCode::getType,domain.getType())
                .ne(LiveCode::getId, domain.getId())
                .orderByDesc(LiveCode::getSort).last("limit 1");
        LiveCode domain1 = mapper.selectOne(queryWrapper);
        if (domain1 != null) {
            Integer sort1 = domain1.getSort();
            if (sort1.equals(sort)) {
                sort1 -= 1;
            }
            domain1.setSort(sort);
            domain.setSort(sort1);
            mapper.updateById(domain);
            mapper.updateById(domain1);
        }
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void sortBottom(Long id) {
        LiveCode domain = mapper.selectById(id);
        Integer sort = domain.getSort();
        QueryWrapper<LiveCode> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .ge(LiveCode::getSort, sort)
                .eq(LiveCode::getType,domain.getType())
                .ne(LiveCode::getId, domain.getId())
                .orderByAsc(LiveCode::getSort).last("limit 1");
        LiveCode domain1 = mapper.selectOne(queryWrapper);
        if (domain1 != null) {
            Integer sort1 = domain1.getSort();
            if (sort1.equals(sort)) {
                sort1 += 1;
            }
            domain1.setSort(sort);
            domain.setSort(sort1);
            mapper.updateById(domain1);
            mapper.updateById(domain);
        }
    }

    @Override
    public void getWechatCode() {
        List<LiveCode> domains = new ArrayList<>();
        List<LiveCode> domainList = mapper.selectList(
                new LambdaQueryWrapper<LiveCode>()
                        .eq(LiveCode::getType,0)
                        .eq(LiveCode::getPlatformType, 2)
                        .eq(LiveCode::getStatus, 0)
                        .eq(LiveCode::getDeleted, 0)
                        .orderByAsc(LiveCode::getSort)
        );

        // 获取是否开启了备用口子开关
        OperationAuto backupConfig = operationAutoService.selectDetailBySystemCode("backup_switch");

        // 开启
        if(backupConfig.getValue().equals("0")){
            // 获取当前所有开启的口子进行检测
            QueryWrapper<LiveCode> domainQueryWrapper = new QueryWrapper<>();
            domainQueryWrapper.lambda()
                    .eq(LiveCode::getType,3)
                    .eq(LiveCode::getPlatformType, 2)
                    .eq(LiveCode::getStatus, 0)
                    .eq(LiveCode::getDeleted, 0);
            List<LiveCode> backupList = mapper.selectList(domainQueryWrapper);
            if (backupList != null && backupList.size() > 0) {
                domains.addAll(backupList);
            }
        }


        domains.addAll(domainList);
        // 检测口子
        if (domains.size() > 0) {

            OperationAuto checkUrlData = operationAutoService.selectDetailBySystemCode("check_url");

            // 删除的公众码数量有多少
            AtomicReference<Integer> number = new AtomicReference<>(0);
            domains.forEach(domain -> {
                    // 调取接口，并异步
                Boolean isCheck = checkDomain(checkUrlData.getValue(),domain.getDomainName());
                // 检测未通过则，删除该数据，并新增一条数据
                if (!isCheck) {
                    domain.setDeleted(1);
                    domain.setUpdateTime(DateUtil.date());
                    domain.setDeleteTime(DateUtil.date());
                    mapper.updateById(domain);
                    if(domain.getType().equals(0)){
                        number.set(number.get() + 1);
                    }
                }
                try {
                    Thread.sleep(200);
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            });

            // 获取当前公共域名队列数量
            OperationAuto operationAuto = operationAutoService.selectDetailBySystemCode("code_queque_number");

            if ((domainList.size() - number.get()) < Integer.valueOf(operationAuto.getValue())) {
                // 开启口子
//                Integer number = Integer.valueOf(operationAuto.getValue()) - domainList.size();
                QueryWrapper<LiveCode> domainQueryWrapper = new QueryWrapper<>();
                domainQueryWrapper.lambda()
                        .eq(LiveCode::getType,0)
                        .eq(LiveCode::getPlatformType, 2)
                        .eq(LiveCode::getStatus, 1)
                        .eq(LiveCode::getDeleted, 0);
                if (domainList.size() > 0) {
                    domainQueryWrapper.lambda().gt(LiveCode::getSort, domainList.get(domainList.size() - 1).getSort());
                }
                domainQueryWrapper.lambda().orderByAsc(LiveCode::getSort).last("limit " + number);
                List<LiveCode> domainList1 = mapper.selectList(domainQueryWrapper);
                if (domainList1 != null && domainList1.size() > 0) {
                    domainList1.stream().forEach(domain -> {
                        domain.setStatus(0);
                        domain.setUpdateTime(DateUtil.date());
                        mapper.updateById(domain);
                    });
                }
            }
        }
    }


    private void checkConnectivity(String httpUrl){
        httpUrl = httpUrl + "/api/detection/checkStatus";
        int timeout = 10000; // 超时时间，单位：毫秒
        // 方式1：GET请求带超时
        try {
            HttpUtil.get(httpUrl, timeout);
        } catch (HttpException e) {
            // 暂停定时器任务,不暂停通知，不异常抛出
            // taskService.pauseTask();
            // 发送通知
            telegramWebhookService.sendWeChatStopMessage();
            //throw new CustomException(ResultCode.ERROR.code(),"接口网络连通有问题");
        }
    }

    private void addDomainStatus(String httpUrl,Integer shellType,Integer count,List<LiveCode> domainList) {
        if (shellType != null) {
            LiveCode domain = mapper.selectOne(
                    new LambdaQueryWrapper<LiveCode>()
                            .eq(LiveCode::getType,0)
                            .eq(LiveCode::getPlatformType, 2)
                            .eq(LiveCode::getStatus, 1)
                            .eq(LiveCode::getDeleted, 0)
                            .orderByAsc(LiveCode::getSort)
                            .last("limit 1")
            );
            if(domain != null){
                Boolean isCheckDomain = checkDomain(httpUrl,domain.getDomainName());
                if(!isCheckDomain){
                    // 如果当前数据未检测通过，则弄一条
                    domain.setDeleted(1);
                    domain.setDeleteTime(DateUtil.date());
                    // 调用重启接口，并还原数据
//                    domainList.add(domain);
//                    count++;
//                    if(count > 4){
//                        // 重启检测，并还原数据
//                        restoreData(httpUrl,domainList);
//                    }
                    mapper.updateById(domain);
                    addDomainStatus(httpUrl,domain.getShellType(),count,domainList);
                } else {
                    domain.setStatus(0);
                    domain.setUpdateTime(DateUtil.date());
                    mapper.updateById(domain);
                }
            }
//            domain.setStatus(0);
//            domain.setUpdateTime(DateUtil.date());
//            mapper.updateById(domain);
//            Boolean isCheckDomain = checkDomain(domain.getDomainName());
//            if(!isCheckDomain){
//                // 如果当前数据未检测通过，则弄一条
//                domain.setDeleted(1);
//                domain.setDeleteTime(DateUtil.date());
//                mapper.updateById(domain);
//                addDomainStatus(domain.getShellType());
//            }
        }
    }

    /**
     * 重启
     * @param domainList
     */
    private void restoreData(String httpUrl,List<LiveCode> domainList) {
        domainList.forEach(domain -> {
            domain.setDeleted(0);
            domain.setUpdateTime(DateUtil.date());
            mapper.updateById(domain);
        });
        // 调用接口还原数据
        restoreADB(httpUrl);
    }


    private void restoreADB(String httpUrl) {
        httpUrl = httpUrl + "/api/detection/restoreADB";
        HttpRequest request = HttpRequest.get(httpUrl);
        request.execute().body();
    }

    @Override
    public Boolean checkDomain(String httpUrl,String url){
        String checkUrl = httpUrl + url;
        HttpRequest request = HttpRequest.get(checkUrl);
        String result = request.execute().body();
        Map<String,String> map = JSON.parseObject(result,Map.class);
        Integer code = MapUtil.get(map,"code",Integer.class);
        if(code.equals(200)){
//            String result1 = MapUtil.get(map,"data",String.class);
//            Map<String,String> resultData = JSON.parseObject(result1,Map.class);
//            Integer isBlocked = MapUtil.get(resultData,"code",Integer.class);
//            if(!isBlocked.equals(200)){
//                return false;
//            }
            return true;
        }
        return false;
    }

    @Override
    public CodeCount selectCodeCount(){
       return mapper.selectCodeCount();
    }

    private Boolean checkWechat(String url){
        String url1 = "https://api.uouin.com/app/wx?username=Yundun001&key=V0Epsqn9vHJkd6t&nodeid=continue&url=" + url;
        String result1= HttpUtil.get(url1);
        Map<String,String> map = JSON.parseObject(result1,Map.class);
        Integer code = MapUtil.get(map,"code",Integer.class);
        if(code != 1001){
            return false;
        }
        return true;
    }

    @Override
    public String responseDomainUrl(){
        RealmName realmName = realmNameMapper.selectOne(
                new LambdaQueryWrapper<RealmName>()
                        .eq(RealmName::getDeleted,0)
                        .eq(RealmName::getStatus,0)
                        .eq(RealmName::getType,2)
        );
        if(realmName == null){
            realmName = realmNameMapper.selectOne(
                    new LambdaQueryWrapper<RealmName>()
                            .eq(RealmName::getDeleted,0)
                            .eq(RealmName::getStatus,1)
                            .eq(RealmName::getType,0)
                            .orderByDesc(RealmName::getCreateTime).last("limit 1")
            );
        }
        if(realmName == null){
            throw new CustomException(ResultCode.ERROR.code(),"未配置落地域名");
        }
        Boolean isCheck = checkWechat(realmName.getDomain());
        if(isCheck){
            if(realmName.getType() == 0 && realmName.getStatus() == 1){
                realmName.setStatus(0);
                realmName.setType(2);
                realmName.setUpdateTime(DateUtil.date());
                realmNameMapper.updateById(realmName);
            }
            return realmName.getDomain();
        } else {
            realmName.setStatus(1);
            realmName.setDeleted(1);
            realmName.setDeleteTime(DateUtil.date());
            realmNameMapper.updateById(realmName);
            //删除当前域名，并查询当前可用域名
            return responseDomainUrl();
        }
    }


    @Override
    public void exportExcelByLiveCode(HttpServletResponse response){

        // 获取所有正在执行中的微信链接

        List<LiveCode> liveCodes = mapper.selectList(
                new LambdaQueryWrapper<LiveCode>()
                        .eq(LiveCode::getStatus,0)
                        .eq(LiveCode::getDeleted,0)
                        .eq(LiveCode::getPlatformType,2)
        );

        StringBuffer text = new StringBuffer();
        for (int i = 1; i < liveCodes.size() + 1; i++) {
            LiveCode liveCode = liveCodes.get(i - 1);
            text.append(liveCode.getDomainName());
            if(i !=0 && i % 10 == 0){
                text.append("\r\n\r\n");
            } else {
                text.append("\r\n");//换行字符
            }
        }

        exportTxt(response,text.toString());
    }

    /* 导出txt文件
     * @author
     * @param	response
     * @param	text 导出的字符串
     * @return
     */
    public void exportTxt(HttpServletResponse response,String text){
        response.setCharacterEncoding("utf-8");
        //设置响应的内容类型
        response.setContentType("text/plain");
        //设置文件的名称和格式
        response.addHeader("Content-Disposition","attachment;filename="
                + genAttachmentFileName( "在线域名", "JSON_FOR_UCC_")//设置名称格式，没有这个中文名称无法显示
                + ".txt");
        BufferedOutputStream buff = null;
        ServletOutputStream outStr = null;
        try {
            outStr = response.getOutputStream();
            buff = new BufferedOutputStream(outStr);
            buff.write(text.getBytes("UTF-8"));
            buff.flush();
            buff.close();
        } catch (Exception e) {
            //LOGGER.error("导出文件文件出错:{}",e);
        } finally {try {
            buff.close();
            outStr.close();
        } catch (Exception e) {
            //LOGGER.error("关闭流对象出错 e:{}",e);
        }
        }
    }

    //原文说这个方法能解决文件中文名乱码问题，但是我实际试了以后中文的文件名依然乱码（文件内容中的中文能正常显示），不知道为什么
    //最后是由前端生成的中文名
    public  String genAttachmentFileName(String cnName, String defaultName) {
        try {
            cnName = new String(cnName.getBytes("gb2312"), "ISO8859-1");
        } catch (Exception e) {
            cnName = defaultName;
        }
        return cnName;
    }
}
