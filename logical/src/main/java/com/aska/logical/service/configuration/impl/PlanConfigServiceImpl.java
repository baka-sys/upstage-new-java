package com.aska.logical.service.configuration.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.configuration.IPlanConfigService;
import com.aska.repository.entity.PlanConfig;
import com.aska.repository.mapper.PlanConfigMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 方案设置 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-05-17
 */
@Service
public class PlanConfigServiceImpl extends ServiceImpl<PlanConfigMapper, PlanConfig> implements IPlanConfigService {


    @Autowired
    PlanConfigMapper mapper;



    @Override
    public Page<PlanConfig> selectPageBy(Integer page, Integer limit) {

        Page<PlanConfig> pages = new Page<>(page, limit);

        QueryWrapper<PlanConfig> queryWrapper = new QueryWrapper<>();

        Page<PlanConfig> page1 = mapper.selectPage(pages, queryWrapper);

        return page1;
    }


    @Override
    public void add(PlanConfig config) {
        config.setCreateTime(DateUtil.date());
        mapper.insert(config);
    }

    @Override
    public void updateConfig(PlanConfig config) {
        PlanConfig pc = mapper.selectById(config.getId());
        if(pc == null){
            throw new CustomException(ResultCode.ERROR.code(),"数据不存在");
        }
        config.setUpdateTime(DateUtil.date());
        mapper.updateById(config);
    }

    @Override
    public void deleteConfig(Long id){
        PlanConfig pc = mapper.selectById(id);
        if(pc == null){
            throw new CustomException(ResultCode.ERROR.code(),"数据不存在");
        }
        mapper.deleteById(id);
    }

    @Override
    public void switchStatus(Long id, Integer status){
        PlanConfig pc = mapper.selectById(id);
        if(pc == null){
            throw new CustomException(ResultCode.ERROR.code(),"数据不存在");
        }
        pc.setStatus(status);
        pc.setUpdateTime(DateUtil.date());
        mapper.updateById(pc);
    }
}
