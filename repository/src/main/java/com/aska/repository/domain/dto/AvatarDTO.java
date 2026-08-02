package com.aska.repository.domain.dto;

import com.aska.repository.entity.Avatar;
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
public class AvatarDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "图片地址")
    private String url;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public AvatarDTO() {}

    public AvatarDTO(Avatar entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static AvatarDTO convert(Avatar entity) {
        return new AvatarDTO(entity);
    }

    public static List<AvatarDTO> convertList(List<Avatar> list) {
        List<AvatarDTO> resultList = new ArrayList<>();
        for (Avatar entity : list) {
            resultList.add(new AvatarDTO(entity));
        }
        return resultList;
    }}
