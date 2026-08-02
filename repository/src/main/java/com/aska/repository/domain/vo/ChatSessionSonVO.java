package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.ChatSessionSon;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class ChatSessionSonVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "主表id")
    private Long sessionId;

    @ApiModelProperty(value = "发送时间")
    private Long sendTime;

    @ApiModelProperty(value = "发送内容")
    private String content;

    @ApiModelProperty(value = "发送格式")
    private Integer type;

    @ApiModelProperty(value = "未读数量")
    private Integer unread;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static ChatSessionSon convert(ChatSessionSonVO vo) {
        ChatSessionSon entity = new ChatSessionSon();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<ChatSessionSon> convertList(List<ChatSessionSonVO> list) {
        List<ChatSessionSon> resultList = new ArrayList<>();
        for (ChatSessionSonVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
