package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.OperationAuto;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author sy
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class OperationAutoDTO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "id")
    private Integer id;

    @ApiModelProperty(value = "参数类型")
    private Integer codeType;

    @ApiModelProperty(value = "参数编码")
    private String title;

    @ApiModelProperty(value = "字段名")
    private String field;

    @ApiModelProperty(value = "状态：0启用1禁用")
    private Integer status;

    @ApiModelProperty(value = "文本类型：1输入框2单选3多选4上传")
    private Integer type;

    @ApiModelProperty(value = "值")
    private String value;

    @ApiModelProperty(value = "默认值")
    private String defValue;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "更新时间")
    private Date updateTime;


    public OperationAutoDTO() {}

    public OperationAutoDTO(OperationAuto entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static OperationAutoDTO convert(OperationAuto entity) {
        return new OperationAutoDTO(entity);
    }

    public static List<OperationAutoDTO> convertList(List<OperationAuto> list) {
        List<OperationAutoDTO> resultList = new ArrayList<>();
        for (OperationAuto entity : list) {
            resultList.add(new OperationAutoDTO(entity));
        }
        return resultList;
    }}
