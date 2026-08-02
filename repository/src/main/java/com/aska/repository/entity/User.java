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
import java.util.List;

/**
 * <p>
 * 用户表
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
@Getter
@Setter
@TableName("cs_user")
public class User implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    private String name;

    /**
     * 备注
     */
    private String notes;

    /**
     * 头像
     */
    private String img;

    /**
     * 密码
     */
    private String password;

    /**
     * 用户账号
     */
    private String userAccount;

    /**
     * 手机号码
     */
    private String phoneNumber;

    /**
     * 账号类型，0：客户，1：客服
     */
    private Integer type;

    /**
     * 扣子类型：0，普通，1、s型
     */
    private Integer shellType;

    /**
     * 账号状态，0：启用，1： 禁用
     *
     */
    private Integer status;

    /**
     * ip地址
     */
    private String ipAddress;


    /**
     * ip地址所属地区
     */
    private String ipDistrict;

    /**
     * 浏览器名称
     */
    private String browserName;

    /**
     * 管理员账号id
     */
    private Long accountId;

    /**
     * 设备码
     */
    private String equipmentCode;

    /**
     * 平台
     */
    private String platform;

    /**
     * 用户唯一编码
     */
    private String userKey;

    /**
     * 卡密
     */
    private String carmine;

    /**
     * 创建时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 登录时间
     */
    private Date loginTime;

    /**
     * 到期时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date expirationDate;

    /**
     * 开通时间
     */
    private Double days;

    /**
     * 是否是新用户(0不是新用户，1是新用户)
     */
    @TableField(exist = false)
    private Integer isNew;

    /**
     * 今日进人总数
     */
    @TableField(exist = false)
    private Integer number;

    @TableField(exist = false)
    private Integer totalNumber;

    /**
     * 是否是黑名单
     */
    @TableField(exist = false)
    private Boolean isBlacklist;


    /**
     * 卡密状态: 0未激活，1已激活，2，已续费
     */
    private Integer activeState;


    /**
     * 是否是测试卡
     */
    private Integer testCard;

    /**
     * 最大进人数量
     */
    private Integer maxNumber;


    /**
     * 是否是劫持比例主卡
     */
    private Integer isSearch;

    /**
     * 域名集合
     */
    @TableField(exist = false)
    private String url;

    /**
     * 扫码次数
     */
    @TableField(exist = false)
    private Long scanNumber;


    /**
     * 打招呼列表
     */
    @TableField(exist = false)
    private List<SayHello> sayHellos;

    /**
     * 延迟比例设置
     */
    @TableField(exist = false)
    private EntryRatio entryRatio;

    /**
     * 用量
     */
    @TableField(exist = false)
    private Integer dosage;


    /**
     * 今日进人总量
     */
    @TableField(exist = false)
    private Integer todayTotal;
}
