package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author sy
 * @since 2026-06-12
 */
@Getter
@Setter
@TableName("cs_user_logs")
public class UserLogs implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long userId;

    /**
     * 操作的ip地址
     */
    private String ipAddress;

    /**
     * 操作备注
     */
    private String remark;

    /**
     * 操作名称
     */
    private String operateName;

    /**
     * 操作参数
     */
    private String arg;

    /**
     * 操作路径
     */
    private String uri;

    /**
     * 操作function
     */
    private String method;

    /**
     * 操作模块
     */
    private String model;

    /**
     * 创建时间
     */
    private Date createTime;


}
