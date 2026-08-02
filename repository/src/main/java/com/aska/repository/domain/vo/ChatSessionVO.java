package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.ChatSession;
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
public class ChatSessionVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static ChatSession convert(ChatSessionVO vo) {
        ChatSession entity = new ChatSession();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<ChatSession> convertList(List<ChatSessionVO> list) {
        List<ChatSession> resultList = new ArrayList<>();
        for (ChatSessionVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
