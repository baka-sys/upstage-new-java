package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Url;
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
public class UrlDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "客户或者企业端用户")
    private Long userId;

    @ApiModelProperty(value = "域名")
    private String url;

    @ApiModelProperty(value = "账号类型")
    private Integer accountType;

    private Date createTime;

    private Date updateTime;


    public UrlDTO() {}

    public UrlDTO(Url entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static UrlDTO convert(Url entity) {
        return new UrlDTO(entity);
    }

    public static List<UrlDTO> convertList(List<Url> list) {
        List<UrlDTO> resultList = new ArrayList<>();
        for (Url entity : list) {
            resultList.add(new UrlDTO(entity));
        }
        return resultList;
    }}
