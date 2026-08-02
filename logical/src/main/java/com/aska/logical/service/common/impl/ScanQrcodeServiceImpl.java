package com.aska.logical.service.common.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.repository.entity.ScanQrcode;
import com.aska.repository.mapper.ScanQrcodeMapper;
import com.aska.logical.service.common.IScanQrcodeService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-08-28
 */
@Service
public class ScanQrcodeServiceImpl extends ServiceImpl<ScanQrcodeMapper, ScanQrcode> implements IScanQrcodeService {

    @Autowired
    ScanQrcodeMapper mapper;


    @Override
    public Long selectCountBy(Long customerId){
        Long count = mapper.selectCount(
                new LambdaQueryWrapper<ScanQrcode>()
                        .eq(ScanQrcode::getCustomerId, customerId)
                        .eq(ScanQrcode::getCreateTime, DateUtil.parseDate(DateUtil.now()))
        );
        return count;
    }
}
