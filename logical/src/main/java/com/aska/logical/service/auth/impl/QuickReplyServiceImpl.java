package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.auth.IQuickReplyService;
import com.aska.repository.entity.QuickReply;
import com.aska.repository.entity.SayHello;
import com.aska.repository.mapper.QuickReplyMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 快捷回复表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-01-16
 */
@Service
public class QuickReplyServiceImpl extends ServiceImpl<QuickReplyMapper, QuickReply> implements IQuickReplyService {

    @Autowired
    QuickReplyMapper quickReplyMapper;

    @Override
    public Page<QuickReply> selectPageList(Integer page, Integer pageSize, Long userId,Integer accountType) {
        Page<QuickReply> quickReplyPage = new Page<>(page, pageSize);
        QueryWrapper<QuickReply> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(QuickReply::getUserId, userId).eq(QuickReply::getAccountType,accountType).orderByAsc(QuickReply::getSort);
        return quickReplyMapper.selectPage(quickReplyPage,queryWrapper);
    }

    @Override
    public void addQuickReply(QuickReply quickReply, Long userId) {
        quickReply.setUserId(userId);
        quickReply.setCreateTime(DateUtil.date());
        quickReplyMapper.insert(quickReply);
    }

    @Override
    public void updateQuickReply(QuickReply quickReply) {
        if (isExistQuickReply(quickReply.getId())){
            throw new CustomException(ResultCode.USER_FAILED_TO_ADD);
        }
        quickReply.setUpdateTime(DateUtil.date());
        quickReplyMapper.updateById(quickReply);
    }

    @Override
    public int deleteQuickReply(Long id) {
        if (isExistQuickReply(id)){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        return quickReplyMapper.deleteById(id);
    }

    @Override
    public Page<QuickReply> getList(Integer page, Integer pageSize,Long userId) {
        Page<QuickReply> page1 = new Page<>(page, pageSize);
        QueryWrapper<QuickReply> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(QuickReply::getUserId, userId);
        return quickReplyMapper.selectPage(page1, wrapper);
    }

    @Override
    public void sortTop(Long id){
        QuickReply quickReply = quickReplyMapper.selectById(id);
        Integer sort = quickReply.getSort();
        QueryWrapper<QuickReply> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().le(QuickReply::getSort,sort).eq(QuickReply::getUserId,quickReply.getUserId()).ne(QuickReply::getId,quickReply.getId()).orderByDesc(QuickReply::getSort).last("limit 1");
        QuickReply quickReply1 = quickReplyMapper.selectOne(queryWrapper);
        if(quickReply1 != null){
            Integer sort1 = quickReply1.getSort();
            if(sort1.equals(sort)){
                sort1 -= 1;
            }
            quickReply1.setSort(sort);
            quickReply.setSort(sort1);
            quickReplyMapper.updateById(quickReply);
            quickReplyMapper.updateById(quickReply1);
        }
    }

    @Override
    public void sortBottom(Long id){
        QuickReply quickReply = quickReplyMapper.selectById(id);
        Integer sort = quickReply.getSort();
        QueryWrapper<QuickReply> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().ge(QuickReply::getSort,sort).eq(QuickReply::getUserId,quickReply.getUserId()).ne(QuickReply::getId,quickReply.getId()).orderByAsc(QuickReply::getSort).last("limit 1");
        QuickReply quickReply1 = quickReplyMapper.selectOne(queryWrapper);
        if(quickReply1 != null){
            Integer sort1 = quickReply1.getSort();
            if(sort1.equals(sort)){
                sort1 += 1;
            }
            quickReply1.setSort(sort);
            quickReply.setSort(sort1);
            quickReplyMapper.updateById(quickReply);
            quickReplyMapper.updateById(quickReply1);
        }
    }

    @Override
    public void addReply(Long mainId, List<Long> userSet,Integer isRemove){
        QueryWrapper<QuickReply> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(QuickReply::getUserId,mainId)
                .eq(QuickReply::getAccountType,1)
                .select(QuickReply::getType,QuickReply::getContent, QuickReply::getSort,QuickReply::getAccountType);
        List<QuickReply> quickReplies = quickReplyMapper.selectList(queryWrapper);

        // 清空自己的打招呼数据
        if(isRemove == 1){
            quickReplyMapper.deleteById(new LambdaQueryWrapper<QuickReply>().in(QuickReply::getUserId,userSet).eq(QuickReply::getAccountType,0));
        }

        if(quickReplies != null && quickReplies.size() > 0){
            List<QuickReply> quickReplies1 = new ArrayList<>();
            for (int i = 0; i < userSet.size(); i++) {
                Long userId = userSet.get(i);
                quickReplies.forEach(sayHello1 -> {
                    sayHello1.setUserId(userId);
                    sayHello1.setCreateTime(DateUtil.date());
                    quickReplies1.add(sayHello1);
                });
            }
            this.saveBatch(quickReplies1);
        }
    }

    private Boolean isExistQuickReply(Long id) {
        return quickReplyMapper.selectById(id) == null;
    }
}
