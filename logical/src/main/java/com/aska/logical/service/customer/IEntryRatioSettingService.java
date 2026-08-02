package com.aska.logical.service.customer;

import com.aska.repository.entity.EntryRatioSetting;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sy
 * @since 2026-05-15
 */
public interface IEntryRatioSettingService extends IService<EntryRatioSetting> {

    EntryRatioSetting selectSetting();

    void updateSetting(EntryRatioSetting entryRatioSetting);
}
