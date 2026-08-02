package com.aska.logical.service.auth;

import com.aska.repository.entity.Account;
import com.aska.repository.entity.LoginInfo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 管理员总表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
public interface IAccountService extends IService<Account> {

    Page<Account> selectPageBy(String accountName, Integer status, Integer page, Integer limit);

    void switchStatus(Long id, Integer status);

    void register(Account account);

    void verifyAccount(Account account);

    LoginInfo login(String account, String password);

    Account getAccountInfo(Long id);

    void updateAccountInfo(Account account);

    void updateAccountPassword(Long id, String ordPassword, String newPassword, String confirmPassword);

    void recharge(Long accountId, Double coin);

    List<Account> selectList();
}
