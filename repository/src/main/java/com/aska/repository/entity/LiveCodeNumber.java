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
 * 域名坑位表
 * </p>
 *
 * @author sy
 * @since 2025-11-15
 */
@Getter
@Setter
@TableName("cs_live_code_number")
public class LiveCodeNumber implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    private Long liveCodeId;

    private Integer number;

    private Date updateTime;


}
