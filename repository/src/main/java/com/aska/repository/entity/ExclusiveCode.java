package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 专属域名
 * </p>
 *
 * @author sy
 * @since 2026-03-15
 */
@Getter
@Setter
@TableName("cs_exclusive_code")
public class ExclusiveCode implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 专属域名id
     */
    private Long liveCodeId;

    /**
     * 专属地址
     */
    private String exclusiveUrl;

    /**
     * 0:使用中，1：关闭
     */
    private Integer status;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 修改时间
     */
    private Date updateTime;


}
