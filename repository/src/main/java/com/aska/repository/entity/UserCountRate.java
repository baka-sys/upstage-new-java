package com.aska.repository.entity;


import lombok.Data;

@Data
public class UserCountRate {

    /**
     * 占比
     */
    private Float rate;

    /**
     * 城市名字
     */
    private String cityName;
}
