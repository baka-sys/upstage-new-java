package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author sy
 * @since 2025-08-28
 */
@Getter
@Setter
@TableName("cs_scan_qrcode")
public class ScanQrcode implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 卡密id
     */
    private Long customerId;

    /**
     * 扫码次数
     */
    private Integer number;

    /**
     * ip地址
     */
    private String ipAddress;

    /**
     * 创建时间
     */
    private Date createTime;


}
