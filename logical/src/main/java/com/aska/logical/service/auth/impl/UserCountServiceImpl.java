package com.aska.logical.service.auth.impl;

import com.aska.logical.service.auth.IUserService;
import com.aska.repository.entity.UserCount;
import com.aska.repository.entity.UserCountBroken;
import com.aska.repository.entity.UserCountData;
import com.aska.repository.entity.UserCountRate;
import com.aska.repository.mapper.UserCountMapper;
import com.aska.logical.service.auth.IUserCountService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 用户统计表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
@Service
public class UserCountServiceImpl extends ServiceImpl<UserCountMapper, UserCount> implements IUserCountService {

    @Autowired
    UserCountMapper mapper;

    @Autowired
    IUserService userService;

    @Override
    public UserCountData selectCountData(Long id){
        UserCountData userCountData = new UserCountData();
        List<Long> customerIds = userService.selectCustomerByAccountId(id);
        if(customerIds!=null && customerIds.size()>0){
            // 获取下面所有客户的id
            userCountData = mapper.selectCountData(customerIds);
        }
        return userCountData;
    }

    @Override
    public List<UserCountBroken> selectUserCountBroken(Long id){
        List<UserCountBroken> userCountBrokens = null;
        List<Long> customerIds = userService.selectCustomerByAccountId(id);
        if(customerIds!=null && customerIds.size()>0){
           userCountBrokens = mapper.selectCountByCreateTime(customerIds);
        }
        return userCountBrokens;
    }

    @Override
    public List<UserCountRate> selectUserCountRate(Long id){
        List<UserCountRate> rates = null;
        List<Long> customerIds = userService.selectCustomerByAccountId(id);
        if(customerIds!=null && customerIds.size()>0){
            rates = mapper.selectCountByRate(customerIds);
        };
        return rates;
    }

}
