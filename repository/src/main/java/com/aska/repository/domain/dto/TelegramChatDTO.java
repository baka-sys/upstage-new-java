package com.aska.repository.domain.dto;

import com.aska.repository.entity.TelegramChat;
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
public class TelegramChatDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long chatId;

    private Date createTime;


    public TelegramChatDTO() {}

    public TelegramChatDTO(TelegramChat entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static TelegramChatDTO convert(TelegramChat entity) {
        return new TelegramChatDTO(entity);
    }

    public static List<TelegramChatDTO> convertList(List<TelegramChat> list) {
        List<TelegramChatDTO> resultList = new ArrayList<>();
        for (TelegramChat entity : list) {
            resultList.add(new TelegramChatDTO(entity));
        }
        return resultList;
    }}
