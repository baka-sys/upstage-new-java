package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.auth.ISayHelloService;
import com.aska.repository.entity.SayHello;
import com.aska.repository.mapper.SayHelloMapper;
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
 * 打招呼表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-11
 */
@Service
public class SayHelloServiceImpl extends ServiceImpl<SayHelloMapper, SayHello> implements ISayHelloService {

    @Autowired
    SayHelloMapper mapper;

    @Override
    public Page<SayHello> selectPageList(Integer page, Integer pageSize, Long userId, Integer accountType) {
        Page<SayHello> page1 = new Page<>(page, pageSize);
        QueryWrapper<SayHello> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(SayHello::getUserId, userId).eq(SayHello::getAccountType,accountType).orderByAsc(SayHello::getSort);
        return mapper.selectPage(page1,queryWrapper);
    }

    @Override
    public void add(SayHello sayHello, Long userId) {
        sayHello.setUserId(userId);
        sayHello.setCreateTime(DateUtil.date());
        mapper.insert(sayHello);
    }

    @Override
    public List<SayHello> getList(Long userId, Integer accountType) {
        QueryWrapper<SayHello> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(SayHello::getUserId, userId).eq(SayHello::getAccountType,accountType);

        return mapper.selectList(queryWrapper);
    }

    @Override
    public void update(SayHello sayHello) {
        if (isExist(sayHello.getId())){
            throw new CustomException(ResultCode.USER_FAILED_TO_ADD);
        }
        sayHello.setUpdateTime(DateUtil.date());
        mapper.updateById(sayHello);
    }

    @Override
    public int delete(Long id) {
        if (isExist(id)){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        return mapper.deleteById(id);
    }

    @Override
    public List<SayHello> getList(Long userId) {
        QueryWrapper<SayHello> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(SayHello::getUserId, userId).eq(SayHello::getStatus,0).orderByAsc(SayHello::getSort);
        return mapper.selectList(wrapper);
    }

    @Override
    public void sortTop(Long id){
        SayHello sayHello = mapper.selectById(id);
        Integer sort = sayHello.getSort();
        QueryWrapper<SayHello> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().le(SayHello::getSort,sort).eq(SayHello::getUserId,sayHello.getUserId()).ne(SayHello::getId,sayHello.getId()).orderByDesc(SayHello::getSort).last("limit 1");
        SayHello sayHello1 = mapper.selectOne(queryWrapper);
        if(sayHello1 != null){
            Integer sort1 = sayHello1.getSort();
            if(sort1.equals(sort)){
                sort1 -= 1;
            }
            sayHello1.setSort(sort);
            sayHello.setSort(sort1);
            mapper.updateById(sayHello);
            mapper.updateById(sayHello1);
        }
    }

    @Override
    public void updateStatus(Long id) {
        SayHello sayHello = mapper.selectById(id);
        if(sayHello == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        Integer status = sayHello.getStatus() == 1 ? 0 : 1;
        sayHello.setStatus(status);
        sayHello.setUpdateTime(DateUtil.date());
        mapper.updateById(sayHello);
    }

    @Override
    public void sortBottom(Long id){
        SayHello sayHello = mapper.selectById(id);
        Integer sort = sayHello.getSort();
        QueryWrapper<SayHello> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().ge(SayHello::getSort,sort).eq(SayHello::getUserId,sayHello.getUserId()).ne(SayHello::getId,sayHello.getId()).orderByAsc(SayHello::getSort).last("limit 1");
        SayHello sayHello1 = mapper.selectOne(queryWrapper);
        if(sayHello1 != null){
            Integer sort1 = sayHello1.getSort();
            if(sort1.equals(sort)){
                sort1 += 1;
            }
            sayHello1.setSort(sort);
            sayHello.setSort(sort1);
            mapper.updateById(sayHello);
            mapper.updateById(sayHello1);
        }
    }


    @Override
    public void addSayHello(Long mainId, List<Long> userSet,Integer isRemove){
        QueryWrapper<SayHello> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(SayHello::getUserId,mainId)
                .eq(SayHello::getAccountType,1)
                .select(SayHello::getType,SayHello::getContent, SayHello::getSort,SayHello::getStatus,SayHello::getAccountType);
        List<SayHello> sayHello = mapper.selectList(queryWrapper);
        // 清空自己的打招呼数据
        if(isRemove == 1){
            mapper.deleteById(new LambdaQueryWrapper<SayHello>().in(SayHello::getUserId,userSet).eq(SayHello::getAccountType,0));
        }

        if(sayHello != null && sayHello.size() > 0){
            List<SayHello> sayHellos = new ArrayList<>();
            for (int i = 0; i < userSet.size(); i++) {
                Long userId = userSet.get(i);
                sayHello.forEach(sayHello1 -> {
                    sayHello1.setUserId(userId);
                    sayHello1.setCreateTime(DateUtil.date());
                    sayHellos.add(sayHello1);
                });
            }
            this.saveBatch(sayHellos);
        }
    }

    private Boolean isExist(Long id) {
        return mapper.selectById(id) == null;
    }
}
