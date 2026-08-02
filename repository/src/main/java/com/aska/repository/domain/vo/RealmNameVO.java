package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.RealmName;
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
public class RealmNameVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "域名")
    private String domain;

    @ApiModelProperty(value = "0开启，关闭1")
    private Integer status;

    @ApiModelProperty(value = "开启之后才会有类型，0，无，1、普通，2、s")
    private Integer type;

    @ApiModelProperty(value = "0未删除，1删除")
    private Integer deleted;

    @ApiModelProperty(value = "删除时间")
    private Date deleteTime;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static RealmName convert(RealmNameVO vo) {
        RealmName entity = new RealmName();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<RealmName> convertList(List<RealmNameVO> list) {
        List<RealmName> resultList = new ArrayList<>();
        for (RealmNameVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
