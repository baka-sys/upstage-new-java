package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.EntryRatio;
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
public class EntryRatioVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "主卡")
    private Long mainUserId;

    @ApiModelProperty(value = "主卡密")
    private String mainCarmine;

    @ApiModelProperty(value = "副卡")
    private Long subUserId;

    @ApiModelProperty(value = "副卡密")
    private String subCarmine;

    @ApiModelProperty(value = "主卡比例数量")
    private Integer mainRadioNumber;

    @ApiModelProperty(value = "副卡比例数量")
    private Integer subRadioNumber;

    @ApiModelProperty(value = "主卡进人数量")
    private Integer mainNumber;

    @ApiModelProperty(value = "副卡进入数量")
    private Integer subNumber;

    @ApiModelProperty(value = "开关：0开，1关")
    private Integer switchCode;

    @ApiModelProperty(value = "主要进人数量")
    private Integer mainNumberTotal;

    @ApiModelProperty(value = "设置数量")
    private Integer systemTotalNumber;

    @ApiModelProperty(value = "头寸进人总数")
    private Integer mainNumberTotalTwo;

    @ApiModelProperty(value = "头寸数量")
    private Integer systemTotalNumberTwo;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    @ApiModelProperty(value = "副卡2Id")
    private Long subUserIdTwo;

    @ApiModelProperty(value = "副卡2")
    private String subCarmineTwo;

    @ApiModelProperty(value = "主卡比例数量")
    private Integer mainRadioNumberTwo;


    @ApiModelProperty(value = "副卡2比例数量")
    private Integer subRadioNumberTwo;


    @ApiModelProperty(value = "主卡进人数量")
    private Integer mainNumberTwo;


    @ApiModelProperty(value = "副卡2进入数量")
    private Integer subNumberTwo;

    @ApiModelProperty(value = "副卡开关2")
    private Integer switchCodeTwo;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static EntryRatio convert(EntryRatioVO vo) {
        EntryRatio entity = new EntryRatio();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<EntryRatio> convertList(List<EntryRatioVO> list) {
        List<EntryRatio> resultList = new ArrayList<>();
        for (EntryRatioVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
