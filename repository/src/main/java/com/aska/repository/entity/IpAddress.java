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
 * 
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Getter
@Setter
@TableName("cs_ip_address")
public class IpAddress implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * ip次数
     */
    private String ipAddress;

    /**
     * 停留次数
     */
    private Integer number;

    private Date createTime;

    private Date updateTime;


}
