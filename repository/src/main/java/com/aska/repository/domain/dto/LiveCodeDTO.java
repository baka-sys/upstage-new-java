package com.aska.repository.domain.dto;

import com.aska.repository.entity.LiveCode;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class LiveCodeDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "口子类型：0，公共域名，1、专属域名，2、短域名")
    private Integer type;

    @ApiModelProperty(value = "口子类型：0，普通类型，1、S类型")
    private Integer shellType;

    @ApiModelProperty(value = "平台类型")
    private Integer platformType;

    @ApiModelProperty(value = "口子域名")
    private String domainName;

    @ApiModelProperty(value = "排序字段")
    private Integer sort;

    @ApiModelProperty(value = "绑定数量")
    private Integer number;

    @ApiModelProperty(value = "访问数量")
    private Integer requestNumber;

    @ApiModelProperty(value = "口子状态:0、正常，1、异常（可根据专业检测拉取是否正常）")
    private Integer status;

    @ApiModelProperty(value = "0、未删除，1已删除")
    private Integer deleted;

    @ApiModelProperty(value = "删除时间")
    private Date deleteTime;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "是否是直连域名")
    private Integer direct;

    @ApiModelProperty(value = "卡密集合")
    private String carmineSet;


    public LiveCodeDTO() {}

    public LiveCodeDTO(LiveCode entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static LiveCodeDTO convert(LiveCode entity) {
        return new LiveCodeDTO(entity);
    }

    public static List<LiveCodeDTO> convertList(List<LiveCode> list) {
        List<LiveCodeDTO> resultList = new ArrayList<>();
        for (LiveCode entity : list) {
            resultList.add(new LiveCodeDTO(entity));
        }
        return resultList;
    }}
