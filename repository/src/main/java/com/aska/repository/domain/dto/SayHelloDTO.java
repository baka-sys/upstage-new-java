package com.aska.repository.domain.dto;

import com.aska.repository.entity.SayHello;
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
public class SayHelloDTO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "快捷回复自增id")
    private Long id;

    @ApiModelProperty(value = "客服id")
    private Long userId;

    @ApiModelProperty(value = "快捷回复的内容")
    private String content;

    @ApiModelProperty(value = "类型：0：文字，1：图片")
    private Integer type;

    @ApiModelProperty(value = "类型：0：客服，1：管理账号")
    private Integer accountType;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "状态:0,开启，1关闭")
    private Integer status;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


    public SayHelloDTO() {}

    public SayHelloDTO(SayHello entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static SayHelloDTO convert(SayHello entity) {
        return new SayHelloDTO(entity);
    }

    public static List<SayHelloDTO> convertList(List<SayHello> list) {
        List<SayHelloDTO> resultList = new ArrayList<>();
        for (SayHello entity : list) {
            resultList.add(new SayHelloDTO(entity));
        }
        return resultList;
    }}
