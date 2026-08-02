package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 方案设置
 * </p>
 *
 * @author sy
 * @since 2026-05-17
 */
@Getter
@Setter
@TableName("cs_plan_config")
public class PlanConfig implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 方案标题
     */
    private String title;

    /**
     * 背景图片
     */
    private String img;

    /**
     * 内容
     */
    private String content;

    /**
     * 开启或者关闭，0开启，1关闭
     */
    private Integer status;

    private Date createTime;

    private Date updateTime;


}
