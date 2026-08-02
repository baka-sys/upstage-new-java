package com.aska.repository.domain.dto;

import com.aska.repository.entity.LiveCodeNumber;
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
public class LiveCodeNumberDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long liveCodeId;

    private Integer number;

    private Date updateTime;


    public LiveCodeNumberDTO() {}

    public LiveCodeNumberDTO(LiveCodeNumber entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static LiveCodeNumberDTO convert(LiveCodeNumber entity) {
        return new LiveCodeNumberDTO(entity);
    }

    public static List<LiveCodeNumberDTO> convertList(List<LiveCodeNumber> list) {
        List<LiveCodeNumberDTO> resultList = new ArrayList<>();
        for (LiveCodeNumber entity : list) {
            resultList.add(new LiveCodeNumberDTO(entity));
        }
        return resultList;
    }}
