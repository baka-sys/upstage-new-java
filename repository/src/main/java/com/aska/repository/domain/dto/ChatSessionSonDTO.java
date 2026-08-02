package com.aska.repository.domain.dto;

import com.aska.repository.entity.ChatSessionSon;
import lombok.Data;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.aska.common.util.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;


/**
 * @author sy
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ChatSessionSonDTO {

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


    public ChatSessionSonDTO() {}

    public ChatSessionSonDTO(ChatSessionSon entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static ChatSessionSonDTO convert(ChatSessionSon entity) {
        return new ChatSessionSonDTO(entity);
    }

    public static List<ChatSessionSonDTO> convertList(List<ChatSessionSon> list) {
        List<ChatSessionSonDTO> resultList = new ArrayList<>();
        for (ChatSessionSon entity : list) {
            resultList.add(new ChatSessionSonDTO(entity));
        }
        return resultList;
    }}
