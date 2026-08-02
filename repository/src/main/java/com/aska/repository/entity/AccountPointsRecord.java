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
 * 积分消费记录
 * </p>
 *
 * @author sy
 * @since 2025-03-27
 */
@Getter
@Setter
@TableName("cs_account_points_record")
public class AccountPointsRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 管理账号id
     */
    private Long accountId;

    /**
     * 类型:1、充值，2、消费
     */
    private Integer type;

    /**
     * 积分
     */
    private Double points;

    /**
     * 操作前积分
     */
    private Double beforeOperation;

    /**
     * 操作后积分
     */
    private Double afterOperation;

    /**
     * 创建时间
     */
    private Date createTime;


}
