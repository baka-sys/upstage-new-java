package com.aska.repository.entity;


import lombok.Data;

@Data
public class BatchRenewRequest {

    /**
     * 卡密列表
     */
    private String carmines;

    /**
     * 天数
     */
    private Double days;

    /**
     * 最大限制人数
     */
    private Integer maxNumber;
}
