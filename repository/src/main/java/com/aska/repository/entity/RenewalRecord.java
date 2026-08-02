package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 续费记录
 * </p>
 *
 * @author sy
 * @since 2025-03-10
 */
@Getter
@Setter
@TableName("cs_renewal_record")
public class RenewalRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 续费账号id
     */
    private Long userId;

    /**
     * 续费类型：0，卡密续费，1、积分续费
     */
    private Integer type;

    /**
     * 续费的管理id
     */
    private Long accountId;

    /**
     * 续费的卡密号
     */
    private String carmine;

    /**
     * 续费天数
     */
    private Double days;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 账号续费时的过期时间
     */
    private Date expirationDate;


}
