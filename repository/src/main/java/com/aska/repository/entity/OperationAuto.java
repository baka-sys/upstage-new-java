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
 * @since 2025-03-26
 */
@Getter
@Setter
@TableName("cs_operation_auto")
public class OperationAuto implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 参数类型
     */
    private Integer codeType;

    /**
     * 参数编码
     */
    private String title;

    /**
     * 字段名
     */
    private String field;

    /**
     * 状态：0启用 1禁用
     */
    private Integer status;

    /**
     * 文本类型：1输入框 2单选 3多选 4上传
     */
    private Integer type;

    /**
     * 值
     */
    private String value;

    /**
     * 默认值
     */
    private String defValue;

    /**
     * 创建时间
     */
    private Date createTime;

    /**
     * 更新时间
     */
    private Date updateTime;


}
