package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Domain;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author sy
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class DomainDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "活码id")
    private Long liveCodeId;

    @ApiModelProperty(value = "客服")
    private Long userId;

    @ApiModelProperty(value = "0：公共域名,1：专属域名")
    private Integer type;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public DomainDTO() {}

    public DomainDTO(Domain entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static DomainDTO convert(Domain entity) {
        return new DomainDTO(entity);
    }

    public static List<DomainDTO> convertList(List<Domain> list) {
        List<DomainDTO> resultList = new ArrayList<>();
        for (Domain entity : list) {
            resultList.add(new DomainDTO(entity));
        }
        return resultList;
    }}
