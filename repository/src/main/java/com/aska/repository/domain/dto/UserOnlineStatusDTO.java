package com.aska.repository.domain.dto;

import com.aska.repository.entity.UserOnlineStatus;
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
public class UserOnlineStatusDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账号类型")
    private Integer type;

    private Long userId;

    @ApiModelProperty(value = "在线状态:1，在线，2，不在线")
    private Integer status;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public UserOnlineStatusDTO() {}

    public UserOnlineStatusDTO(UserOnlineStatus entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static UserOnlineStatusDTO convert(UserOnlineStatus entity) {
        return new UserOnlineStatusDTO(entity);
    }

    public static List<UserOnlineStatusDTO> convertList(List<UserOnlineStatus> list) {
        List<UserOnlineStatusDTO> resultList = new ArrayList<>();
        for (UserOnlineStatus entity : list) {
            resultList.add(new UserOnlineStatusDTO(entity));
        }
        return resultList;
    }}
