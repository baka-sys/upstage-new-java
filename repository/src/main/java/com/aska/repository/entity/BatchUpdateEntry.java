package com.aska.repository.entity;


import lombok.Data;

@Data
public class BatchUpdateEntry {

    /**
     * 区分普通卡和劫持卡
     */
    private Integer type;

    /**
     * 主卡进人数量
     */
    private Integer mainRadioNumberTwo;

    /**
     * 副卡进入数量
     */
    private Integer subRadioNumberTwo;

    /**
     * 开关：0开，1关
     */
    private Integer switchCodeTwo;
}
