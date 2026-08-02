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
 * 劫持设置默认卡密
 * </p>
 *
 * @author sy
 * @since 2026-05-15
 */
@Getter
@Setter
@TableName("cs_entry_ratio_carmine")
public class EntryRatioCarmine implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 劫持卡密
     */
    private String carmine;

    /**
     * 主表cs_settint id
     */
    private Long mainId;

    /**
     * 劫持卡密id
     */
    private Long userId;

    /**
     * 绑定数量
     */
    private Integer number;

    /**
     * 修改时间
     */
    private Date updateTime;


}
