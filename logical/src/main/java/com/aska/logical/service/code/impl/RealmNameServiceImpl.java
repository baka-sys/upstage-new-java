package com.aska.logical.service.code.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.CovertUtil;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.repository.entity.BatchDomain;
import com.aska.repository.entity.OperationAuto;
import com.aska.repository.entity.RealmName;
import com.aska.repository.mapper.OperationAutoMapper;
import com.aska.repository.mapper.RealmNameMapper;
import com.aska.logical.service.code.IRealmNameService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URL;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
@Service
public class RealmNameServiceImpl extends ServiceImpl<RealmNameMapper, RealmName> implements IRealmNameService {

    @Autowired
    RealmNameMapper mapper;

    @Autowired
    IOperationAutoService operationAutoService;

    @Autowired
    OperationAutoMapper operationAutoMapper;

    @Override
    public Page<RealmName> selectPage(Integer page, Integer limit){
        Page<RealmName> realmNamePage = new Page<>(page,limit);
        QueryWrapper<RealmName> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().eq(RealmName::getDeleted,0).orderByAsc(RealmName::getCreateTime);
        return mapper.selectPage(realmNamePage,queryWrapper);
    }

    @Override
    public void batchAdd(BatchDomain batchDomain){
        //分割所有域名
        List<String> domains = Arrays.asList(batchDomain.getDomainNames().split(","));
        if (domains == null || domains.size() == 0) {
            throw new CustomException(ResultCode.URL_IS_NOT_NULL);
        }
        if(domains.size() > 0){
            //排序
            domains.stream().forEach(domain -> {
                try {
                    new URL(domain);
                } catch (Exception e) {
                    throw new CustomException(ResultCode.URL_INFO_IS_ERROR.code(),ResultCode.URL_INFO_IS_ERROR.message() + domain);
                }
                RealmName domain2 = new RealmName();
                domain2.setDomain(domain);
                domain2.setCreateTime(DateUtil.date());
                mapper.insert(domain2);
            });
        }
    }

    @Override
    public void updateRealmName(RealmName realmName){
        RealmName realmName1 = mapper.selectById(realmName.getId());
        if(realmName1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        realmName.setUpdateTime(DateUtil.date());
        mapper.updateById(realmName);
    }


    @Override
    @Transactional(rollbackFor = RuntimeException.class)
    public void setShellTypeAndDomain(Long id, Integer shellType){
        RealmName realmName1 = mapper.selectById(id);
        if(realmName1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        // 查询当前是否有默认入口数据,如果存在直接屏蔽之前的入口数据
        if(realmName1.getStatus() == 1){
            RealmName realmName2 = mapper.selectOne(
                    new LambdaQueryWrapper<RealmName>()
                            .eq(RealmName::getType,shellType + 1).eq(RealmName::getDeleted,0)
            );
            if(realmName2 == null){
                realmName1.setStatus(0);
                realmName1.setType(shellType + 1);
                realmName1.setUpdateTime(DateUtil.date());
                mapper.updateById(realmName1);
            } else {
                realmName2.setStatus(1);
                realmName2.setType(0);
                realmName2.setUpdateTime(DateUtil.date());
                mapper.updateById(realmName2);

                realmName1.setStatus(0);
                realmName1.setType(shellType + 1);
                realmName1.setUpdateTime(DateUtil.date());
                mapper.updateById(realmName1);
            }

            // 并修改配置项数据
            List<OperationAuto> config = operationAutoService.selectAllSystem();
            OperationAuto operationAuto;
            if(shellType == 0){
                operationAuto = config.stream().filter(e->e.getField().equals("main_url")).findFirst().get();
            } else {
                operationAuto = config.stream().filter(e->e.getField().equals("s_main_url")).findFirst().get();
            }
            operationAuto.setValue(realmName1.getDomain());
            operationAutoMapper.updateById(operationAuto);
        } else {
            realmName1.setStatus(1);
            realmName1.setType(0);
            realmName1.setUpdateTime(DateUtil.date());
            mapper.updateById(realmName1);
        }
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public void batchDelete(String ids) {
        List<Long> idsList = CovertUtil.covertLongList(ids);
        QueryWrapper<RealmName> queryWrapper = new QueryWrapper<>();
        queryWrapper.lambda().in(RealmName::getId, idsList);
        RealmName domain = new RealmName();
        domain.setDeleted(1);
        domain.setDeleteTime(DateUtil.date());
        mapper.update(domain, queryWrapper);
    }

}
