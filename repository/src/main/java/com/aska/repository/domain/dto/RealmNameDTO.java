package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.RealmName;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class RealmNameDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "域名")
    private String domain;

    @ApiModelProperty(value = "0开启，关闭1")
    private Integer status;

    @ApiModelProperty(value = "开启之后才会有类型，0，无，1、普通，2、s")
    private Integer type;

    @ApiModelProperty(value = "0未删除，1删除")
    private Integer deleted;

    @ApiModelProperty(value = "删除时间")
    private Date deleteTime;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public RealmNameDTO() {}

    public RealmNameDTO(RealmName entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static RealmNameDTO convert(RealmName entity) {
        return new RealmNameDTO(entity);
    }

    public static List<RealmNameDTO> convertList(List<RealmName> list) {
        List<RealmNameDTO> resultList = new ArrayList<>();
        for (RealmName entity : list) {
            resultList.add(new RealmNameDTO(entity));
        }
        return resultList;
    }}
