package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.QuickReply;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class QuickReplyDTO {

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

    @ApiModelProperty(value = "客服名称")
    private String customerServiceName;


    public QuickReplyDTO() {}

    public QuickReplyDTO(QuickReply entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static QuickReplyDTO convert(QuickReply entity) {
        return new QuickReplyDTO(entity);
    }

    public static List<QuickReplyDTO> convertList(List<QuickReply> list) {
        List<QuickReplyDTO> resultList = new ArrayList<>();
        for (QuickReply entity : list) {
            resultList.add(new QuickReplyDTO(entity));
        }
        return resultList;
    }}
