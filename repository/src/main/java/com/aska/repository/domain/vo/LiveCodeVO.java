package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.LiveCode;
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
public class LiveCodeVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "口子类型：0，公共域名，1、专属域名，2、短域名")
    private Integer type;

    @ApiModelProperty(value = "口子类型：0，普通类型，1、S类型")
    private Integer shellType;

    @ApiModelProperty(value = "平台类型")
    private Integer platformType;

    @ApiModelProperty(value = "口子域名")
    private String domainName;

    @ApiModelProperty(value = "排序字段")
    private Integer sort;

    @ApiModelProperty(value = "绑定数量")
    private Integer number;

    @ApiModelProperty(value = "访问数量")
    private Integer requestNumber;

    @ApiModelProperty(value = "口子状态:0、正常，1、异常（可根据专业检测拉取是否正常）")
    private Integer status;

    @ApiModelProperty(value = "0、未删除，1已删除")
    private Integer deleted;

    @ApiModelProperty(value = "删除时间")
    private Date deleteTime;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "是否是直连域名")
    private Integer direct;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static LiveCode convert(LiveCodeVO vo) {
        LiveCode entity = new LiveCode();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<LiveCode> convertList(List<LiveCodeVO> list) {
        List<LiveCode> resultList = new ArrayList<>();
        for (LiveCodeVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
