package com.aska.repository.domain.dto;

import com.aska.repository.entity.Mass;
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
public class MassDTO {

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

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


    public MassDTO() {}

    public MassDTO(Mass entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static MassDTO convert(Mass entity) {
        return new MassDTO(entity);
    }

    public static List<MassDTO> convertList(List<Mass> list) {
        List<MassDTO> resultList = new ArrayList<>();
        for (Mass entity : list) {
            resultList.add(new MassDTO(entity));
        }
        return resultList;
    }}
