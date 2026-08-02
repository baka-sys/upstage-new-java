package com.aska.repository.entity;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class AccountToken {

    /**
     * 用户id
     */
    private Long id;

    /**
     * 用户名
     */
    private String accountName;

    /**
     * token md5字符串
     */
    private String md5TokenStr;


    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date expiresAt;
}
