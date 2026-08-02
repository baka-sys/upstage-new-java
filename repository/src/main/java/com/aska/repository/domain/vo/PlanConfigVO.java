package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.PlanConfig;
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
public class PlanConfigVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "方案标题")
    private String title;

    @ApiModelProperty(value = "背景图片")
    private String img;

    @ApiModelProperty(value = "内容")
    private String content;

    @ApiModelProperty(value = "状态")
    private Integer status;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static PlanConfig convert(PlanConfigVO vo) {
        PlanConfig entity = new PlanConfig();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<PlanConfig> convertList(List<PlanConfigVO> list) {
        List<PlanConfig> resultList = new ArrayList<>();
        for (PlanConfigVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
