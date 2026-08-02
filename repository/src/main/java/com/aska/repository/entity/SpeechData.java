package com.aska.repository.entity;


import lombok.Data;

@Data
public class SpeechData {

    /**
     * 用户集合
     */
    private String userIds;

    /**
     * 复制功能集合
     */
    private String functionIds;

    /**
     * 是否移除自己的
     */
    private Integer isRemove;
}
