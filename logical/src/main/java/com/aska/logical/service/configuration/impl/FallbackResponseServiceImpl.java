package com.aska.logical.service.configuration.impl;

import com.aska.repository.entity.FallbackResponse;
import com.aska.repository.mapper.FallbackResponseMapper;
import com.aska.logical.service.configuration.IFallbackResponseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 兜底回复 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-06-13
 */
@Service
public class FallbackResponseServiceImpl extends ServiceImpl<FallbackResponseMapper, FallbackResponse> implements IFallbackResponseService {

}
