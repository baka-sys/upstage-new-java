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
 * 用户表
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
@Getter
@Setter
@TableName("cs_customer")
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户名
     */
    private String name;

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
     * 账号状态，0：启用，1： 禁用
     */
    private Integer status;

    /**
     * 企业账号id
     */
    private Long accountId;

    /**
     * 卡密
     */
    private String carmine;

    /**
     * 创建时间
     */
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
     * 激活时间
     */
    private Date activeTime;

    /**
     * 卡密购买天数,可以是小数
     */
    private Double days;

    /**
     * 到期时间
     */
    private Date expirationDate;

    /**
     * 激活状态：0，未激活，1、已激活、2、已续费，3、已过期
     */
    private Integer activeState;

    /**
     * 测试卡：0不是，1是
     */
    private Integer testCard;

    /**
     * 最大进人数量
     */
    private Integer maxNumber;

    /**
     * 1:普通卡，2：劫持卡
     */
    private Integer isSearch;

    /**
     * 渠道备注
     */
    private String channelRemark;


}
