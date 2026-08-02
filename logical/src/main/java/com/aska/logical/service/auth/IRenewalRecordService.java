package com.aska.logical.service.auth;

import com.aska.repository.entity.RenewalRecord;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 续费记录 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-10
 */
public interface IRenewalRecordService extends IService<RenewalRecord> {

    Double selectTodayCountDays(Long id);

    void addRenewalRecord(RenewalRecord record);
}
