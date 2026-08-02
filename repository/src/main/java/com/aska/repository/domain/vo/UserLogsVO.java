package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.UserLogs;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class UserLogsVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static UserLogs convert(UserLogsVO vo) {
        UserLogs entity = new UserLogs();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<UserLogs> convertList(List<UserLogsVO> list) {
        List<UserLogs> resultList = new ArrayList<>();
        for (UserLogsVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
