package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Mass;
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
public class MassVO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "快捷回复自增id")
    private Long id;

    @ApiModelProperty(value = "客服id")
    private Long userId;

    @ApiModelProperty(value = "快捷回复的内容")
    private String content;

    @ApiModelProperty(value = "类型：0：文字，1：图片")
    private Integer type;

    @ApiModelProperty(value = "类型：0：客服，1：管理账号")
    private Integer accountType;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Mass convert(MassVO vo) {
        Mass entity = new Mass();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Mass> convertList(List<MassVO> list) {
        List<Mass> resultList = new ArrayList<>();
        for (MassVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
