package com.aska.repository.entity;

import lombok.Data;

@Data
public class BatchDomainUrl {

    /**
     * 域名
     */
    private String domainNames;

    /**
     * 域名类型
     */
    private Integer type;
}
