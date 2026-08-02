package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.EntryRatioCarmine;
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
public class EntryRatioCarmineDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "劫持卡密")
    private String carmine;

    @ApiModelProperty(value = "主表cs_settintid")
    private Long mainId;

    @ApiModelProperty(value = "劫持卡密id")
    private Long userId;

    @ApiModelProperty(value = "绑定数量")
    private Integer number;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public EntryRatioCarmineDTO() {}

    public EntryRatioCarmineDTO(EntryRatioCarmine entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static EntryRatioCarmineDTO convert(EntryRatioCarmine entity) {
        return new EntryRatioCarmineDTO(entity);
    }

    public static List<EntryRatioCarmineDTO> convertList(List<EntryRatioCarmine> list) {
        List<EntryRatioCarmineDTO> resultList = new ArrayList<>();
        for (EntryRatioCarmine entity : list) {
            resultList.add(new EntryRatioCarmineDTO(entity));
        }
        return resultList;
    }}
