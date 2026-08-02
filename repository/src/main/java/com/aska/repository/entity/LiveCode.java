package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 商户域名表
 * </p>
 *
 * @author sy
 * @since 2025-07-17
 */
@Getter
@Setter
@TableName("cs_live_code")
public class LiveCode implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 口子类型：0，公共域名，1、专属域名，2、短域名
     */
    private Integer type;

    /**
     * 口子类型：0，普通类型，1、S类型
     */
    private Integer shellType;

    /**
     * 平台类型
     */
    private Integer platformType;

    /**
     * 口子域名
     */
    private String domainName;

    /**
     * 排序字段
     */
    private Integer sort;

    /**
     * 绑定数量
     */
    private Integer number;

    /**
     * 访问数量
     */
    private Integer requestNumber;

    /**
     * 口子状态: 0、正常，1、异常（可根据专业检测拉取是否正常）
     */
    private Integer status;

    /**
     * 0、未删除，1已删除
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


    /**
     * 是否是直连域名
     */
    private Integer direct;


    /**
     * 卡密集合
     */
    @TableField(exist = false)
    private String carmineSet;


}
