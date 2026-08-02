package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Domain;
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
public class DomainVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "活码id")
    private Long liveCodeId;

    @ApiModelProperty(value = "客服")
    private Long userId;

    @ApiModelProperty(value = "0：公共域名,1：专属域名")
    private Integer type;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Domain convert(DomainVO vo) {
        Domain entity = new Domain();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Domain> convertList(List<DomainVO> list) {
        List<Domain> resultList = new ArrayList<>();
        for (DomainVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
