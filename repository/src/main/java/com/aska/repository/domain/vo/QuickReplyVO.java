package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.QuickReply;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class QuickReplyVO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "快捷回复自增id")
    private Long id;

    @ApiModelProperty(value = "客服id")
    private Long userId;

    @ApiModelProperty(value = "快捷回复的内容")
    private String content;

    @ApiModelProperty(value = "回复类型")
    private Integer type;

    @ApiModelProperty(value = "账号类型，0客服，1管理账号")
    private String accountType;

    @ApiModelProperty(value = "排序字段")
    private Integer sort;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static QuickReply convert(QuickReplyVO vo) {
        QuickReply entity = new QuickReply();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<QuickReply> convertList(List<QuickReplyVO> list) {
        List<QuickReply> resultList = new ArrayList<>();
        for (QuickReplyVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
