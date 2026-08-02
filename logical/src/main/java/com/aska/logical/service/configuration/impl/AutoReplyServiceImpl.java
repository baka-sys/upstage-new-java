package com.aska.logical.service.configuration.impl;

import com.aska.repository.entity.AutoReply;
import com.aska.repository.mapper.AutoReplyMapper;
import com.aska.logical.service.configuration.IAutoReplyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 自动回复 服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-06-13
 */
@Service
public class AutoReplyServiceImpl extends ServiceImpl<AutoReplyMapper, AutoReply> implements IAutoReplyService {

}
