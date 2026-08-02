package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.UserOnlineStatus;
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
public class UserOnlineStatusVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    /**
     * 账号类型
     */
    @ApiModelProperty(value = "账号类型")
    private Integer type;

    private Long userId;

    @ApiModelProperty(value = "在线状态:1，在线，2，不在线")
    private Integer status;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static UserOnlineStatus convert(UserOnlineStatusVO vo) {
        UserOnlineStatus entity = new UserOnlineStatus();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<UserOnlineStatus> convertList(List<UserOnlineStatusVO> list) {
        List<UserOnlineStatus> resultList = new ArrayList<>();
        for (UserOnlineStatusVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
