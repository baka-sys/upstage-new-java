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
 * 系统域名配置
 * </p>
 *
 * @author sy
 * @since 2026-02-25
 */
@Getter
@Setter
@TableName("cs_system_domain")
public class SystemDomain implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 域名
     */
    private String domainUrl;

    /**
     * 1:直连域名，2：图片域名，3、上传域名
     */
    private Integer type;

    /**
     * 0:未使用，1：使用中
     */
    private Integer status;

    private Date updateTime;

    private Date createTime;


}
