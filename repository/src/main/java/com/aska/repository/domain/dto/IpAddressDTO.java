package com.aska.repository.domain.dto;

import com.aska.repository.entity.IpAddress;
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
public class IpAddressDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "ip次数")
    private String ipAddress;

    @ApiModelProperty(value = "停留次数")
    private Integer number;

    private Date createTime;

    private Date updateTime;


    public IpAddressDTO() {}

    public IpAddressDTO(IpAddress entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static IpAddressDTO convert(IpAddress entity) {
        return new IpAddressDTO(entity);
    }

    public static List<IpAddressDTO> convertList(List<IpAddress> list) {
        List<IpAddressDTO> resultList = new ArrayList<>();
        for (IpAddress entity : list) {
            resultList.add(new IpAddressDTO(entity));
        }
        return resultList;
    }}
