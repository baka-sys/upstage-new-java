package com.aska.logical.service.auth.impl;

import com.aska.logical.service.auth.IUserService;
import com.aska.repository.entity.RenewalRecord;
import com.aska.repository.mapper.RenewalRecordMapper;
import com.aska.logical.service.auth.IRenewalRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 续费记录 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-10
 */
@Service
public class RenewalRecordServiceImpl extends ServiceImpl<RenewalRecordMapper, RenewalRecord> implements IRenewalRecordService {

    @Autowired
    RenewalRecordMapper mapper;

    @Autowired
    IUserService userService;




    @Override
    public Double selectTodayCountDays(Long id){
        List<Long> customerIds = new ArrayList<>();
        if(id != null){
            customerIds = userService.selectCustomerByAccountId(id);
        }
        Double days = mapper.selectTodayCountDays(customerIds);
        return days;
    }

    @Override
    public void addRenewalRecord(RenewalRecord record){
        mapper.insert(record);
    }

}
