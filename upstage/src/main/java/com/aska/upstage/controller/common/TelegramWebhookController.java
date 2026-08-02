package com.aska.upstage.controller.common;

import com.aska.logical.service.common.TelegramWebhookService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("telegram")
@Api(tags = "通知管理")
public class TelegramWebhookController {

    @Autowired
    TelegramWebhookService service;


    @PostMapping("/webhook")
    @ApiOperation(value = "telegram挂载")
    public ResponseEntity<String> onUpdate(@RequestBody Map<String,Object> update){
        return ResponseEntity.ok(service.onUpdate(update));
    }
}
