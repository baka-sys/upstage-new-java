package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.UserLogs;
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
public class UserLogsDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long userId;

    @ApiModelProperty(value = "操作的ip地址")
    private String ipAddress;

    @ApiModelProperty(value = "操作备注")
    private String remark;

    @ApiModelProperty(value = "操作名称")
    private String operateName;

    @ApiModelProperty(value = "操作参数")
    private String arg;

    @ApiModelProperty(value = "操作路径")
    private String uri;

    @ApiModelProperty(value = "操作function")
    private String method;

    @ApiModelProperty(value = "操作模块")
    private String model;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;


    public UserLogsDTO() {}

    public UserLogsDTO(UserLogs entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static UserLogsDTO convert(UserLogs entity) {
        return new UserLogsDTO(entity);
    }

    public static List<UserLogsDTO> convertList(List<UserLogs> list) {
        List<UserLogsDTO> resultList = new ArrayList<>();
        for (UserLogs entity : list) {
            resultList.add(new UserLogsDTO(entity));
        }
        return resultList;
    }}
