package com.aska.logical.service.customer;

import com.aska.repository.entity.BatchEntryRatio;
import com.aska.repository.entity.BatchUpdateEntry;
import com.aska.repository.entity.EntryRatio;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 劫持比例表 服务类
 * </p>
 *
 * @author sy
 * @since 2026-01-06
 */
public interface IEntryRatioService extends IService<EntryRatio> {

    EntryRatio selectOneById(Long id);

    void updateEntryRatio(EntryRatio entryRatio);

    void addEntryRatio(EntryRatio entryRatio);

    void stopOrStartEntryRatioAll(Integer switchCode);

    void batchUpdateEntryRatioAll(BatchUpdateEntry batchUpdateEntry);

    void synchronizationConfiguration();
}
