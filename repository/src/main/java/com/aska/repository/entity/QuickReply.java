package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 快捷回复表
 * </p>
 *
 * @author sy
 * @since 2025-01-16
 */
@Getter
@Setter
@TableName("cs_quick_reply")
public class QuickReply implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 快捷回复自增id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 客服id
     */
    private Long userId;

    /**
     * 快捷回复的内容
     */
    private String content;

    /**
     * 内容类型:0文字，1图片
     */
    private Integer type;

    /**
     * 账号类型，0客服，1管理账号
     */
    private String accountType;

    /**
     * 排序字段
     */
    private Integer sort;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    /**
     * 修改时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


}
