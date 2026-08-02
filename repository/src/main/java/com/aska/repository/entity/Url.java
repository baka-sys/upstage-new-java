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
 * 域名表
 * </p>
 *
 * @author sy
 * @since 2025-03-17
 */
@Getter
@Setter
@TableName("cs_url")
public class Url implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 客户或者企业端用户
     */
    private Long userId;

    /**
     * 域名
     */
    private String url;

    /**
     * 账号类型
     */
    private Integer accountType;

    private Date createTime;

    private Date updateTime;


}
