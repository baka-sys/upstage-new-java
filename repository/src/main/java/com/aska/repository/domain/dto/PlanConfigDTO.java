package com.aska.repository.domain.dto;

import com.aska.repository.entity.PlanConfig;
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
public class PlanConfigDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "方案标题")
    private String title;

    @ApiModelProperty(value = "背景图片")
    private String img;

    @ApiModelProperty(value = "内容")
    private String content;

    @ApiModelProperty(value = "状态")
    private Integer status;

    private Date createTime;

    private Date updateTime;


    public PlanConfigDTO() {}

    public PlanConfigDTO(PlanConfig entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static PlanConfigDTO convert(PlanConfig entity) {
        return new PlanConfigDTO(entity);
    }

    public static List<PlanConfigDTO> convertList(List<PlanConfig> list) {
        List<PlanConfigDTO> resultList = new ArrayList<>();
        for (PlanConfig entity : list) {
            resultList.add(new PlanConfigDTO(entity));
        }
        return resultList;
    }}
