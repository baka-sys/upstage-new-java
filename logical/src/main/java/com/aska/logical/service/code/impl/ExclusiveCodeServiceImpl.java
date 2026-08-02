package com.aska.logical.service.code.impl;

import com.aska.repository.entity.ExclusiveCode;
import com.aska.repository.mapper.ExclusiveCodeMapper;
import com.aska.logical.service.code.IExclusiveCodeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 专属域名 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-03-15
 */
@Service
public class ExclusiveCodeServiceImpl extends ServiceImpl<ExclusiveCodeMapper, ExclusiveCode> implements IExclusiveCodeService {

    @Autowired
    ExclusiveCodeMapper mapper;

}
