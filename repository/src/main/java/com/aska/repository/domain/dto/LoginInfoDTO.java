package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Account;
import com.aska.repository.entity.LoginInfo;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;


@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class LoginInfoDTO {

    @ApiModelProperty(value = "token值")
    private String token;

    @ApiModelProperty(value = "刷新token值")
    private String refreshToken;

    public LoginInfoDTO() {}

    public LoginInfoDTO(LoginInfo entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static LoginInfoDTO convert(LoginInfo entity) {
        return new LoginInfoDTO(entity);
    }

    public static List<LoginInfoDTO> convertList(List<LoginInfo> list) {
        List<LoginInfoDTO> resultList = new ArrayList<>();
        for (LoginInfo entity : list) {
            resultList.add(new LoginInfoDTO(entity));
        }
        return resultList;
    }
}
