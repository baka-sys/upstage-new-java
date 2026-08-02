package com.aska.logical.service.auth.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.auth.IMassService;
import com.aska.repository.entity.Mass;
import com.aska.repository.mapper.MassMapper;
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
 * 群发表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-11
 */
@Service
public class MassServiceImpl extends ServiceImpl<MassMapper, Mass> implements IMassService {

    @Autowired
    MassMapper mapper;


    @Override
    public Page<Mass> selectPageList(Integer page, Integer pageSize, Long userId, Integer accountType) {
        Page<Mass> quickReplyPage = new Page<>(page, pageSize);
        QueryWrapper<Mass> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(Mass::getUserId, userId).eq(Mass::getAccountType,accountType).orderByAsc(Mass::getSort);
        return mapper.selectPage(quickReplyPage,queryWrapper);
    }

    @Override
    public void add(Mass mass, Long userId) {
        mass.setUserId(userId);
        mass.setCreateTime(DateUtil.date());
        mapper.insert(mass);
    }

    @Override
    public void update(Mass mass) {
        if (isExist(mass.getId())){
            throw new CustomException(ResultCode.USER_FAILED_TO_ADD);
        }
        mass.setUpdateTime(DateUtil.date());
        mapper.updateById(mass);
    }

    @Override
    public int delete(Long id) {
        if (isExist(id)){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        return mapper.deleteById(id);
    }

    @Override
    public void sortTop(Long id){
        Mass mass = mapper.selectById(id);
        Integer sort = mass.getSort();
        QueryWrapper<Mass> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().le(Mass::getSort,sort).eq(Mass::getUserId,mass.getUserId()).ne(Mass::getId,mass.getId()).orderByDesc(Mass::getSort).last("limit 1");
        Mass mass1 = mapper.selectOne(queryWrapper);
        if(mass1 != null){
            Integer sort1 = mass1.getSort();
            if(sort1.equals(sort)){
                sort1 -= 1;
            }
            mass1.setSort(sort);
            mass.setSort(sort1);
            mapper.updateById(mass);
            mapper.updateById(mass1);
        }
    }

    @Override
    public void sortBottom(Long id){
        Mass mass = mapper.selectById(id);
        Integer sort = mass.getSort();
        QueryWrapper<Mass> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().ge(Mass::getSort,sort).eq(Mass::getUserId,mass.getUserId()).ne(Mass::getId,mass.getId()).orderByAsc(Mass::getSort).last("limit 1");
        Mass mass1 = mapper.selectOne(queryWrapper);
        if(mass1 != null){
            Integer sort1 = mass1.getSort();
            if(sort1.equals(sort)){
                sort1 += 1;
            }
            mass1.setSort(sort);
            mass.setSort(sort1);
            mapper.updateById(mass);
            mapper.updateById(mass1);
        }
    }

    @Override
    public void addMass(Long mainId, List<Long> userSet, Integer isRemove){
        QueryWrapper<Mass> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(Mass::getUserId,mainId)
                .eq(Mass::getAccountType,1)
                .select(Mass::getType,Mass::getContent, Mass::getSort,Mass::getAccountType);
        List<Mass> massList = mapper.selectList(queryWrapper);
        // 清空自己的打招呼数据
        if(isRemove == 1){
            mapper.deleteById(new LambdaQueryWrapper<Mass>().in(Mass::getUserId,userSet).eq(Mass::getAccountType,0));
        }

        if(massList != null && massList.size() > 0){
            List<Mass> massList1 = new ArrayList<>();
            for (int i = 0; i < userSet.size(); i++) {
                Long userId = userSet.get(i);
                massList1.forEach(sayHello1 -> {
                    sayHello1.setUserId(userId);
                    sayHello1.setCreateTime(DateUtil.date());
                    massList1.add(sayHello1);
                });
            }
            this.saveBatch(massList1);
        }
    }
    private Boolean isExist(Long id) {
        return mapper.selectById(id) == null;
    }
}
