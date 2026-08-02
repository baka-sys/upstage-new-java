package com.aska.logical.service.configuration;

import com.aska.repository.entity.BatchDomainUrl;
import com.aska.repository.entity.SystemDomain;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 系统域名配置 服务类
 * </p>
 *
 * @author sy
 * @since 2026-02-25
 */
public interface ISystemDomainService extends IService<SystemDomain> {

    Page<SystemDomain> getPageByLimit(Integer type,Integer status, Integer page, Integer limit);

    void addDomain(SystemDomain systemDomain);

    void addBatchDomain(BatchDomainUrl batchDomainUrl);

    void updateDomain(SystemDomain systemDomain);

    void deleteDomain(Long id);

    void updateStatus(Long id);

    void updateMainUrlJob();

    void updateMainUrlJobForImage();
}
