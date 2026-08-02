package com.aska.repository.domain.dto;

import com.aska.repository.entity.ExclusiveCode;
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
public class ExclusiveCodeDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "专属域名id")
    private Long liveCodeId;

    @ApiModelProperty(value = "专属地址")
    private String exclusiveUrl;

    @ApiModelProperty(value = "0:使用中，1：关闭")
    private Integer status;

    private Date createTime;

    private Date updateTime;


    public ExclusiveCodeDTO() {}

    public ExclusiveCodeDTO(ExclusiveCode entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static ExclusiveCodeDTO convert(ExclusiveCode entity) {
        return new ExclusiveCodeDTO(entity);
    }

    public static List<ExclusiveCodeDTO> convertList(List<ExclusiveCode> list) {
        List<ExclusiveCodeDTO> resultList = new ArrayList<>();
        for (ExclusiveCode entity : list) {
            resultList.add(new ExclusiveCodeDTO(entity));
        }
        return resultList;
    }}
