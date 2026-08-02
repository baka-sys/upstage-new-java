package com.aska.repository.domain.dto;

import com.aska.repository.entity.EntryRatioCarmine;
import com.aska.repository.entity.EntryRatioSetting;
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
public class EntryRatioSettingDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "普通卡主卡比例")
    private Integer mainNumberTwo;

    @ApiModelProperty(value = "普通卡副卡2比例")
    private Integer subNumberTwo;

    @ApiModelProperty(value = "劫持卡主卡比例")
    private Integer hijackMainNumberTwo;

    @ApiModelProperty(value = "劫持卡副卡2比例")
    private Integer hijackSubNumberTwo;

    @ApiModelProperty(value = "排除卡密")
    private String excludeCard;

    @ApiModelProperty(value = "队列延迟时间")
    private Integer delayTime;

    @ApiModelProperty(value = "劫持卡默认数量")
    private Integer hackTotalNumber;

    @ApiModelProperty(value = "普通卡默认数量")
    private Integer totalNumber;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "劫持卡密列表")
    private List<EntryRatioCarmine> carmines;


    public EntryRatioSettingDTO() {}

    public EntryRatioSettingDTO(EntryRatioSetting entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static EntryRatioSettingDTO convert(EntryRatioSetting entity) {
        return new EntryRatioSettingDTO(entity);
    }

    public static List<EntryRatioSettingDTO> convertList(List<EntryRatioSetting> list) {
        List<EntryRatioSettingDTO> resultList = new ArrayList<>();
        for (EntryRatioSetting entity : list) {
            resultList.add(new EntryRatioSettingDTO(entity));
        }
        return resultList;
    }}
