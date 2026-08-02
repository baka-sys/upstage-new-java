package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.OperationAuto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class OperationAutoVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static OperationAuto convert(OperationAutoVO vo) {
        OperationAuto entity = new OperationAuto();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<OperationAuto> convertList(List<OperationAutoVO> list) {
        List<OperationAuto> resultList = new ArrayList<>();
        for (OperationAutoVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
