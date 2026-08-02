package com.aska.logical.service.configuration.impl;

import com.aska.repository.entity.UserLogs;
import com.aska.repository.mapper.UserLogsMapper;
import com.aska.logical.service.configuration.IUserLogsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-06-12
 */
@Service
public class UserLogsServiceImpl extends ServiceImpl<UserLogsMapper, UserLogs> implements IUserLogsService {

}
