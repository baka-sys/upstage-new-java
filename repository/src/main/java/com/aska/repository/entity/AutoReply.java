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
 * 自动回复
 * </p>
 *
 * @author sy
 * @since 2026-06-13
 */
@Getter
@Setter
@TableName("cs_auto_reply")
public class AutoReply implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 0 客服，1企业
     */
    private Integer accountType;

    private Long userId;

    /**
     * 关键词
     */
    private String keywords;

    /**
     * 回复类型:1：文字，2：图片,3、定位，4：智能问答、5、音频，6、视频
     */
    private Integer type;

    /**
     * 内容
     */
    private String content;

    /**
     * 状态:0：开启,1：关闭
     */
    private Integer status;

    /**
     * 排序
     */
    private Integer sort;

    private Date createTime;

    private Date updateTime;


}
