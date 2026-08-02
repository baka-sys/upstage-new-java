package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 会话扩展表
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Getter
@Setter
@TableName("cs_chat_session_son")
public class ChatSessionSon implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 主表id
     */
    private Long sessionId;

    /**
     * 发送时间
     */
    private Long sendTime;

    /**
     * 发送内容
     */
    private String content;

    /**
     * 发送格式
     */
    private Integer type;

    /**
     * 未读数量
     */
    private Integer unread;


}
