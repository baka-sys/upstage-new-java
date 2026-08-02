package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.ExclusiveCode;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import com.aska.common.util.BeanUtils;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class ExclusiveCodeVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "专属域名id")
    private Long liveCodeId;

    @ApiModelProperty(value = "专属地址")
    private String exclusiveUrl;

    @ApiModelProperty(value = "0:使用中，1：关闭")
    private Integer status;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static ExclusiveCode convert(ExclusiveCodeVO vo) {
        ExclusiveCode entity = new ExclusiveCode();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<ExclusiveCode> convertList(List<ExclusiveCodeVO> list) {
        List<ExclusiveCode> resultList = new ArrayList<>();
        for (ExclusiveCodeVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
