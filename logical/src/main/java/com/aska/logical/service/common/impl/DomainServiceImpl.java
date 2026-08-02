package com.aska.logical.service.common.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.repository.entity.Domain;
import com.aska.repository.entity.LiveCodeNumber;
import com.aska.repository.mapper.DomainMapper;
import com.aska.logical.service.common.IDomainService;
import com.aska.repository.mapper.LiveCodeNumberMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
@Service
public class DomainServiceImpl extends ServiceImpl<DomainMapper, Domain> implements IDomainService {


    @Autowired
    DomainMapper mapper;

    @Autowired
    LiveCodeNumberMapper liveCodeNumberMapper;

    @Override
    public void clearPitJob(){
        // 删除domain数据

        mapper.delete(new QueryWrapper<>());

        // 修改liveCodeNumber 中所有number数据

        QueryWrapper<LiveCodeNumber> queryWrapper = new QueryWrapper<>();

        queryWrapper.lambda().gt(LiveCodeNumber::getNumber,0);

        LiveCodeNumber liveCodeNumber = new LiveCodeNumber();

        liveCodeNumber.setNumber(0);

        liveCodeNumber.setUpdateTime(DateUtil.date());

        liveCodeNumberMapper.update(liveCodeNumber,queryWrapper);

    }

}
