package com.aska.repository.entity;

import lombok.Data;

@Data
public class CodeCount {

    /**
     * 今日新增活码
     */
    private Integer codeTodayNumber;

    /**
     * 今日新增普通活码
     */
    private Integer localCodeTodayNumber;

    /**
     * 今日新增s型活码
     */
    private Integer sCodeTodayNumber;

    /**
     * 活码失效总数
     */
    private Integer codeFailTodayNumber;

    /**
     * 普通失效总数
     */
    private Integer localCodeFailTodayNumber;

    /**
     * s失效总数
     */
    private Integer sCodeFailTodayNumber;

    /**
     * 新增入口域名
     */
    private Integer entranceNumber;

    /**
     * 入口失效域名
     */
    private Integer entranceFailNumber;
}
