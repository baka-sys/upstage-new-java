package com.aska.repository.domain.dto;

import com.aska.repository.entity.Admin;
import lombok.Data;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.aska.common.util.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;


/**
 * @author sy
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class AdminDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "密码")
    private String password;

    private Date createTime;

    private Date updateTime;


    public AdminDTO() {}

    public AdminDTO(Admin entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static AdminDTO convert(Admin entity) {
        return new AdminDTO(entity);
    }

    public static List<AdminDTO> convertList(List<Admin> list) {
        List<AdminDTO> resultList = new ArrayList<>();
        for (Admin entity : list) {
            resultList.add(new AdminDTO(entity));
        }
        return resultList;
    }}
