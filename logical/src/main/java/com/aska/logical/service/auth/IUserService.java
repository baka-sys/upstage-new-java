package com.aska.logical.service.auth;

import com.aska.repository.entity.CustomerCount;
import com.aska.repository.entity.LoginInfo;
import com.aska.repository.entity.User;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * <p>
 * 用户表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
public interface IUserService extends IService<User> {

    Page<User> selectPageList(String userName, Integer status,Integer activeState,Integer testCard,Integer pastDue, Long accountId, Integer page, Integer limit);

    Page<User> selectOnlinePageList(String userName, Integer status, Integer testCard, Long accountId, Integer page, Integer limit);

    void add(User user, Long id);

    void switchStatus(Long id, Integer status);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchFreeze(String carmines);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchRenew(String carmines, Double days,Integer maxNumber,Long accountId);

    void generateCardPassword(Integer lines, Long id, String password, Double days, Integer testCard, String prefixString, HttpServletResponse response, Boolean isMode, Integer shellType,Integer qrcodeSwitch,Integer maxNumber,Integer isSearch) throws IOException;

    LoginInfo login(String userAccount, String password);

    @Transactional(rollbackFor = RuntimeException.class)
    void updateUserSpeech(Long id, String userIds, Integer isRemove, String functionIds);

    List<Long> selectCustomerByAccountId(Long id);

    CustomerCount selectUserCountByAccountId(Long id);

    void renewUserByDays(Long id, Long userId, Double days);

    List<String> selectUrlByUserId(Long userId);

    void cardExpired();

    void clearRecord();

    // 今日激活
    Page<User> selectActivePage(String carmine, String keywords, Integer page, Integer limit);


    Page<User> selectRenewPage(String carmine, String keywords, Integer page, Integer limit);
}
