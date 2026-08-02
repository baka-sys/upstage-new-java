package com.aska.logical.service.customer.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.RedisUtil;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.logical.service.record.IAccountPointsRecordService;
import com.aska.repository.entity.*;
import com.aska.repository.mapper.AccountMapper;
import com.aska.repository.mapper.CustomerMapper;
import com.aska.logical.service.customer.ICustomerService;
import com.aska.repository.mapper.CustomerSetupMapper;
import com.aska.repository.mapper.RenewalRecordMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.util.*;

/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements ICustomerService {

    /*用户缓存在线关键字*/
    public static final String REDIS_PREFIX = "UserCache:uid:";

    private final static String CUSTOMER_INFO_SYSTEM = "CUSTOMER_INFO_SYSTEM:";

    @Autowired
    CustomerMapper mapper;

    @Autowired
    RenewalRecordMapper renewalRecordMapper;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    AccountMapper accountMapper;

    @Autowired
    IOperationAutoService autoService;

    @Autowired
    IAccountPointsRecordService accountPointsRecordService;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    CustomerSetupMapper customerSetupMapper;


    /**
     * 卡密列表
     * @param userName
     * @param status
     * @param activeState
     * @param testCard
     * @param accountId
     * @param page
     * @param limit
     * @return
     */
    @Override
    public Page<Customer> selectPageList(String userName, Integer status, Integer activeState, Integer testCard, Long accountId, Integer page, Integer limit){
        Page<Customer> customerPage = new Page<>(page,limit);
        QueryWrapper<Customer> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .and(StrUtil.isNotBlank(userName), e->e.like(Customer::getName,userName).or().like(Customer::getCarmine,userName))
                .eq(status !=null,Customer::getStatus,status).eq(accountId !=null,Customer::getAccountId,accountId)
                .eq(testCard != null,Customer::getTestCard,testCard);
        if(activeState !=null && activeState.equals(3)){
            queryWrapper.lambda().in(Customer::getActiveState,1,3).lt(Customer::getExpirationDate, DateUtil.date());
        } else {
            if(activeState !=null && activeState == 1){
                queryWrapper.lambda().eq(Customer::getActiveState,activeState).ge(Customer::getExpirationDate,DateUtil.date());
            } else {
                queryWrapper.lambda().eq(activeState != null,Customer::getActiveState,activeState);
            }
        }
        queryWrapper.lambda().orderByDesc(Customer::getCreateTime).select(
                Customer::getCarmine,
                Customer::getStatus,
                Customer::getLoginTime,
                Customer::getExpirationDate,
                Customer::getActiveState,
                Customer::getCreateTime,
                Customer::getTestCard
        );
        Page<Customer> customerPage1 = mapper.selectPage(customerPage,queryWrapper);
        if(!customerPage1.getRecords().isEmpty() && customerPage1.getRecords().size() >0){
            customerPage1.getRecords().stream().forEach(customer -> {
                if(customer.getActiveState().equals(1) && customer.getExpirationDate().before(DateUtil.date())){
                    customer.setActiveState(3);
                }
            });
        }
        return customerPage1;
    }


    @Override
    public void switchStatus(Long id, Integer status){
        Customer customer = mapper.selectById(id);
        if(customer == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        customer.setStatus(status);
        customer.setUpdateTime(DateUtil.date());
        mapper.updateById(customer);
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchFreeze(String carmines){
        List<String> carmineList = Arrays.asList(carmines.split(","));
        if(carmineList == null || carmineList.size() == 0){
            throw new CustomException(ResultCode.ERROR.code(),"卡密不能为空");
        }
        carmineList.stream().forEach(carmine->{
            Customer customer = mapper.selectOne(new LambdaQueryWrapper<Customer>().eq(Customer::getCarmine,carmine));
            if(customer == null){
                throw new CustomException(ResultCode.ERROR.code(),carmine + "该卡密数据不存在");
            }
            customer.setStatus(1);
            customer.setUpdateTime(DateUtil.date());
            mapper.updateById(customer);
        });
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchRenew(String carmines, Double days, Integer maxNumber, Long accountId){
        if(days <=0){
            throw new CustomException(ResultCode.COIN_IS_VALID);
        }
        List<String> carmineList = Arrays.asList(carmines.split(","));
        if(carmineList == null || carmineList.size() == 0){
            throw new CustomException(ResultCode.ERROR.code(),"卡密不能为空");
        }
        carmineList.stream().forEach(carmine->{
            Customer customer = mapper.selectOne(
                    new LambdaQueryWrapper<Customer>()
                            .eq(Customer::getCarmine,carmine)
                            .ne(Customer::getActiveState,2)
            );
            if(customer == null){
                throw new CustomException(ResultCode.ERROR.code(),"卡密不存在" + carmine);
            }
            // 插入续费记录
            RenewalRecord rr = new RenewalRecord();
            rr.setExpirationDate(customer.getExpirationDate());
            rr.setUserId(customer.getId());
            rr.setAccountId(accountId);
            //rr.setCarmine(carmine);
            rr.setType(1);
            rr.setDays(days);
            rr.setCreateTime(DateUtil.date());
            renewalRecordMapper.insert(rr);
            Integer second = (int) (days * 24 * 60 * 60);
            // 续费该卡到其他的卡密上
            Date expirationDate;
            if(customer.getExpirationDate() == null){
                customer.setDays(customer.getDays() + days);
            } else {
                if (customer.getExpirationDate().before(DateUtil.date())) {
                    expirationDate = DateUtil.offsetSecond(DateUtil.date(), second);
                } else {
                    expirationDate = DateUtil.offsetSecond(customer.getExpirationDate(), second);
                }
                customer.setExpirationDate(expirationDate);
            }
            customer.setUpdateTime(DateUtil.date());
            customer.setMaxNumber(customer.getMaxNumber() + maxNumber);
            //user.setActiveState(1);

            mapper.updateById(customer);

            // 清除客户的redis
            redisUtil.delete(CUSTOMER_INFO_SYSTEM + customer.getId());
        });
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void generateCardPassword(Integer lines, Long id, String password, Double days, Integer testCard, String prefixString, HttpServletResponse response, Boolean isMode, Integer qrcodeSwitch, Integer maxNumber, Integer isSearch) throws IOException {

        if(days <=0){
            throw new CustomException(ResultCode.COIN_IS_VALID);
        }

        List<String> passwords = new ArrayList<>();
        // 查看当前积分是否够，不够则提示需要充值
        if(isMode){
            Account account = accountMapper.selectById(id);
            OperationAuto operationAuto = autoService.selectDetailBySystemCode("buy_account_points");
            Double points = Double.parseDouble(operationAuto.getValue());
            Double totalPoints = points * days * lines;
            if( totalPoints > account.getPoints()) {
                throw new CustomException(ResultCode.POINTS_IS_ENOUGH);
            }
            // 插入积分扣除记录,如果是测试卡则不需要扣除积分
            if(testCard == 0){
                AccountPointsRecord accountPointsRecord = new AccountPointsRecord();
                accountPointsRecord.setAccountId(id);
                accountPointsRecord.setPoints(totalPoints);
                accountPointsRecord.setBeforeOperation(account.getPoints());
                accountPointsRecord.setAfterOperation(account.getPoints()-totalPoints);
                accountPointsRecord.setType(2);
                accountPointsRecord.setCreateTime(DateUtil.date());
                accountPointsRecordService.add(accountPointsRecord);
                account.setPoints(accountPointsRecord.getAfterOperation());
                account.setUpdateTime(DateUtil.date());
                accountMapper.updateById(account);
            }
        }

        if(testCard == 1){
            if(days > 0.04){
                throw new CustomException(ResultCode.DAYS_IS_MORE_THEN);
            }
        }

        for(int i = 0; i < lines; i++){
            Customer customer = new Customer();
            String userKey = DigestUtil.md5Hex(UUID.randomUUID().toString().replace("-",""));
            customer.setAccountId(id);
            customer.setMaxNumber(maxNumber);
            customer.setCreateTime(DateUtil.date());
            customer.setTestCard(testCard);
            customer.setIsSearch(isSearch);
            //user.setName(RandomNameUtil.randomName(false,4));
            customer.setName("在线客服");
            // 添加密码
            if(StrUtil.isNotBlank(password)){
                customer.setPassword(passwordEncoder.encode(password));
            }
            customer.setName("在线客服");
            customer.setUserAccount(userKey.substring(0,16).concat(String.valueOf(i)));
            String carmine = StrUtil.isNotBlank(prefixString) ? prefixString + "-" + maxNumber + DigestUtil.md5Hex(userKey).substring(0,16) : DigestUtil.md5Hex(userKey).substring(0,16);
            passwords.add(carmine);
            customer.setCarmine(carmine);

            // 添加到期时间
            //user.setExpirationDate(DateUtil.offsetDay(DateUtil.date(),days));
            customer.setDays(days);
            mapper.insert(customer);

            CustomerSetup customerSetup = new CustomerSetup();
            customerSetup.setUserId(customer.getId());
            if(qrcodeSwitch != null){
                customerSetup.setQrcodeSwitch(qrcodeSwitch);
            }
            customerSetup.setCreateTime(DateUtil.date());
            customerSetupMapper.insert(customerSetup);
        }

        StringBuffer text = new StringBuffer();
        for (int i = 1; i < passwords.size() + 1; i++) {
            String carmine = passwords.get(i - 1);
            text.append(carmine);
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
                + genAttachmentFileName( "卡密列表", "JSON_FOR_UCC_")//设置名称格式，没有这个中文名称无法显示
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
