package com.aska.repository.entity;


import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.io.Serializable;

@Getter
@Setter
@Document(collection  = "chat-record")
public class ChatRecord implements Serializable {

    @Field("message_id")
    private String messageId;

    /**
     * 发送人
     */
    @Field("from_id")
    private Long fromId;

    /**
     * 接收人
     */
    @Field("to_id")
    private Long toId;

    /**
     * 发送时间
     */
    @Field("time")
    private Long time;

    /**
     * 发送消息类型
     */
    @Field("message_type")
    private Integer messageType;

    /**
     * 是否是今天的第一条
     */
    @Field("is_first")
    private Integer isFirst=0;

    @Transient
    private Long sessionId;

    /**
     * 内容
     */
    @Field("content")
    private String content;


    @Transient
    private Integer property;

    /**
     * 已读，未读 0未读，1已读
     */
    @Field("status")
    private Integer status;

    @Transient
    private Boolean isClick=false;

}
