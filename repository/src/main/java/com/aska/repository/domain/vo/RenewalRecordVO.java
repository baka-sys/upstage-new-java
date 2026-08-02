package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.RenewalRecord;
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
public class RenewalRecordVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "续费账号id")
    private Long userId;

    @ApiModelProperty(value = "续费类型：0，卡密续费，1、积分续费")
    private Integer type;

    @ApiModelProperty(value = "续费的管理id")
    private Long accountId;

    @ApiModelProperty(value = "续费的卡密号")
    private String carmine;

    @ApiModelProperty(value = "续费天数")
    private Double days;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "账号续费时的过期时间")
    private Date expirationDate;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static RenewalRecord convert(RenewalRecordVO vo) {
        RenewalRecord entity = new RenewalRecord();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<RenewalRecord> convertList(List<RenewalRecordVO> list) {
        List<RenewalRecord> resultList = new ArrayList<>();
        for (RenewalRecordVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
