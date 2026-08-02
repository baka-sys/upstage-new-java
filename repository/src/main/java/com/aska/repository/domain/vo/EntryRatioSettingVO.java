package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.EntryRatioCarmine;
import com.aska.repository.entity.EntryRatioSetting;
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
public class EntryRatioSettingVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static EntryRatioSetting convert(EntryRatioSettingVO vo) {
        EntryRatioSetting entity = new EntryRatioSetting();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<EntryRatioSetting> convertList(List<EntryRatioSettingVO> list) {
        List<EntryRatioSetting> resultList = new ArrayList<>();
        for (EntryRatioSettingVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
