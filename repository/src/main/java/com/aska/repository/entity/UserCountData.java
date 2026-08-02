package com.aska.repository.entity;


import lombok.Data;

@Data
public class UserCountData {

    /**
     * 客户总数
     */
    private Integer total;
    /**
     * 新增客户
     */
    private Integer todayTotal;
    /**
     * 5秒以上客户
     */
    private Integer secondTotal;
    /**
     * 活跃用户
     */
    private Integer activeUserTotal;

    /**
     * 回复率
     */
    private Float responseRate;
}
