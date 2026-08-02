package com.aska.upstage.controller.common;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.common.TelegramWebhookService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-03-01
 */
@RestController
@RequestMapping("telegramChat")
public class TelegramChatController {

    @Autowired
    TelegramWebhookService service;

    @PostMapping("send")
    @ApiOperation(value = "发送消息")
    public ResponseData sendMessage(){
        service.sendWeChatStopMessage();
        return ResponseData.success();
    }
}
