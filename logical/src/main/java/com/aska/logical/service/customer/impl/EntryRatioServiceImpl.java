package com.aska.logical.service.customer.impl;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.CovertUtil;
import com.aska.logical.service.auth.IUserService;
import com.aska.logical.service.cocurrent.FutureTaskScheduler;
import com.aska.logical.service.customer.IEntryRatioService;
import com.aska.repository.entity.*;
import com.aska.repository.mapper.CustomerMapper;
import com.aska.repository.mapper.EntryRatioCarmineMapper;
import com.aska.repository.mapper.EntryRatioMapper;
import com.aska.repository.mapper.EntryRatioSettingMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

/**
 * <p>
 * 劫持比例表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-01-06
 */
@Service
public class EntryRatioServiceImpl extends ServiceImpl<EntryRatioMapper, EntryRatio> implements IEntryRatioService {

    @Autowired
    EntryRatioMapper mapper;

    @Autowired
    CustomerMapper customerMapper;

    @Autowired
    IUserService userService;

    @Autowired
    EntryRatioSettingMapper entryRatioSettingMapper;

    @Autowired
    EntryRatioCarmineMapper entryRatioCarmineMapper;


    @Override
    public EntryRatio selectOneById(Long id) {

        QueryWrapper<EntryRatio> queryWrapper = new QueryWrapper<>();

        queryWrapper.lambda().eq(EntryRatio::getMainUserId, id);

        return mapper.selectOne(queryWrapper);
    }


    @Override
    public void updateEntryRatio(EntryRatio entryRatio) {
        // 查询副卡信息
        Customer customer = customerMapper.selectOne(new LambdaQueryWrapper<Customer>().eq(Customer::getCarmine,entryRatio.getSubCarmine()));
        if(customer != null){
            entryRatio.setSubUserId(customer.getId());
            //throw new CustomException(ResultCode.ERROR.code(),"副卡1不存在，请重新填写副卡");
        } else {
            entryRatio.setSubUserId(null);
            entryRatio.setSubCarmine(null);
            entryRatio.setMainRadioNumber(0);
            entryRatio.setSubRadioNumber(0);
        }
        if(StrUtil.isNotBlank(entryRatio.getSubCarmineTwo())){
            Customer customer1 = customerMapper.selectOne(new LambdaQueryWrapper<Customer>().eq(Customer::getCarmine,entryRatio.getSubCarmineTwo()));
            if(customer1 != null){
                //throw new CustomException(ResultCode.ERROR.code(),"副卡2不存在，请重新填写副卡");
                entryRatio.setSubUserIdTwo(customer1.getId());
            } else {
                entryRatio.setSubUserIdTwo(null);
                entryRatio.setSubCarmineTwo(null);
                entryRatio.setMainRadioNumberTwo(0);
                entryRatio.setSubRadioNumberTwo(0);
            }
        }

        entryRatio.setUpdateTime(DateUtil.date());
        mapper.updateById(entryRatio);
    }


    @Override
    public void addEntryRatio(EntryRatio entryRatio) {

        Customer customer = customerMapper.selectById(entryRatio.getMainUserId());
        if(customer == null){
            throw new CustomException(ResultCode.ERROR.code(),"主卡信息不存在");
        }
        // 查询副卡1信息
        Customer customer1 = customerMapper.selectOne(new LambdaQueryWrapper<Customer>().eq(Customer::getCarmine,entryRatio.getSubCarmine()));
        if(customer1 != null){
            entryRatio.setSubUserId(customer1.getId());
            //throw new CustomException(ResultCode.ERROR.code(),"副卡不存在，请重新填写副卡");
        } else {
            entryRatio.setSubUserId(null);
            entryRatio.setSubCarmine(null);
            entryRatio.setMainRadioNumber(0);
            entryRatio.setSubRadioNumber(0);
        }

        // 副卡2信息
        if(StrUtil.isNotBlank(entryRatio.getSubCarmineTwo())){
            Customer customer2 = customerMapper.selectOne(new LambdaQueryWrapper<Customer>().eq(Customer::getCarmine,entryRatio.getSubCarmineTwo()));
            if(customer2 != null){
                entryRatio.setSubCarmineTwo(customer2.getCarmine());
                entryRatio.setSubUserIdTwo(customer2.getId());
                //throw new CustomException(ResultCode.ERROR.code(),"副卡不存在，请重新填写副卡");
            } else {
                entryRatio.setSubUserIdTwo(null);
                entryRatio.setSubCarmineTwo(null);
                entryRatio.setMainRadioNumberTwo(0);
                entryRatio.setSubRadioNumberTwo(0);
            }
        }



        entryRatio.setCreateTime(DateUtil.date());

        mapper.insert(entryRatio);

    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void stopOrStartEntryRatioAll(Integer switchCode){

        // 异步任务
        FutureTaskScheduler.add(()->{
            // 获取所有增在使用中的劫持
            Page<User> userPage = userService.selectActivePage(null,null,1,500);

            // 获取排除卡密
            EntryRatioSetting entryRatioSetting = entryRatioSettingMapper.selectById(1L);

            List<Long> ids = new ArrayList<>();

            if(StrUtil.isNotBlank(entryRatioSetting.getExcludeCard())){
                String[] carmines = entryRatioSetting.getExcludeCard().split(",");
                List<String> excludeCards = Arrays.asList(carmines);
                // 获取id
                List<Customer> users = customerMapper.selectList(new LambdaQueryWrapper<Customer>().in(Customer::getCarmine,excludeCards).select(Customer::getId));

                ids = users.stream().map(Customer::getId).collect(Collectors.toList());
            }
            if(!userPage.getRecords().isEmpty()){
                List<Long> userIds = userPage.getRecords().stream().map(User::getId).collect(Collectors.toList());
                // 查询有劫持的卡密
                List<EntryRatio> entryRatios = mapper.selectList(
                        new LambdaQueryWrapper<EntryRatio>().in(EntryRatio::getMainUserId, userIds)
                );
                if(!entryRatios.isEmpty()){
                    List<Long> finalIds = ids;
                    entryRatios.forEach(entryRatio->{
                        if(finalIds.isEmpty()){
                            entryRatio.setSwitchCodeTwo(switchCode);
                        } else {
                            if(!finalIds.contains(entryRatio.getMainUserId())){
                                entryRatio.setSwitchCodeTwo(switchCode);
                            }
                        }
                        entryRatio.setUpdateTime(DateUtil.date());
                        mapper.updateById(entryRatio);
                    });
                }
            }
        });
    }

    @Override
    public void batchUpdateEntryRatioAll(BatchUpdateEntry batchUpdateEntry){
        // 异步任务
        FutureTaskScheduler.add(()->{
            // 获取所有增在使用中的劫持
            Page<User> userPage = userService.selectActivePage(null,null,1,500);

            // 获取排除卡密
            EntryRatioSetting entryRatioSetting = entryRatioSettingMapper.selectById(1L);

            List<Long> ids = new ArrayList<>();

            if(StrUtil.isNotBlank(entryRatioSetting.getExcludeCard())){
                String[] carmines = entryRatioSetting.getExcludeCard().split(",");
                List<String> excludeCards = Arrays.asList(carmines);
                // 获取id
                List<Customer> users = customerMapper.selectList(new LambdaQueryWrapper<Customer>().in(Customer::getCarmine,excludeCards).select(Customer::getId));

                ids = users.stream().map(Customer::getId).collect(Collectors.toList());
            }

            if(!userPage.getRecords().isEmpty()){
                List<Long> userIds = userPage.getRecords().stream().filter(i->i.getIsSearch().equals(batchUpdateEntry.getType())).map(User::getId).collect(Collectors.toList());
                // 查询有劫持的卡密
                List<EntryRatio> entryRatios = mapper.selectList(
                        new LambdaQueryWrapper<EntryRatio>().in(EntryRatio::getMainUserId, userIds)
                );
                if(!entryRatios.isEmpty()){
                    List<Long> finalIds = ids;
                    entryRatios.forEach(entryRatio->{
                        if(entryRatio.getSubUserIdTwo() != null){
                            if(finalIds.isEmpty()){
                                entryRatio.setSwitchCodeTwo(batchUpdateEntry.getSwitchCodeTwo());
                                entryRatio.setMainRadioNumberTwo(batchUpdateEntry.getMainRadioNumberTwo());
                                entryRatio.setSubRadioNumberTwo(batchUpdateEntry.getSubRadioNumberTwo());
                            } else {
                                if(!finalIds.contains(entryRatio.getMainUserId())){
                                    entryRatio.setSwitchCodeTwo(batchUpdateEntry.getSwitchCodeTwo());
                                    entryRatio.setMainRadioNumberTwo(batchUpdateEntry.getMainRadioNumberTwo());
                                    entryRatio.setSubRadioNumberTwo(batchUpdateEntry.getSubRadioNumberTwo());
                                }
                            }
                            entryRatio.setUpdateTime(DateUtil.date());
                            mapper.updateById(entryRatio);
                        }
                    });
                }
            }
        });
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void synchronizationConfiguration(){

        FutureTaskScheduler.add(()->{
            // 查询续费的用户
            List<Customer> customers = customerMapper.selectNotExpired();

            if(customers.isEmpty()){
                throw new CustomException(ResultCode.ERROR.code(),"没有续费的，不需要同步");
            }

            // 获取配置项
            EntryRatioSetting entryRatioSetting = entryRatioSettingMapper.selectById(1L);

            // 获取配置项中的劫持卡密
            List<EntryRatioCarmine> entryRatioCarmine = entryRatioCarmineMapper.selectList(
                    new LambdaQueryWrapper<EntryRatioCarmine>().eq(EntryRatioCarmine::getMainId,1)
            );

            List<Long> entryRatioCarmineSet = entryRatioCarmine.stream().map(EntryRatioCarmine::getUserId).collect(Collectors.toList());

            // 取其中最小的number
            if(entryRatioCarmine.isEmpty()){
                throw new CustomException(ResultCode.ERROR.code(),"默认配置中没有设置劫持卡密");
            }

            EntryRatioCarmine minEntryRatioCarmine = entryRatioCarmine.stream()
                    .min(Comparator.comparingInt(EntryRatioCarmine::getNumber))
                    .orElse(null);

            customers.forEach(user -> {
                // 查询单条劫持配置项
                EntryRatio entryRatio = mapper.selectOne(
                        new LambdaQueryWrapper<EntryRatio>().eq(EntryRatio::getMainUserId, user.getId())
                );
                if(entryRatio == null){
                    entryRatio = new EntryRatio();
                    entryRatio.setMainUserId(user.getId());
                    entryRatio.setMainRadioNumberTwo(entryRatioSetting.getMainNumberTwo());
                    entryRatio.setSubRadioNumberTwo(entryRatioSetting.getSubNumberTwo());
                    entryRatio.setSystemTotalNumberTwo(user.getIsSearch().equals(1) ? entryRatioSetting.getTotalNumber() : entryRatioSetting.getHackTotalNumber());
                    entryRatio.setSubUserIdTwo(minEntryRatioCarmine.getUserId());
                    entryRatio.setSubCarmineTwo(minEntryRatioCarmine.getCarmine());
                    entryRatio.setSwitchCode(0);
                    mapper.insert(entryRatio);
                } else {
                    // 验证给当前设置的卡密是否在配置项中
                    if(!entryRatioCarmineSet.contains(entryRatio.getSubUserIdTwo())){
                        entryRatio.setSubUserIdTwo(minEntryRatioCarmine.getUserId());
                        entryRatio.setSubCarmineTwo(minEntryRatioCarmine.getCarmine());
                        entryRatio.setMainRadioNumberTwo(entryRatioSetting.getMainNumberTwo());
                        entryRatio.setSubRadioNumberTwo(entryRatioSetting.getSubNumberTwo());
                        entryRatio.setMainNumberTwo(0);
                        entryRatio.setSubNumberTwo(0);
                        entryRatio.setMainNumberTotal(0);
                        entryRatio.setSystemTotalNumberTwo(user.getIsSearch().equals(1) ? entryRatioSetting.getTotalNumber() : entryRatioSetting.getHackTotalNumber());
                        mapper.updateById(entryRatio);
                    }
                    // 在配置中则不执行任何操作
                }
            });

        });
    }

}
