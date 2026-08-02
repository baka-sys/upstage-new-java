package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.LiveCodeNumber;
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
public class LiveCodeNumberVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    private Long liveCodeId;

    private Integer number;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static LiveCodeNumber convert(LiveCodeNumberVO vo) {
        LiveCodeNumber entity = new LiveCodeNumber();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<LiveCodeNumber> convertList(List<LiveCodeNumberVO> list) {
        List<LiveCodeNumber> resultList = new ArrayList<>();
        for (LiveCodeNumberVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
