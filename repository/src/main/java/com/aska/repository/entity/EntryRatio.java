package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 劫持比例表
 * </p>
 *
 * @author sy
 * @since 2026-01-06
 */
@Getter
@Setter
@TableName("cs_entry_ratio")
public class EntryRatio implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 主卡
     */
    private Long mainUserId;

    /**
     * 主卡密
     */
    private String mainCarmine;

    /**
     * 副卡
     */
    private Long subUserId;

    /**
     * 副卡密
     */
    private String subCarmine;

    /**
     * 主卡比例数量
     */
    private Integer mainRadioNumber;

    /**
     * 副卡比例数量
     */
    private Integer subRadioNumber;

    /**
     * 主卡进人数量
     */
    private Integer mainNumber;

    /**
     * 副卡进入数量
     */
    private Integer subNumber;

    /**
     * 副卡2
     */
    private Long subUserIdTwo;

    /**
     * 副卡2
     */
    private String subCarmineTwo;

    /**
     * 主卡2比例数量
     */
    private Integer mainRadioNumberTwo;

    /**
     * 副卡2比例数量
     */
    private Integer subRadioNumberTwo;

    /**
     * 主卡进人数量
     */
    private Integer mainNumberTwo;

    /**
     * 副卡进入数量
     */
    private Integer subNumberTwo;

    /**
     * 开关：0开，1关
     */
    private Integer switchCode;

    /**
     * 主要进人数量
     */
    private Integer mainNumberTotal;

    /**
     * 头寸数量
     */
    private Integer systemTotalNumber;

    /**
     * 副卡开关2
     */
    private Integer switchCodeTwo;

    /**
     * 副卡2头寸总数
     */
    private Integer mainNumberTotalTwo;

    /**
     * 副卡2头寸数量
     */
    private Integer systemTotalNumberTwo;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;


}
