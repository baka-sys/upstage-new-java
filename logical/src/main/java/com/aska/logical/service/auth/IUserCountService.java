package com.aska.logical.service.auth;

import com.aska.repository.entity.UserCount;
import com.aska.repository.entity.UserCountBroken;
import com.aska.repository.entity.UserCountData;
import com.aska.repository.entity.UserCountRate;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 用户统计表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
public interface IUserCountService extends IService<UserCount> {


    UserCountData selectCountData(Long customerId);

    List<UserCountBroken> selectUserCountBroken(Long customerId);

    List<UserCountRate> selectUserCountRate(Long customerId);
}
