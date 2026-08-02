package com.aska.logical.service.common;

import com.aska.repository.entity.Domain;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
public interface IDomainService extends IService<Domain> {

    void clearPitJob();
}
