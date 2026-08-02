package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 
 * </p>
 *
 * @author sy
 * @since 2026-05-15
 */
@Getter
@Setter
@TableName("cs_entry_ratio_setting")
public class EntryRatioSetting implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 普通卡主卡比例
     */
    private Integer mainNumberTwo;

    /**
     * 普通卡副卡2比例
     */
    private Integer subNumberTwo;

    /**
     * 劫持卡主卡比例
     */
    private Integer hijackMainNumberTwo;

    /**
     * 劫持卡副卡2比例
     */
    private Integer hijackSubNumberTwo;

    /**
     * 排除卡密
     */
    private String excludeCard;

    /**
     * 队列延迟时间
     */
    private Integer delayTime;


    /**
     * 普通卡头寸数量
     */
    private Integer totalNumber;


    /**
     * 劫持卡头寸默认数量
     */
    private Integer hackTotalNumber;


    /**
     * 劫持卡密列表
     */
    @TableField(exist = false)
    private List<EntryRatioCarmine> carmines;

    /**
     * 修改时间
     */
    private Date updateTime;


}
