package com.aska.logical.service.customer;

import com.aska.repository.entity.Customer;
import com.aska.repository.entity.User;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
public interface ICustomerService extends IService<Customer> {

    Page<Customer> selectPageList(String userName, Integer status, Integer activeState, Integer testCard, Long accountId, Integer page, Integer limit);

    void switchStatus(Long id, Integer status);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchFreeze(String carmines);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchRenew(String carmines, Double days, Integer maxNumber, Long accountId);

    @Transactional(rollbackFor = RuntimeException.class)
    void generateCardPassword(Integer lines, Long id, String password, Double days, Integer testCard, String prefixString, HttpServletResponse response, Boolean isMode, Integer qrcodeSwitch, Integer maxNumber, Integer isSearch) throws IOException;
}
