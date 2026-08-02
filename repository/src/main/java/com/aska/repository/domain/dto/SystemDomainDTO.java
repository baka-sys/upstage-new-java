package com.aska.repository.domain.dto;

import com.aska.repository.entity.SystemDomain;
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
public class SystemDomainDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "域名")
    private String domainUrl;

    @ApiModelProperty(value = "1:直连域名，2：图片域名，3、上传域名")
    private Integer type;

    @ApiModelProperty(value = "0:未使用，1：使用中")
    private Integer status;

    private Date updateTime;

    private Date createTime;


    public SystemDomainDTO() {}

    public SystemDomainDTO(SystemDomain entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static SystemDomainDTO convert(SystemDomain entity) {
        return new SystemDomainDTO(entity);
    }

    public static List<SystemDomainDTO> convertList(List<SystemDomain> list) {
        List<SystemDomainDTO> resultList = new ArrayList<>();
        for (SystemDomain entity : list) {
            resultList.add(new SystemDomainDTO(entity));
        }
        return resultList;
    }}
