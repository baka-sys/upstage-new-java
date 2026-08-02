package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 用户统计表
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
@Getter
@Setter
@TableName("cs_user_count")
public class UserCount implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 客户id
     */
    private Long userId;

    /**
     * 客服id
     */
    private Long customerId;

    /**
     * 上线时间
     */
    private Long loginTime;

    /**
     * 离线时间
     */
    private Long offlineTime;

    /**
     * 客户回复: 0否,1是
     */
    private Integer clientReply;

    /**
     * 客服回复: 0否,1是
     */
    private Integer customerReply;

    /**
     * ip地址
     */
    private String ipAddress;

    /**
     * ip所属城市
     */
    private String cityName;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 创建时间
     */
    private Date createTime;


}
