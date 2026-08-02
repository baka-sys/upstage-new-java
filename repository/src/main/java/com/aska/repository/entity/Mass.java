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
 * 群发表
 * </p>
 *
 * @author sy
 * @since 2025-03-11
 */
@Getter
@Setter
@TableName("cs_mass")
public class Mass implements Serializable {

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
     * 类型：0：文字，1：图片
     */
    private Integer type;

    /**
     * 类型：0：客服，1：管理账号
     */
    private Integer accountType;

    /**
     * 排序
     */
    private Integer sort;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;


}
