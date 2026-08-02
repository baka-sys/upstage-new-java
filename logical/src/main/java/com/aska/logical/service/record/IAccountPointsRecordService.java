package com.aska.logical.service.record;

import com.aska.repository.entity.AccountPointsRecord;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 积分消费记录 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-27
 */
public interface IAccountPointsRecordService extends IService<AccountPointsRecord> {

    Page<AccountPointsRecord> selectPageBy(Integer type, Long accountId, String startTime, String endTime, Integer page, Integer limit);

    void add(AccountPointsRecord record);
}
