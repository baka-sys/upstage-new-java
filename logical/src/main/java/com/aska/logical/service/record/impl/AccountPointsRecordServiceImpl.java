package com.aska.logical.service.record.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.aska.repository.entity.AccountPointsRecord;
import com.aska.repository.mapper.AccountPointsRecordMapper;
import com.aska.logical.service.record.IAccountPointsRecordService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 积分消费记录 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-03-27
 */
@Service
public class AccountPointsRecordServiceImpl extends ServiceImpl<AccountPointsRecordMapper, AccountPointsRecord> implements IAccountPointsRecordService {

    @Autowired
    AccountPointsRecordMapper mapper;


    @Override
    public Page<AccountPointsRecord> selectPageBy(Integer type, Long accountId, String startTime, String endTime, Integer page, Integer limit){
        Page<AccountPointsRecord> pageRecord = new Page<>(page, limit);
        QueryWrapper<AccountPointsRecord> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda()
                .eq(type !=null,AccountPointsRecord::getType, type)
                .eq(accountId != null,AccountPointsRecord::getAccountId, accountId);
        if(StrUtil.isNotBlank(startTime)){
            queryWrapper.lambda().gt(AccountPointsRecord::getCreateTime,DateUtil.parse(startTime));
        }
        if(StrUtil.isNotBlank(endTime)){
            queryWrapper.lambda().gt(AccountPointsRecord::getCreateTime,DateUtil.parse(endTime));
        }
        return mapper.selectPage(pageRecord, queryWrapper);
    }


    @Override
    public void add(AccountPointsRecord record) {
        mapper.insert(record);
    }
}
