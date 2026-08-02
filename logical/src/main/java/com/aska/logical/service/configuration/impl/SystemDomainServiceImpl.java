package com.aska.logical.service.configuration.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.logical.service.configuration.ISystemDomainService;
import com.aska.repository.entity.BatchDomainUrl;
import com.aska.repository.entity.SystemDomain;
import com.aska.repository.mapper.SystemDomainMapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 * 系统域名配置 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-02-25
 */
@Service
public class SystemDomainServiceImpl extends ServiceImpl<SystemDomainMapper, SystemDomain> implements ISystemDomainService {


    @Autowired
    SystemDomainMapper mapper;

    @Autowired
    IOperationAutoService operationAutoService;


    @Override
    public Page<SystemDomain> getPageByLimit(Integer type,Integer status, Integer page, Integer limit) {

        Page<SystemDomain> systemDomainPage = new Page<>(page,limit);

        QueryWrapper<SystemDomain> queryWrapper = new QueryWrapper();
        queryWrapper.lambda()
                .eq(status!=null,SystemDomain::getStatus,status)
                .eq(type!=null, SystemDomain::getType,type);

        return mapper.selectPage(systemDomainPage,queryWrapper);
    }


    @Override
    public void addDomain(SystemDomain systemDomain) {
        systemDomain.setCreateTime(DateUtil.date());
        mapper.insert(systemDomain);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void addBatchDomain(BatchDomainUrl batchDomainUrl) {
        List<String> urls = Arrays.asList(batchDomainUrl.getDomainNames().split(","));
        if(urls.isEmpty()){
            throw new CustomException(ResultCode.ERROR.code(),"请填写域名");
        }
        List<SystemDomain> systemDomains = new ArrayList<>();
        urls.forEach(url->{
            SystemDomain systemDomain = new SystemDomain();
            systemDomain.setType(batchDomainUrl.getType());
            systemDomain.setDomainUrl(url);
            systemDomain.setCreateTime(DateUtil.date());

            systemDomains.add(systemDomain);
        });

        this.saveBatch(systemDomains);
    }


    @Override
    public void updateDomain(SystemDomain systemDomain) {
        SystemDomain systemDomain1 = mapper.selectById(systemDomain.getId());
        if(systemDomain1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        systemDomain.setUpdateTime(DateUtil.date());
        mapper.updateById(systemDomain);
    }

    @Override
    public void deleteDomain(Long id){
        SystemDomain systemDomain1 = mapper.selectById(id);
        if(systemDomain1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        mapper.deleteById(id);
    }

    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void updateStatus(Long id){

        SystemDomain systemDomain1 = mapper.selectById(id);
        if(systemDomain1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        if(systemDomain1.getStatus().equals(1)){
            throw new CustomException(ResultCode.ERROR.code(),"该数据已经使用，无须重复推送使用");
        }

        // 删除之前已经使用过的域名
        mapper.delete(
                new QueryWrapper<SystemDomain>().lambda()
                        .eq(SystemDomain::getType,systemDomain1.getType())
                        .eq(SystemDomain::getStatus,1)
        );

        systemDomain1.setStatus(1);
        systemDomain1.setUpdateTime(DateUtil.date());
        mapper.updateById(systemDomain1);

        // 修改配置项中对应的配置域名，图片域名推送给图片域名，入口域名推送给入口域名，上传域名推送给上传域名
        HashMap<String,String> hashMap = new HashMap<>();

        if(systemDomain1.getType().equals(1)){
            // 直连域名
            hashMap.put("main_url",systemDomain1.getDomainUrl());
        } else if(systemDomain1.getType().equals(2)){
            // 图片域名
            hashMap.put("image_url",systemDomain1.getDomainUrl());
        } else if(systemDomain1.getType().equals(3)){
            // 上传域名
            hashMap.put("upload_url",systemDomain1.getDomainUrl());
        }
        // 修改单条数据
        operationAutoService.updateOne(hashMap);
    }


    /**
     * 针对入口域名
     */
    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void updateMainUrlJob(){
        // 删除之前使用中的域名
        mapper.delete(
                new LambdaQueryWrapper<SystemDomain>()
                        // 调整url的类型
                        .in(SystemDomain::getType,1)
                        .eq(SystemDomain::getStatus,1)
        );

        // 获取排序最前的直连入口域名
        SystemDomain systemDomain1 = mapper.selectOne(
                new QueryWrapper<SystemDomain>().lambda()
                        .eq(SystemDomain::getType,1)
                        .eq(SystemDomain::getStatus,0)
                        .last("limit 1")
                        .orderByAsc(SystemDomain::getCreateTime)
        );

        if(systemDomain1 == null){
            throw new CustomException(ResultCode.ERROR.code(),"无最新入口域名");
        }
        systemDomain1.setStatus(1);
        systemDomain1.setCreateTime(DateUtil.date());

        mapper.updateById(systemDomain1);

        HashMap<String,String> hashMap1 = new HashMap<>();
        hashMap1.put("main_url",systemDomain1.getDomainUrl());

        operationAutoService.updateOne(hashMap1);

        // 后期接入邮件接口或者t接口
    }


    /**
     * 针对图片域名更换
     */
    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void updateMainUrlJobForImage(){

        mapper.delete(
                new LambdaQueryWrapper<SystemDomain>()
                        // 调整url的类型
                        .in(SystemDomain::getType,2,3)
                        .eq(SystemDomain::getStatus,1)
        );

        // 获取排序最前的图片域名
        SystemDomain systemDomain2 = mapper.selectOne(
                new QueryWrapper<SystemDomain>().lambda()
                        .eq(SystemDomain::getType,2)
                        .eq(SystemDomain::getStatus,0)
                        .last("limit 1")
                        .orderByAsc(SystemDomain::getCreateTime)
        );

        if(systemDomain2 == null){
            throw new CustomException(ResultCode.ERROR.code(),"无最新的图片域名");
        }

        systemDomain2.setStatus(1);
        systemDomain2.setCreateTime(DateUtil.date());

        mapper.updateById(systemDomain2);

        HashMap<String,String> hashMap2 = new HashMap<>();
        hashMap2.put("image_url",systemDomain2.getDomainUrl());

        operationAutoService.updateOne(hashMap2);

        // 获取排序最前的上传域名
        SystemDomain systemDomain3 = mapper.selectOne(
                new QueryWrapper<SystemDomain>().lambda()
                        .eq(SystemDomain::getType,3)
                        .eq(SystemDomain::getStatus,0)
                        .last("limit 1")
                        .orderByAsc(SystemDomain::getCreateTime)
        );

        if(systemDomain3 == null){
            throw new CustomException(ResultCode.ERROR.code(),"无最新的上传域名");
        }

        systemDomain3.setStatus(1);
        systemDomain3.setCreateTime(DateUtil.date());

        mapper.updateById(systemDomain3);

        HashMap<String,String> hashMap3 = new HashMap<>();
        hashMap3.put("upload_url",systemDomain3.getDomainUrl());

        operationAutoService.updateOne(hashMap3);

        // 后期接入邮件接口或者t接口
    }

}
