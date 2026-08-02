package com.aska.logical.service.auth;

import com.aska.repository.entity.QuickReply;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 快捷回复表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-01-16
 */
public interface IQuickReplyService extends IService<QuickReply> {

    /**
     * 分页列表
     */
    Page<QuickReply> selectPageList(Integer page, Integer pageSize, Long userId,Integer accountType);

    /**
     * 添加
     */
    void addQuickReply(QuickReply quickReply, Long userId);

    /**
     * 修改
     */
    void updateQuickReply(QuickReply quickReply);

    /**
     * 删除
     */
    int deleteQuickReply(Long id);

    /**
     * 获取列表
     */
    Page<QuickReply> getList(Integer page, Integer pageSize, Long userId);

    void sortTop(Long id);

    void sortBottom(Long id);

    void addReply(Long mainId, List<Long> userSet, Integer isRemove);
}
