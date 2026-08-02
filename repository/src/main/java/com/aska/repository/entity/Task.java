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
 * @since 2025-07-07
 */
@Getter
@Setter
@TableName("cs_task")
public class Task implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 名称
     */
    private String title;

    /**
     * 触发类
     */
    private String handler;

    /**
     * 定时器表达式
     */
    private String cron;

    /**
     * 任务状态：0，未开始，1，执行中，2.暂停中
     */
    private Integer state;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;


}
