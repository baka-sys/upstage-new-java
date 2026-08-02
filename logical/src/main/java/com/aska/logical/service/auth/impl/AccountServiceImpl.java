package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.digest.DigestUtil;
import cn.hutool.json.JSONUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.JwtUtil;
import com.aska.common.util.RandomNameUtil;
import com.aska.common.util.RedisUtil;
import com.aska.logical.service.auth.IAccountService;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.logical.service.record.IAccountPointsRecordService;
import com.aska.repository.entity.*;
import com.aska.repository.mapper.AccountMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 管理员总表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
@Service
public class AccountServiceImpl extends ServiceImpl<AccountMapper, Account> implements IAccountService {

    @Autowired
    AccountMapper mapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    IOperationAutoService autoService;

    @Autowired
    IAccountPointsRecordService accountPointsRecordService;


    @Override
    public Page<Account> selectPageBy(String accountName, Integer status, Integer page, Integer limit){
        Page<Account> accountPage = new Page<>(page,limit);
        QueryWrapper<Account> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(status!=null,Account::getStatus,status).and(StrUtil.isNotBlank(accountName),e->e.like(Account::getAccountName,accountName).or().like(Account::getAccount,accountName));
        Page<Account> result = mapper.selectPage(accountPage,queryWrapper);
        return result;
    }

    @Override
    public void switchStatus(Long id, Integer status){
        Account account = mapper.selectById(id);
        if(account == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        account.setStatus(status);
        account.setUpdateTime(DateUtil.date());
        mapper.updateById(account);
    }



    @Override
    public void register(Account account) {
        QueryWrapper<Account> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Account::getAccount, account.getAccount());
        Account account1 = mapper.selectOne(queryWrapper);
        if (account1 != null) {
            throw new CustomException(ResultCode.ACCOUNT_INFO_IS_FOUND);
        }
        if(StrUtil.isBlank(account.getAccountName())){
            // 生成随机名称
            account.setAccountName(RandomNameUtil.randomName(true,4));
        }

        // 生成对应的编码
        String uuid = UUID.randomUUID().toString().replace("-", "");
        account.setAccountKey(uuid);

        if(!account.getPassword().equals(account.getConfirmPassword())) {
            throw new CustomException(ResultCode.USER_TWO_PASSWORD_NOT_SOME);
        }

        //密码加密
        account.setPassword(passwordEncoder.encode(account.getPassword()));
        account.setCreateTime(DateUtil.date());
        mapper.insert(account);
    }

    @Override
    public void verifyAccount(Account account) {
        QueryWrapper<Account> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Account::getAccount, account.getAccount());
        Account account1 = mapper.selectOne(queryWrapper);
        if (account1 != null) {
            throw new CustomException(ResultCode.ACCOUNT_INFO_IS_FOUND);
        }
        if(!account.getPassword().equals(account.getConfirmPassword())) {
            throw new CustomException(ResultCode.USER_TWO_PASSWORD_NOT_SOME);
        }
    }

    /**
     * 账号登录
     * @param account
     * @param password
     * @return
     */
    @Override
    public LoginInfo login(String account, String password) {
        QueryWrapper<Account> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Account::getAccount, account);
        Account account1 = mapper.selectOne(queryWrapper);
        if (account1 == null) {
            throw new CustomException(ResultCode.USER_INFO_NOT_FOUND);
        }
        if(account1.getStatus().equals(1)){
            throw new CustomException(ResultCode.ACCOUNT_IS_STATUS);
        }
        if (!passwordEncoder.matches(password, account1.getPassword())) {
            throw new CustomException(ResultCode.USER_INFO_NOT_PASSWORD_ERROR);
        }
        // 生成token，生成刷新的token
        AccountToken accountToken = new AccountToken();
        accountToken.setId(account1.getId());
        accountToken.setAccountName(account1.getAccount());
        String token = JwtUtil.generateToken(JSONUtil.toJsonStr(accountToken));
        String refreshToken = DigestUtil.md5Hex(token);
        accountToken.setMd5TokenStr(DigestUtil.md5Hex(token));
        //延迟半个小时刷新token
        accountToken.setExpiresAt(DateUtil.offsetMinute(DateUtil.date(), JwtUtil.REDIS_EXPIRE_MINUTES));
        // 存入redis中并返回
        LocalDateTime issueAt = LocalDateTime.now();
        LocalDateTime expireAt = issueAt.plusSeconds(TimeUnit.MINUTES.toSeconds(JwtUtil.REDIS_EXPIRE_MINUTES));
        int expireSeconds = (int) Duration.between(issueAt, expireAt).getSeconds();
        redisUtil.set(accountToken.getMd5TokenStr(),JSONUtil.toJsonStr(accountToken),expireSeconds);
        LoginInfo loginInfo = new LoginInfo();
        loginInfo.setToken(token);
        loginInfo.setRefreshToken(refreshToken);
        return loginInfo;
    }


    @Override
    public Account getAccountInfo(Long id){
        return mapper.selectById(id);
    }


    @Override
    public void updateAccountInfo(Account account){
        Account account1 = mapper.selectById(account.getId());
        if(account1 == null){
            throw new CustomException(ResultCode.USER_INFO_NOT_FOUND);
        }
        account1.setImg(account.getImg());
        account1.setAccountName(account.getAccountName());
        account1.setUpdateTime(DateUtil.date());
        // 不能修改积分
        mapper.updateById(account1);
    }

    @Override
    public void updateAccountPassword(Long id, String ordPassword, String newPassword, String confirmPassword){
        Account account = mapper.selectById(id);
        if(account == null){
            throw new CustomException(ResultCode.USER_INFO_NOT_FOUND);
        }
        if (!passwordEncoder.matches(ordPassword, account.getPassword())) {
            throw new CustomException(ResultCode.USER_INFO_NOT_PASSWORD_ERROR);
        }
        if(!newPassword.equals(confirmPassword)){
            throw new CustomException(ResultCode.USER_TWO_PASSWORD_NOT_SOME);
        }
        account.setPassword(passwordEncoder.encode(newPassword));
        account.setUpdateTime(DateUtil.date());
        mapper.updateById(account);
    }

    @Override
    public void recharge(Long accountId, Double coin){
        if(coin <= 0.00){
            throw new CustomException(ResultCode.COIN_IS_VALID);
        }
        Account account = mapper.selectById(accountId);
        if(account == null){
            throw new CustomException(ResultCode.USER_INFO_NOT_FOUND);
        }
        // 获取充值比例
        OperationAuto operationAuto = autoService.selectDetailBySystemCode("recharge_ratio");
        Double points = coin * Double.parseDouble(operationAuto.getValue());


        AccountPointsRecord accountPointsRecord = new AccountPointsRecord();
        accountPointsRecord.setAccountId(accountId);
        accountPointsRecord.setType(1);
        accountPointsRecord.setPoints(points);
        accountPointsRecord.setBeforeOperation(account.getPoints());
        accountPointsRecord.setAfterOperation(account.getPoints() + points);
        accountPointsRecord.setCreateTime(DateUtil.date());

        accountPointsRecordService.add(accountPointsRecord);

        account.setPoints(account.getPoints() + points);
        account.setUpdateTime(DateUtil.date());
        mapper.updateById(account);
    }

    @Override
    public List<Account> selectList() {
        return mapper.selectList(null);
    }
}
