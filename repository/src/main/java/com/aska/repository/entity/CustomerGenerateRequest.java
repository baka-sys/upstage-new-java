package com.aska.repository.entity;

import lombok.Data;

@Data
public class CustomerGenerateRequest {

    private Integer lines;

    private String password;

    private Double days;

    private Integer testCard;

    private String prefixString;

    private Integer qrcodeSwitch;

    private Integer maxNumber;

    private Integer isSearch;
}
