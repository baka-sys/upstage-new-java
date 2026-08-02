package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 用户在线表
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Getter
@Setter
@TableName("cs_user_online_status")
public class UserOnlineStatus implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    @ApiModelProperty(value = "账号类型")
    private Integer type;

    private Long userId;

    /**
     * 在线状态:1，在线，2，不在线
     */
    private Integer status;

    /**
     * 修改时间
     */
    private Date updateTime;


}
