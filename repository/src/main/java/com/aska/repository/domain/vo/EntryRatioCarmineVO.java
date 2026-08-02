package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.EntryRatioCarmine;
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
public class EntryRatioCarmineVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static EntryRatioCarmine convert(EntryRatioCarmineVO vo) {
        EntryRatioCarmine entity = new EntryRatioCarmine();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<EntryRatioCarmine> convertList(List<EntryRatioCarmineVO> list) {
        List<EntryRatioCarmine> resultList = new ArrayList<>();
        for (EntryRatioCarmineVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
