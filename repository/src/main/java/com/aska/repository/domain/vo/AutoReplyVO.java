package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.AutoReply;
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
public class AutoReplyVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static AutoReply convert(AutoReplyVO vo) {
        AutoReply entity = new AutoReply();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<AutoReply> convertList(List<AutoReplyVO> list) {
        List<AutoReply> resultList = new ArrayList<>();
        for (AutoReplyVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
