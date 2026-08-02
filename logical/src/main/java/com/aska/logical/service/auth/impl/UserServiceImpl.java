package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import cn.hutool.json.JSONUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.CovertUtil;
import com.aska.common.util.JwtUtil;
import com.aska.common.util.RedisUtil;
import com.aska.logical.service.auth.*;
import com.aska.logical.service.common.IScanQrcodeService;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.logical.service.customer.IEntryRatioService;
import com.aska.logical.service.record.IAccountPointsRecordService;
import com.aska.logical.service.record.StoreMessageService;
import com.aska.repository.entity.*;
import com.aska.repository.mapper.*;
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
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;


/**
 * <p>
 * 用户表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    /*用户缓存在线关键字*/
    public static final String REDIS_PREFIX = "UserCache:uid:";

    private final static String USER_INFO_SYSTEM = "USER_INFO_SYSTEM";

    @Autowired
    UserMapper mapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    AccountMapper accountMapper;

    @Autowired
    ISayHelloService sayHelloService;

    @Autowired
    IMassService massService;

    @Autowired
    IQuickReplyService replyService;

    @Autowired
    IRenewalRecordService renewalRecordService;

    @Autowired
    IOperationAutoService autoService;

    @Autowired
    IAccountPointsRecordService accountPointsRecordService;

    @Autowired
    UrlMapper urlMapper;

    @Autowired
    UserSetupMapper userSetupMapper;

    @Autowired
    UserOnlineStatusMapper userOnlineStatusMapper;

    @Autowired
    FriendMapper friendMapper;

    @Autowired
    ChatSessionMapper chatSessionMapper;

    @Autowired
    ChatSessionSonMapper chatSessionSonMapper;

    @Autowired
    UserCountMapper userCountMapper;

    @Autowired
    StoreMessageService storeMessageService;

    @Autowired
    LiveCodeMapper liveCodeMapper;

    @Autowired
    IpAddressMapper ipAddressMapper;

    @Autowired
    DomainMapper domainMapper;

    @Autowired
    RenewalRecordMapper renewalRecordMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    IScanQrcodeService scanQrcodeService;

    @Autowired
    LiveCodeNumberMapper liveCodeNumberMapper;

    @Autowired
    IEntryRatioService entryRatioService;

    @Autowired
    UserLogsMapper userLogsMapper;

    @Autowired
    private SayHelloMapper sayHelloMapper;

    @Autowired
    private QuickReplyMapper quickReplyMapper;

    @Autowired
    private AskedQuestionsSonMapper askedQuestionsSonMapper;

    @Autowired
    private AutoReplyMapper autoReplyMapper;

    @Autowired
    private FallbackResponseMapper fallbackResponseMapper;

    @Override
    public Page<User> selectPageList(String userName, Integer status,Integer activeState,Integer testCard,Integer pastDue, Long accountId, Integer page, Integer limit){
        Page<User> userPage = new Page<>(page,limit);
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(User::getType,1)
                .and(StrUtil.isNotBlank(userName), e->e.like(User::getName,userName).or().like(User::getCarmine,userName))
                .eq(status !=null,User::getStatus,status).eq(accountId !=null,User::getAccountId,accountId)
                .eq(testCard != null,User::getTestCard,testCard);
        if(activeState !=null && activeState.equals(3)){
            queryWrapper.lambda().in(User::getActiveState,1,3).lt(User::getExpirationDate,DateUtil.date());
        } else {
            if(activeState !=null && activeState == 1){
                queryWrapper.lambda().eq(User::getActiveState,activeState).ge(User::getExpirationDate,DateUtil.date());
            } else {
                queryWrapper.lambda().eq(activeState != null,User::getActiveState,activeState);
            }
        }
        queryWrapper.lambda().orderByDesc(User::getCreateTime).select(
                User::getCarmine,
                User::getStatus,
                User::getLoginTime,
                User::getExpirationDate,
                User::getActiveState
        );
        Page<User> userPage1 = mapper.selectPage(userPage,queryWrapper);
        if(!userPage1.getRecords().isEmpty() && userPage1.getRecords().size() >0){
            userPage1.getRecords().stream().forEach(user -> {
               if(user.getActiveState().equals(1) && user.getExpirationDate().before(DateUtil.date())){
                   user.setActiveState(3);
               }
            });
        }
        return userPage1;
    }

    @Override
    public Page<User> selectOnlinePageList(String userName, Integer status, Integer testCard, Long accountId, Integer page, Integer limit){
        Page<User> userPage = new Page<>(page,limit);
        // 获取客户在线数据
        List<UserOnlineStatus> userOnlineStatuses = userOnlineStatusMapper.selectList(
                new LambdaQueryWrapper<UserOnlineStatus>().eq(UserOnlineStatus::getType,1)
                        .eq(UserOnlineStatus::getStatus,1)
        );
//        if(userOnlineStatuses.size() == 0){
//            return null;
//        }
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(User::getType,1)
                .and(StrUtil.isNotBlank(userName), e->e.like(User::getName,userName).or().like(User::getCarmine,userName))
                .eq(status !=null,User::getStatus,status).eq(accountId !=null,User::getAccountId,accountId)
                .eq(User::getTestCard,0)
                .in(userOnlineStatuses.size() > 0,User::getId,userOnlineStatuses.stream().map(UserOnlineStatus::getUserId).collect(Collectors.toList()))
                .eq(userOnlineStatuses.size() == 0,User::getId,0);
        Page<User> userPage1 = mapper.selectPage(userPage,queryWrapper);
        if(userPage1.getRecords().size() > 0){
            userPage1.getRecords().stream().forEach(user -> {
                // 查询今日新增人数
                Integer number = mapper.selectUserTodayCountBy(user.getId());
                user.setNumber(number);

                Integer totalNumber = mapper.selectUserCountBy(user.getId());

                user.setTotalNumber(totalNumber);
            });
        }
        return userPage1;
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void add(User user,Long accountId){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(User::getType,1).and(
                e->e.eq(User::getUserAccount,user.getUserAccount()).or().eq(User::getPhoneNumber,user.getPhoneNumber()));
        User user1 = mapper.selectOne(queryWrapper);
        if(user1 != null){
            throw new CustomException(ResultCode.ACCOUNT_INFO_IS_FOUND);
        }

        if(user.getDays() <= 0.00){
            throw new CustomException(ResultCode.COIN_IS_VALID);
        }

        Account account = accountMapper.selectById(accountId);
        // 查看当前积分是否够，不够则提示需要充值
        OperationAuto operationAuto = autoService.selectDetailBySystemCode("buy_account_points");
        Double points = Double.parseDouble(operationAuto.getValue());
        Double totalPoints = points * user.getDays();
        if( totalPoints > account.getPoints()){
            throw new CustomException(ResultCode.POINTS_IS_ENOUGH);
        }
        // 插入积分扣除记录
        AccountPointsRecord accountPointsRecord = new AccountPointsRecord();
        accountPointsRecord.setAccountId(accountId);
        accountPointsRecord.setPoints(totalPoints);
        accountPointsRecord.setBeforeOperation(account.getPoints());
        accountPointsRecord.setAfterOperation(account.getPoints()-totalPoints);
        accountPointsRecord.setCreateTime(DateUtil.date());
        accountPointsRecord.setType(2);
        accountPointsRecordService.add(accountPointsRecord);

        account.setPoints(accountPointsRecord.getAfterOperation());
        account.setUpdateTime(DateUtil.date());
        accountMapper.updateById(account);

        String userKey = DigestUtil.md5Hex(UUID.randomUUID().toString().replace("-",""));
        // 设置用户访问唯一编码
        user.setUserKey(userKey);
        user.setType(1);
        user.setAccountId(accountId);
        user.setCreateTime(DateUtil.date());
        String carmine = DigestUtil.md5Hex(userKey).substring(0,16);
        user.setCarmine(carmine);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        mapper.insert(user);
    }

    @Override
    public void switchStatus(Long id, Integer status){
        User user = mapper.selectById(id);
        if(user == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        user.setStatus(status);
        user.setUpdateTime(DateUtil.date());
        mapper.updateById(user);
    }


    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchFreeze(String carmines){
        List<String> carmineList = Arrays.asList(carmines.split(","));
        if(carmineList == null || carmineList.size() == 0){
            throw new CustomException(ResultCode.ERROR.code(),"卡密不能为空");
        }
        carmineList.stream().forEach(carmine->{
            User user = mapper.selectOne(new LambdaQueryWrapper<User>().eq(User::getCarmine,carmine));
            if(user == null){
                throw new CustomException(ResultCode.ERROR.code(),carmine + "该卡密数据不存在");
            }
            user.setStatus(1);
            user.setUpdateTime(DateUtil.date());
            mapper.updateById(user);
        });
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchRenew(String carmines, Double days,Integer maxNumber,Long accountId){
        if(days <=0){
            throw new CustomException(ResultCode.COIN_IS_VALID);
        }
        List<String> carmineList = Arrays.asList(carmines.split(","));
        if(carmineList == null || carmineList.size() == 0){
            throw new CustomException(ResultCode.ERROR.code(),"卡密不能为空");
        }
        carmineList.stream().forEach(carmine->{
            User user = mapper.selectOne(
                    new LambdaQueryWrapper<User>()
                            .eq(User::getCarmine,carmine)
                            .eq(User::getType,1)
                            .ne(User::getActiveState,2)
            );
            if(user == null){
                throw new CustomException(ResultCode.ERROR.code(),"卡密不存在" + carmine);
            }
            // 插入续费记录
            RenewalRecord rr = new RenewalRecord();
            rr.setExpirationDate(user.getExpirationDate());
            rr.setUserId(user.getId());
            rr.setAccountId(accountId);
            //rr.setCarmine(carmine);
            rr.setType(1);
            rr.setDays(days);
            rr.setCreateTime(DateUtil.date());
            renewalRecordMapper.insert(rr);
            Integer second = (int) (days * 24 * 60 * 60);
            // 续费该卡到其他的卡密上
            Date expirationDate;
            if(user.getExpirationDate() == null){
                user.setDays(user.getDays() + days);
            } else {
                if (user.getExpirationDate().before(DateUtil.date())) {
                    expirationDate = DateUtil.offsetSecond(DateUtil.date(), second);
                } else {
                    expirationDate = DateUtil.offsetSecond(user.getExpirationDate(), second);
                }
                user.setExpirationDate(expirationDate);
            }
            user.setUpdateTime(DateUtil.date());
            user.setMaxNumber(user.getMaxNumber() + maxNumber);
            //user.setActiveState(1);

            userMapper.updateById(user);

            redisUtil.delete(USER_INFO_SYSTEM + user.getUserKey());
        });
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void generateCardPassword(Integer lines,Long id,String password,Double days,Integer testCard,String prefixString, HttpServletResponse response,Boolean isMode,Integer shellType,Integer qrcodeSwitch,Integer maxNumber,Integer isSearch) throws IOException {

        if(days <=0){
            throw new CustomException(ResultCode.COIN_IS_VALID);
        }

        List<String> passwords = new ArrayList<>();
        List<User> users = new ArrayList<>();
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
           User user = new User();
           String userKey = DigestUtil.md5Hex(UUID.randomUUID().toString().replace("-",""));
           user.setUserKey(userKey);
           user.setType(1);
           user.setAccountId(id);
           user.setMaxNumber(maxNumber);
           user.setCreateTime(DateUtil.date());
           user.setTestCard(testCard);
           user.setShellType(shellType);
           user.setIsSearch(isSearch);
           //user.setName(RandomNameUtil.randomName(false,4));
           user.setName("在线客服");
           // 添加密码
           if(StrUtil.isNotBlank(password)){
               user.setPassword(passwordEncoder.encode(password));
           }
           user.setName("在线客服");
           user.setUserAccount(userKey.substring(0,16).concat(String.valueOf(i)));
           String carmine = StrUtil.isNotBlank(prefixString) ? prefixString + "-" + maxNumber + DigestUtil.md5Hex(userKey).substring(0,16) : DigestUtil.md5Hex(userKey).substring(0,16);
           passwords.add(carmine);
           user.setCarmine(carmine);

           // 添加到期时间
           //user.setExpirationDate(DateUtil.offsetDay(DateUtil.date(),days));
            user.setDays(days);
            mapper.insert(user);

            //批量生成配置项
            UserSetup userSetup = new UserSetup();
            userSetup.setUserId(user.getId());
            if(qrcodeSwitch != null){
                userSetup.setQrcodeSwitch(qrcodeSwitch);
            }
            userSetup.setCreateTime(DateUtil.date());
            userSetupMapper.insert(userSetup);
//           users.add(user);
        }
//        this.saveBatch(users);

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

//        List<String> dataList = passwords;
//        String fileName = "output.txt";
//        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName), StandardCharsets.UTF_8))) {
//            for (String line : dataList) {
//                writer.write(line);
//                writer.newLine(); // 新的一行
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

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

    @Override
    public LoginInfo login(String userAccount, String password){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(User::getUserAccount,userAccount).eq(User::getStatus,0).ne(User::getActiveState,2);
        User user = mapper.selectOne(queryWrapper);
        if(user == null){
            throw new CustomException(ResultCode.ACCOUNT_INFO_IS_FOUND);
        }
        if(!passwordEncoder.matches(password,user.getPassword())){
            throw new CustomException(ResultCode.USER_INFO_NOT_PASSWORD_ERROR);
        }

        if(user.getActiveState() == 0){
            // 卡密未激活则生成过期时间
            Integer second = (int) (user.getDays() * 24 * 60 * 60);
            user.setExpirationDate(DateUtil.offsetSecond(DateUtil.date(),second));
            user.setActiveState(1);
            user.setUpdateTime(DateUtil.date());
            mapper.updateById(user);

        } else {
            // 卡密已激活,判断过期时间
            if(DateUtil.date().isAfter(user.getExpirationDate())){
                throw new CustomException(ResultCode.USER_ACCOUNT_IS_EXPIRE);
            }
        }


        UserToken userToken = new UserToken();
        userToken.setId(user.getId());
        userToken.setUserName(user.getName());
        String token = JwtUtil.generateToken(JSONUtil.toJsonStr(userToken));
        String refreshToken = DigestUtil.md5Hex(token);
        userToken.setMd5TokenStr(DigestUtil.md5Hex(token));
        //延迟半个小时刷新token
        userToken.setExpiresAt(DateUtil.offsetMinute(DateUtil.date(), JwtUtil.REDIS_EXPIRE_MINUTES));
        // 存入redis中并返回
        LocalDateTime issueAt = LocalDateTime.now();
        LocalDateTime expireAt = issueAt.plusSeconds(TimeUnit.MINUTES.toSeconds(JwtUtil.REDIS_EXPIRE_MINUTES));
        int expireSeconds = (int) Duration.between(issueAt, expireAt).getSeconds();
        redisUtil.set(userToken.getMd5TokenStr(),JSONUtil.toJsonStr(userToken),expireSeconds);
        LoginInfo loginInfo = new LoginInfo();
        loginInfo.setToken(token);
        loginInfo.setRefreshToken(refreshToken);
        return loginInfo;
    }


    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void updateUserSpeech(Long id, String userIds, Integer isRemove, String functionIds){
        Account account = accountMapper.selectById(id);
        if(account == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        // 获取用户id集合
        List<Long> userSet = CovertUtil.covertLongList(functionIds);

        if(userSet == null && userSet.size() == 0){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }

        if(StrUtil.isNotBlank(functionIds)){

            List<Integer> functionIds1 = CovertUtil.covertIntegerList(functionIds);

            //个人信息复制
            if(functionIds1.indexOf(1) >= 0 || functionIds1.indexOf(5)>=0){
                User user = new User();
                if(functionIds1.indexOf(1) >= 0){
                    user.setImg(user.getImg());
                }
                if(functionIds1.indexOf(5) >= 0){
                    user.setName(user.getName());
                }
                user.setUpdateTime(DateUtil.date());
                mapper.update(user,new LambdaQueryWrapper<User>().eq(User::getId,userSet));
            }
            // 复制打招呼内容
            if(functionIds1.indexOf(2) >=0){
                sayHelloService.addSayHello(id,userSet,isRemove);
            }

            // 复制快捷回复内容
            if(functionIds1.indexOf(3) >=0){
                replyService.addReply(id,userSet,isRemove);
            }

            // 复制群发内容
            if(functionIds1.indexOf(4) >=0){
                massService.addMass(id,userSet,isRemove);
            }
        }
    }

    @Override
    public List<Long> selectCustomerByAccountId(Long id){
        Date operationTime = DateUtil.parseDate(DateUtil.today());
        List<User> userList = mapper.selectList(new QueryWrapper<User>().lambda().eq(id!=null,User::getAccountId,id).ge(User::getExpirationDate,DateUtil.format(operationTime,"yyyy-MM-dd")));
        return userList.stream().map(User::getId).collect(Collectors.toList());
    }


    @Override
    public CustomerCount selectUserCountByAccountId(Long id){
        // 正常卡的统计数据
        CustomerCount customerCount = mapper.selectUserCountByAccountId(id);

        // 统计今日进人的总人数
        String nowDate = DateUtil.today();
        Integer userCount = mapper.selectUserCountByS(nowDate);
        customerCount.setUserLoginTotal(userCount);
        // 获取今日登录过的商户
        Long count = userOnlineStatusMapper.selectUserOnlineStatus(id);
        customerCount.setUseTotal(Math.toIntExact(count));
        // 获取今日开卡数量
        Integer stateCount = mapper.selectCountState(nowDate);
        customerCount.setCustomerOnlineTotal(stateCount);

        Double days = renewalRecordService.selectTodayCountDays(id);
        customerCount.setRechargedDays(days);
        return customerCount;
    }


    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void renewUserByDays(Long id, Long userId, Double days){
        Account account = accountMapper.selectById(id);
        if(account == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        User user = mapper.selectById(userId);
        if(user == null ||!account.getId().equals(user.getAccountId())){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        if(user.getExpirationDate() == null){
            user.setDays(user.getDays() + days);
        } else {
            Integer second = (int) (days * 24 * 60 * 60);
            user.setExpirationDate(DateUtil.offsetSecond(user.getExpirationDate(),second));
        }
        mapper.updateById(user);
        // 插入积分扣除记录
        OperationAuto operationAuto = autoService.selectDetailBySystemCode("buy_account_points");
        Double points = Double.parseDouble(operationAuto.getValue());
        Double totalPoints = days * points;
        AccountPointsRecord accountPointsRecord = new AccountPointsRecord();
        accountPointsRecord.setAccountId(id);
        accountPointsRecord.setPoints(days * points);
        accountPointsRecord.setBeforeOperation(account.getPoints());
        accountPointsRecord.setAfterOperation(account.getPoints() - totalPoints);
        accountPointsRecord.setType(2);
        accountPointsRecord.setCreateTime(DateUtil.date());
        accountPointsRecordService.add(accountPointsRecord);

        account.setPoints(accountPointsRecord.getAfterOperation());
        account.setUpdateTime(DateUtil.date());
        accountMapper.updateById(account);

        // 插入客服充值记录
        RenewalRecord renewalRecord = new RenewalRecord();
        renewalRecord.setAccountId(id);
        renewalRecord.setUserId(userId);
        renewalRecord.setType(1);
        renewalRecord.setDays(days);
        renewalRecord.setCreateTime(DateUtil.date());
        renewalRecordService.addRenewalRecord(renewalRecord);
    }

    @Override
    public List<String> selectUrlByUserId(Long userId){
        List<String> showUrls = new ArrayList<>();
        User user = mapper.selectById(userId);
        if(user != null){
            //客户绑定的域名
            List<Url> urls = urlMapper.selectList(
                    new QueryWrapper<Url>().lambda()
                            .eq(Url::getUserId,user.getId())
                            .eq(Url::getAccountType,0)
                            .select(Url::getUrl)
            );
            showUrls.addAll(urls.stream().map(Url::getUrl).collect(Collectors.toList()));
            // 查询主账号是否绑定了域名
            List<Url> urls1 = urlMapper.selectList(
                    new QueryWrapper<Url>().lambda()
                            .eq(Url::getUserId,user.getAccountId())
                            .eq(Url::getAccountType,1)
                            .select(Url::getUrl)
            );
            urls1.forEach(s->{
                s.setUrl(s.getUrl() + "/" + user.getUserKey());
            });
            showUrls.addAll(urls1.stream().map(Url::getUrl).collect(Collectors.toList()));
        }

        if(showUrls.size() == 0){
            // 查询用户主域名
            OperationAuto operationAuto = autoService.selectDetailBySystemCode("main_url");
            showUrls.add(operationAuto.getValue() + "/" +  user.getUserKey());
        }

        return showUrls;
    }


    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void cardExpired(){
        //查询已经过期的卡密
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(User::getType,1)
                .eq(User::getTestCard,0)
                .eq(User::getActiveState,1)
                .le(User::getExpirationDate,DateUtil.date());
        List<User> users = mapper.selectList(queryWrapper);

        // 过期之后修改卡密过期状态
        if(users.size() > 0){
            users.stream().forEach(user -> {
                user.setActiveState(3);
                user.setUpdateTime(DateUtil.date());
                mapper.updateById(user);
                // 删除活码的占坑数量
                LiveCodeNumber liveCodeNumber = liveCodeMapper.selectByUserId(user.getId());
                if(liveCodeNumber != null){
                    domainMapper.delete(new QueryWrapper<Domain>().lambda().eq(Domain::getUserId,user.getId()));
                    liveCodeNumber.setNumber(liveCodeNumber.getNumber() - 1);
                    liveCodeNumberMapper.updateById(liveCodeNumber);
                }
            });
        }
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void clearRecord(){


        // 截断活码表，并修改所有number 不为 0 的数据
        domainMapper.truncateTable();

        // 修改cs_live_code_number表
        LiveCodeNumber liveCodeNumber = new LiveCodeNumber();
        liveCodeNumber.setNumber(0);
        liveCodeNumber.setUpdateTime(DateUtil.date());
        liveCodeNumberMapper.update(liveCodeNumber,
                new LambdaQueryWrapper<LiveCodeNumber>().gt(LiveCodeNumber::getNumber,0)
        );

        // 清除用户信息
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(User::getType,0)
                .lt(User::getLoginTime,DateUtil.offsetDay(DateUtil.date(), -7));
        userMapper.delete(queryWrapper);

        // 清除cs_chat_session数据
        chatSessionMapper.delete(new LambdaQueryWrapper<ChatSession>().lt(ChatSession::getUpdateTime,DateUtil.offsetDay(DateUtil.date(), -7).getTime()));

        // 清除cs_chat_session_son 数据
        chatSessionSonMapper.delete(
                new LambdaQueryWrapper<ChatSessionSon>().lt(ChatSessionSon::getSendTime,DateUtil.offsetDay(DateUtil.date(), -7).getTime()));

        // 清除cs_friend 数据
        friendMapper.delete(new LambdaQueryWrapper<Friend>().lt(Friend::getUpdateTime,DateUtil.offsetDay(DateUtil.date(), -7)));

        // 清除cs_user_count 数据
        userCountMapper.delete(new QueryWrapper<UserCount>().lambda().lt(UserCount::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -7)));

        // 清除cs_user_online_status 数据
        userOnlineStatusMapper.delete(new LambdaQueryWrapper<UserOnlineStatus>().lt(UserOnlineStatus::getUpdateTime,DateUtil.offsetDay(DateUtil.date(), -7)));

        // 清除7天以前的日志数据
        userLogsMapper.delete(new LambdaQueryWrapper<UserLogs>().lt(UserLogs::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -7)));

        // 清除7天以前的快捷回复，打招呼，自动回复，群发，常见问答
        // 清除30天以前的卡密数据
//        QueryWrapper<User> queryWrapper1 = new QueryWrapper<>();
//        queryWrapper1.lambda().eq(User::getType,1)
//                .eq(User::getActiveState,1)
//                .lt(User::getLoginTime,DateUtil.offsetDay(DateUtil.date(), -30))
//                .last("and login_time is not null");
//        userMapper.delete(queryWrapper1);

        // 清除30天以前充值的卡密
//        QueryWrapper<User> queryWrapper2 = new QueryWrapper<>();
//        queryWrapper2.lambda().eq(User::getType,1)
//                .eq(User::getActiveState,2)
//                .lt(User::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -30));
//        userMapper.delete(queryWrapper2);

        // 清除30天以前用户配置信息
        //userSetupMapper.delete(new LambdaQueryWrapper<UserSetup>().lt(UserSetup::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -30)));

        // 清除30天以前打招呼的数据
        sayHelloMapper.delete(new LambdaQueryWrapper<SayHello>().lt(SayHello::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -30)));

        // 清除30天以前快捷回复内容
        quickReplyMapper.delete(new LambdaQueryWrapper<QuickReply>().lt(QuickReply::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -30)));

        // 清除30天以前的常见问答内容
        askedQuestionsSonMapper.delete(new LambdaQueryWrapper<AskedQuestionsSon>().lt(AskedQuestionsSon::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -30)));

        // 清除30天以前的自动回复内容
        autoReplyMapper.delete(new LambdaQueryWrapper<AutoReply>().lt(AutoReply::getCreateTime,DateUtil.offsetDay(DateUtil.date(), -30)));

        // 清除30以前的兜底回复内容
        fallbackResponseMapper.delete(new LambdaQueryWrapper<FallbackResponse>().lt(FallbackResponse::getCreateTime, DateUtil.offsetDay(DateUtil.date(), -30)));

        // 清除聊天记录数据
        storeMessageService.deleteChatHistory();

    }


    // 今日激活
    @Override
    public Page<User> selectActivePage(String carmine, String keywords, Integer page, Integer limit){
        Page<User> page1 = new Page<>(page,limit);

        QueryWrapper<User> queryWrapper = new QueryWrapper<>();

        queryWrapper.like(StrUtil.isNotBlank(carmine),"a.carmine",carmine);

        queryWrapper.like(StrUtil.isNotBlank(keywords),"b.content",keywords);

        queryWrapper.eq("a.type",1);

        queryWrapper.eq("a.test_card",0);

        // 过期时间大于当前时间
        queryWrapper.gt("a.expiration_date",DateUtil.date());

        queryWrapper.last(" and a.expiration_date is not null group by a.id order by a.active_time desc");

        Page<User> userPage = mapper.selectActivePage(page1,queryWrapper);

        // 获取打招呼列表
        if(!userPage.getRecords().isEmpty()){
            userPage.getRecords().forEach(user -> {
                // 获取打招呼
                List<SayHello> sayHellos = sayHelloService.getList(user.getId(),0);
                user.setSayHellos(sayHellos);

                // 获取劫持比例配置
                EntryRatio entryRatio = entryRatioService.selectOneById(user.getId());

                user.setEntryRatio(entryRatio);

                UserSetup userSetup = userSetupMapper.selectOne(new LambdaQueryWrapper<UserSetup>().eq(UserSetup::getUserId,user.getId()));
                UserCountData userCountData = null;
                if(userSetup != null){
                    userCountData = userCountMapper.selectCountDataByIpAddress(
                            user.getId(),
                            userSetup.getDomesticSwitch() == 0 ? null : 1,
                            userSetup.getSecondsSwitch() == 0 ? null : 1,
                            userSetup.getCountSwitch() == 0 ? null : 1,
                            userSetup.getIpNumber(),
                            userSetup.getStopSwitch() == 0 ? null : 1,
                            userSetup.getStopTimeNumber(),
                            userSetup.getWechatSwitch() == 0 ? null : 1
                    );
                }
                user.setTodayTotal(userCountData == null ? 0 : userCountData.getTodayTotal());
            });
        }

        return userPage;
    }


    @Override
    public Page<User> selectRenewPage(String carmine, String keywords, Integer page, Integer limit){
        Page<User> page1 = new Page<>(page,limit);

        QueryWrapper<User> queryWrapper = new QueryWrapper<>();

        queryWrapper.like(StrUtil.isNotBlank(carmine),"b.carmine",carmine);

        queryWrapper.like(StrUtil.isNotBlank(keywords),"c.content",keywords);

        queryWrapper.eq("b.type",1);

        queryWrapper.eq("b.test_card",0);

        queryWrapper.eq("left(a.create_time,10)",DateUtil.today());

        queryWrapper.last(" group by a.user_id order by a.create_time desc");

        Page<User> userPage = mapper.selectRenewPage(page1,queryWrapper);

        // 获取打招呼列表
        if(!userPage.getRecords().isEmpty()){
            userPage.getRecords().forEach(user -> {
                // 获取打招呼
                List<SayHello> sayHellos = sayHelloService.getList(user.getId(),0);
                user.setSayHellos(sayHellos);

                // 获取劫持比例配置
                EntryRatio entryRatio = entryRatioService.selectOneById(user.getId());

                user.setEntryRatio(entryRatio);

                UserSetup userSetup = userSetupMapper.selectOne(new LambdaQueryWrapper<UserSetup>().eq(UserSetup::getUserId,user.getId()));
                UserCountData userCountData = userCountMapper.selectCountDataByIpAddress(
                        user.getId(),
                        userSetup.getDomesticSwitch() == 0 ? null : 1,
                        userSetup.getSecondsSwitch() == 0 ? null : 1,
                        userSetup.getCountSwitch() == 0 ? null : 1,
                        userSetup.getIpNumber(),
                        userSetup.getStopSwitch() == 0 ? null : 1,
                        userSetup.getStopTimeNumber(),
                        userSetup.getWechatSwitch() == 0 ? null : 1
                );
                user.setTodayTotal(userCountData == null ? 0 : userCountData.getTodayTotal());
            });
        }

        return userPage;
    }








}
