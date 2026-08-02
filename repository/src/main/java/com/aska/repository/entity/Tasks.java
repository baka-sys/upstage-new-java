package com.aska.repository.entity;


import lombok.Builder;
import lombok.Data;

import java.util.Date;

@Builder
@Data
public class Tasks {

    /**
     * 任务名
     */
    private String jobName;

    /**
     * 分组名称
     */
    private String jobGroupName;

    /**
     * 触发类
     */
    private String jobForName;

    /**
     * 触发器名
     */
    private String triggerName;

    /**
     * 触发器分组
     */
    private String triggerGroup;

    /**
     * 时间表达式
     */
    private String cronExpression;

    /**
     * 参数
     */
    private String params;

    /**
     * 触发器开始时间
     */
    private Date startTime;

    /**
     * 触发器结束时间
     */
    private Date endTime;
}
