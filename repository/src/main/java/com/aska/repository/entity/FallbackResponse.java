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
 * 兜底回复
 * </p>
 *
 * @author sy
 * @since 2026-06-13
 */
@Getter
@Setter
@TableName("cs_fallback_response")
public class FallbackResponse implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 账号类型：0 客服，1企业
     */
    private Integer accountType;

    /**
     * 账号id
     */
    private Long userId;

    /**
     * 回复类型：
     */
    private Integer type;

    /**
     * 回复内容
     */
    private String content;

    /**
     * 开关：0开，1关
     */
    private Integer status;

    private Date createTime;

    private Date updateTime;


}
