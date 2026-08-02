package com.aska.logical.service.common.impl;


import cn.hutool.core.date.DateUtil;
import com.aska.logical.service.common.TelegramWebhookService;
import com.aska.repository.entity.TelegramChat;
import com.aska.repository.mapper.TelegramChatMapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.*;

@Service
public class TelegramWebhookServiceImpl implements TelegramWebhookService {

    private final static String BOT_TOKEN = "8769537186:AAE1Au8YUKHbhepmsKR5sHuJM4Dj4SdAuOE";

    @Autowired
    TelegramChatMapper chatMapper;
    @Autowired
    private TelegramChatMapper telegramChatMapper;


    @Override
    public String onUpdate(Map<String, Object> update){
        Map<String,Object> message = (Map<String, Object>) update.get("message");
        if(message == null) return "ok";
        String text = (String) message.get("text");
        Map<String,Object> chat = (Map<String, Object>) message.get("chat");
        Long chatId = Long.valueOf(chat.get("id").toString());
        if(text == null) return "ok";
        if(text.equals("/start")){
            sendMainMenu(chatId);
        } else if (text.equals("绑定账号")){
            sendMessage(chatId, "请输入你的用户ID：");
        } else {
            // chatId 存入到数据中，下次推送直接推送
            System.out.println(text);
            if(text.equals("66")){
                TelegramChat telegramChat = new TelegramChat();
                telegramChat.setChatId(chatId);
                telegramChat.setCreateTime(DateUtil.date());
                telegramChatMapper.insert(telegramChat);
                sendMessage(chatId,"恭喜你邦定成功,用户ID是：" + text);
            } else {
                sendMessage(chatId,"你输入的是：" + text);
            }
        }
        return "ok";
    }

    @Override
    public void sendWeChatStopMessage(){
        // 查询所有chatId
        List<TelegramChat> telegramChats = telegramChatMapper.selectList(new QueryWrapper<>());
        if(!telegramChats.isEmpty()){
            telegramChats.forEach(telegramChat -> {
                sendMessage(telegramChat.getChatId(),"微信检测已经停止，网络出现问题，请检查网络并人工检测");
            });
        }
    }

    @Override
    public void sendMessageLiveCode(){
        // 查询所有chatId
        List<TelegramChat> telegramChats = telegramChatMapper.selectList(new QueryWrapper<>());
        if(!telegramChats.isEmpty()){
            telegramChats.forEach(telegramChat -> {
                sendMessage(telegramChat.getChatId(),"域名即耗尽，请尽快添加域名");
            });
        }
    }

    @Override
    public void sendMessage(Long chatId, String text){

        String url = "https://api.telegram.org/bot" + BOT_TOKEN + "/sendMessage";

        RestTemplate restTemplate = new RestTemplate();

        Map<String,Object> body = new HashMap<>();

        body.put("chat_id", chatId);

        body.put("text", text);

        restTemplate.postForObject(url, body, Map.class);
    }

    private void sendMainMenu(Long chatId){
        String url = "https://api.telegram.org/bot" + BOT_TOKEN + "/sendMessage";
        RestTemplate restTemplate = new RestTemplate();

        Map<String,Object> keyboard = new HashMap<>();

        keyboard.put("keyboard", Arrays.asList(
                Arrays.asList(Collections.singletonMap("text", "绑定账号"))
//                Arrays.asList(Collections.singletonMap("text", "解绑账号"))
        ));

        Map<String,Object>  body = new HashMap<>();
        body.put("chat_id", chatId);
        body.put("text","欢迎使用机器人，请选择：");
        body.put("reply_markup",keyboard);
        restTemplate.postForObject(url, body, Map.class);
    }

}
