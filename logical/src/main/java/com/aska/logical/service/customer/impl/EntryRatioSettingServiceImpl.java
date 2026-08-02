package com.aska.logical.service.customer.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.RedisUtil;
import com.aska.repository.entity.EntryRatioCarmine;
import com.aska.repository.entity.EntryRatioSetting;
import com.aska.repository.entity.User;
import com.aska.repository.mapper.EntryRatioCarmineMapper;
import com.aska.repository.mapper.EntryRatioSettingMapper;
import com.aska.logical.service.customer.IEntryRatioSettingService;
import com.aska.repository.mapper.UserMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-05-15
 */
@Service
public class EntryRatioSettingServiceImpl extends ServiceImpl<EntryRatioSettingMapper, EntryRatioSetting> implements IEntryRatioSettingService {


    private final static String ENTRY_RATIO_SETTING = "entry_ratio_setting";

    @Autowired
    EntryRatioSettingMapper mapper;


    @Autowired
    EntryRatioCarmineMapper carmineMapper;

    @Autowired
    UserMapper userMapper;


    @Autowired
    RedisUtil redisUtil;



    @Override
    public EntryRatioSetting selectSetting(){
        // 获取默认设置项
        EntryRatioSetting setting = mapper.selectById(1L);

        List<EntryRatioCarmine> entryRatioCarmineList = carmineMapper.selectList(
                new LambdaQueryWrapper<EntryRatioCarmine>().eq(EntryRatioCarmine::getMainId,1L)
        );

        setting.setCarmines(entryRatioCarmineList);

        return setting;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateSetting(EntryRatioSetting entryRatioSetting){
        // 修改主表信息
        entryRatioSetting.setUpdateTime(DateUtil.date());
        mapper.updateById(entryRatioSetting);

        // 先删除再增加
        carmineMapper.delete(new LambdaQueryWrapper<EntryRatioCarmine>().eq(EntryRatioCarmine::getMainId,1L));
        entryRatioSetting.getCarmines().forEach(entryRatioCarmine -> {
            EntryRatioCarmine carmine = new EntryRatioCarmine();
            carmine.setCarmine(entryRatioCarmine.getCarmine());
            carmine.setMainId(1L);
            carmine.setNumber(0);
            // 查询单条卡密的user_id
            User user = userMapper.selectOne(
                    new LambdaQueryWrapper<User>().eq(User::getCarmine, carmine.getCarmine()).eq(User::getType,1).select(User::getId)
            );
            if(user == null){
                throw new CustomException(ResultCode.ERROR.code(),"卡密不存在" + entryRatioCarmine.getCarmine());
            }
            carmine.setUserId(user.getId());
            carmineMapper.insert(carmine);
        });
        // 删除缓存数据
        redisUtil.delete(ENTRY_RATIO_SETTING);
    }
}
