package com.aska.logical.service.auth;

import com.aska.repository.entity.Mass;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 群发表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-11
 */
public interface IMassService extends IService<Mass> {

    Page<Mass> selectPageList(Integer page, Integer pageSize, Long userId, Integer accountType);

    void add(Mass mass, Long userId);

    void update(Mass mass);

    int delete(Long id);

    void sortTop(Long id);

    void sortBottom(Long id);

    void addMass(Long mainId, List<Long> userSet, Integer isRemove);
}
