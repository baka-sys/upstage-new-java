package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.TelegramChat;
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
public class TelegramChatVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long chatId;

    private Date createTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static TelegramChat convert(TelegramChatVO vo) {
        TelegramChat entity = new TelegramChat();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<TelegramChat> convertList(List<TelegramChatVO> list) {
        List<TelegramChat> resultList = new ArrayList<>();
        for (TelegramChatVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
