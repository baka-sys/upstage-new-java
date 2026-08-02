package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.ChatSession;
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
public class ChatSessionDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "主id")
    private Long fromId;

    @ApiModelProperty(value = "到id")
    private Long toId;

    @ApiModelProperty(value = "置顶：0不置顶,1置顶")
    private Integer settingTop;

    @ApiModelProperty(value = "会话类型:0：单聊，1群聊")
    private Integer type;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Long updateTime;


    public ChatSessionDTO() {}

    public ChatSessionDTO(ChatSession entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static ChatSessionDTO convert(ChatSession entity) {
        return new ChatSessionDTO(entity);
    }

    public static List<ChatSessionDTO> convertList(List<ChatSession> list) {
        List<ChatSessionDTO> resultList = new ArrayList<>();
        for (ChatSession entity : list) {
            resultList.add(new ChatSessionDTO(entity));
        }
        return resultList;
    }}
