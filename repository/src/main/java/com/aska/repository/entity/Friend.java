package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 用户黑名单表
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Getter
@Setter
@TableName("cs_friend")
public class Friend implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 黑名单自增id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 用户id
     */
    private Long fromId;

    /**
     * 好友id
     */
    private Long toId;

    /**
     * 原因
     */
    private String reason;

    /**
     * 星标：0未选，1已选
     */
    private Integer star;

    /**
     * 黑名单状态：0-有效 1-无效
     */
    private Integer status;

    /**
     * 备注
     */
    private String remark;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;


}
