package com.aska.logical.service.auth;

import com.aska.repository.entity.Admin;
import com.aska.repository.entity.LoginInfo;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 总后台账号表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-28
 */
public interface IAdminService extends IService<Admin> {

    LoginInfo login(String account, String password);
}
