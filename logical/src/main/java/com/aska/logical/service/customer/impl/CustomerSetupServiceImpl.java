package com.aska.logical.service.customer.impl;

import com.aska.repository.entity.CustomerSetup;
import com.aska.repository.mapper.CustomerSetupMapper;
import com.aska.logical.service.customer.ICustomerSetupService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 客服设置表 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
@Service
public class CustomerSetupServiceImpl extends ServiceImpl<CustomerSetupMapper, CustomerSetup> implements ICustomerSetupService {

}
