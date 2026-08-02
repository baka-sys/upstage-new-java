package com.aska.repository.domain.dto;

import com.aska.repository.entity.RenewalRecord;
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
public class RenewalRecordDTO {

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


    public RenewalRecordDTO() {}

    public RenewalRecordDTO(RenewalRecord entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static RenewalRecordDTO convert(RenewalRecord entity) {
        return new RenewalRecordDTO(entity);
    }

    public static List<RenewalRecordDTO> convertList(List<RenewalRecord> list) {
        List<RenewalRecordDTO> resultList = new ArrayList<>();
        for (RenewalRecord entity : list) {
            resultList.add(new RenewalRecordDTO(entity));
        }
        return resultList;
    }}
