package com.aska.repository.entity;


import lombok.Data;

@Data
public class BatchEntryRatio {

    private String mainUserIds;

    /**
     * 副卡卡密
     */
    private String subCarmine;


    /**
     * 主卡人数
     */
    private Integer mainRadioNumber;


    /**
     * 副卡人数
     */
    private Integer subRadioNumber;


    /**
     * 主卡2
     */
    private Integer mainRadioNumberTwo;

    /**
     * 副卡2
     */
    private Integer subRadioNumberTwo;


    /**
     * 开关
     */
    private Integer switchCode;

    /**
     * 头寸
     */
    private Integer systemTotalNumber;
}
