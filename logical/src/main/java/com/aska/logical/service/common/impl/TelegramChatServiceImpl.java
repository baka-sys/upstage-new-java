package com.aska.logical.service.common.impl;

import com.aska.repository.entity.TelegramChat;
import com.aska.repository.mapper.TelegramChatMapper;
import com.aska.logical.service.common.ITelegramChatService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2026-03-01
 */
@Service
public class TelegramChatServiceImpl extends ServiceImpl<TelegramChatMapper, TelegramChat> implements ITelegramChatService {

}
