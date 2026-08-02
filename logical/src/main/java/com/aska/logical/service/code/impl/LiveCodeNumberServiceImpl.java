package com.aska.logical.service.code.impl;

import com.aska.repository.entity.LiveCodeNumber;
import com.aska.repository.mapper.LiveCodeNumberMapper;
import com.aska.logical.service.code.ILiveCodeNumberService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 域名坑位表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-11-15
 */
@Service
public class LiveCodeNumberServiceImpl extends ServiceImpl<LiveCodeNumberMapper, LiveCodeNumber> implements ILiveCodeNumberService {

}
