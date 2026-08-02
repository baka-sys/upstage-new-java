package com.aska.logical.service.configuration;

import com.aska.repository.entity.PlanConfig;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 方案设置 服务类
 * </p>
 *
 * @author sy
 * @since 2026-05-17
 */
public interface IPlanConfigService extends IService<PlanConfig> {

    Page<PlanConfig> selectPageBy(Integer page, Integer limit);

    void add(PlanConfig config);

    void updateConfig(PlanConfig config);

    void deleteConfig(Long id);

    void switchStatus(Long id, Integer status);
}
