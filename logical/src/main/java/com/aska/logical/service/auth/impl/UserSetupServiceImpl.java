package com.aska.logical.service.auth.impl;

import com.aska.repository.entity.UserSetup;
import com.aska.repository.mapper.UserSetupMapper;
import com.aska.logical.service.auth.IUserSetupService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 客服设置表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-06-07
 */
@Service
public class UserSetupServiceImpl extends ServiceImpl<UserSetupMapper, UserSetup> implements IUserSetupService {

}
