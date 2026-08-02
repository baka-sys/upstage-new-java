package com.aska.repository.entity;


import lombok.Data;

@Data
public class LoginInfo {

    private String token;

    private String refreshToken;

    private String imageUrl;
}
