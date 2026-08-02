package com.aska.logical.service.code;

import com.aska.repository.entity.BatchDomain;
import com.aska.repository.entity.RealmName;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
public interface IRealmNameService extends IService<RealmName> {

    Page<RealmName> selectPage(Integer page, Integer limit);

    void batchAdd(BatchDomain batchDomain);

    void updateRealmName(RealmName realmName);

    void setShellTypeAndDomain(Long id, Integer shellType);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchDelete(String ids);
}
