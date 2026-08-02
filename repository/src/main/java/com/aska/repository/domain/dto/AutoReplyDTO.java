package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.AutoReply;
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
public class AutoReplyDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "0客服，1企业")
    private Integer accountType;

    private Long userId;

    @ApiModelProperty(value = "关键词")
    private String keywords;

    @ApiModelProperty(value = "回复类型:1：文字，2：图片,3、定位，4：智能问答、5、音频，6、视频")
    private Integer type;

    @ApiModelProperty(value = "内容")
    private String content;

    @ApiModelProperty(value = "状态:0：开启,1：关闭")
    private Integer status;

    @ApiModelProperty(value = "排序")
    private Integer sort;

    private Date createTime;

    private Date updateTime;


    public AutoReplyDTO() {}

    public AutoReplyDTO(AutoReply entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static AutoReplyDTO convert(AutoReply entity) {
        return new AutoReplyDTO(entity);
    }

    public static List<AutoReplyDTO> convertList(List<AutoReply> list) {
        List<AutoReplyDTO> resultList = new ArrayList<>();
        for (AutoReply entity : list) {
            resultList.add(new AutoReplyDTO(entity));
        }
        return resultList;
    }}
