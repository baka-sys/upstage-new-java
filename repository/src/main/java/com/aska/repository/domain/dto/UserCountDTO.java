package com.aska.repository.domain.dto;

import com.aska.repository.entity.UserCount;
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
public class UserCountDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "客户id")
    private Long userId;

    @ApiModelProperty(value = "客服id")
    private Long customerId;

    @ApiModelProperty(value = "上线时间")
    private Long loginTime;

    @ApiModelProperty(value = "离线时间")
    private Long offlineTime;

    @ApiModelProperty(value = "客户回复:0否,1是")
    private Integer clientReply;

    @ApiModelProperty(value = "客服回复:0否,1是")
    private Integer customerReply;

    @ApiModelProperty(value = "ip地址")
    private String ipAddress;

    @ApiModelProperty(value = "ip所属城市")
    private String cityName;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;


    public UserCountDTO() {}

    public UserCountDTO(UserCount entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static UserCountDTO convert(UserCount entity) {
        return new UserCountDTO(entity);
    }

    public static List<UserCountDTO> convertList(List<UserCount> list) {
        List<UserCountDTO> resultList = new ArrayList<>();
        for (UserCount entity : list) {
            resultList.add(new UserCountDTO(entity));
        }
        return resultList;
    }}
