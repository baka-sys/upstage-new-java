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
 * 
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
@Getter
@Setter
@TableName("cs_realm_name")
public class RealmName implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 域名
     */
    private String domain;

    /**
     * 0开启，关闭1
     */
    private Integer status;

    /**
     * 开启之后才会有类型，0，无，1、普通，2、s
     */
    private Integer type;

    /**
     * 0未删除，1删除
     */
    private Integer deleted;

    /**
     * 删除时间
     */
    private Date deleteTime;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;


}
