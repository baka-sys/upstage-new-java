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
 * 
 * </p>
 *
 * @author sy
 * @since 2026-06-13
 */
@Getter
@Setter
@TableName("cs_asked_questions_son")
public class AskedQuestionsSon implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 账号类型:0 客服账号，1、企业账号
     */
    private Integer accountType;

    private Long mainId;

    private String questionName;

    private Integer answerType;

    private String answerContent;

    private Integer sort;

    private String status;

    private Date createTime;

    private Date updateTime;


}
