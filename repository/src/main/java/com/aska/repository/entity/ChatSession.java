package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 会话表
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Getter
@Setter
@TableName("cs_chat_session")
public class ChatSession implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 主id
     */
    private Long fromId;

    /**
     * 到id
     */
    private Long toId;

    /**
     * 置顶：0不置顶,1置顶
     */
    private Integer settingTop;

    /**
     * 会话类型: 0：单聊，1群聊
     */
    private Integer type;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Long updateTime;


}
