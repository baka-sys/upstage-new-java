package com.aska.logical.service.common;

import java.util.Map;

public interface TelegramWebhookService {

    String onUpdate(Map<String, Object> update);

    void sendWeChatStopMessage();

    void sendMessageLiveCode();

    void sendMessage(Long chatId, String text);
}
