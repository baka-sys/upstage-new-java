package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.crypto.digest.DigestUtil;
import cn.hutool.json.JSONUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.JwtUtil;
import com.aska.common.util.RedisUtil;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.repository.entity.AccountToken;
import com.aska.repository.entity.Admin;
import com.aska.repository.entity.LoginInfo;
import com.aska.repository.mapper.AdminMapper;
import com.aska.logical.service.auth.IAdminService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * 总后台账号表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-28
 */
@Service
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements IAdminService {

    @Autowired
    AdminMapper mapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    RedisUtil redisUtil;

    @Autowired
    IOperationAutoService operationAutoService;



    @Override
    public LoginInfo login(String account, String password){
        QueryWrapper<Admin> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Admin::getAccount, account);
        Admin admin = mapper.selectOne(queryWrapper);
        if(admin == null){
            throw new CustomException(ResultCode.USER_INFO_NOT_PASSWORD_ERROR);
        }

        if (!passwordEncoder.matches(password, admin.getPassword())) {
            throw new CustomException(ResultCode.USER_INFO_NOT_PASSWORD_ERROR);
        }

        // 获取当前图片地址
        String imageUrl = operationAutoService.selectRedisValueByFiled("image_url");

        // 生成token，生成刷新的token
        AccountToken accountToken = new AccountToken();
        accountToken.setId(admin.getId());
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
        loginInfo.setImageUrl(imageUrl);
        loginInfo.setRefreshToken(refreshToken);
        return loginInfo;
    }

}
