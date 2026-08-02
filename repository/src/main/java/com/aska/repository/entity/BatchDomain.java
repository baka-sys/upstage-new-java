package com.aska.repository.entity;


import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class BatchDomain {

    /**
     * 域名集合
     */
    private String domainNames;

    /**
     * 0: 公共域名, 1:专属域名
     */
    private Integer type;

    /**
     * 平台类型
     */
    private Integer platformType;

    /**
     * 是否是直连域名
     */
    private Integer direct;
}
