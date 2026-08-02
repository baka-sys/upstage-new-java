package com.aska.repository.domain.dto;

import com.aska.repository.entity.FallbackResponse;
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
public class FallbackResponseDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账号类型：0客服，1企业")
    private Integer accountType;

    @ApiModelProperty(value = "账号id")
    private Long userId;

    @ApiModelProperty(value = "回复类型：")
    private Integer type;

    @ApiModelProperty(value = "回复内容")
    private String content;

    @ApiModelProperty(value = "开关：0开，1关")
    private Integer status;

    private Date createTime;

    private Date updateTime;


    public FallbackResponseDTO() {}

    public FallbackResponseDTO(FallbackResponse entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static FallbackResponseDTO convert(FallbackResponse entity) {
        return new FallbackResponseDTO(entity);
    }

    public static List<FallbackResponseDTO> convertList(List<FallbackResponse> list) {
        List<FallbackResponseDTO> resultList = new ArrayList<>();
        for (FallbackResponse entity : list) {
            resultList.add(new FallbackResponseDTO(entity));
        }
        return resultList;
    }}
