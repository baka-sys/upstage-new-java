package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.AccountPointsRecord;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class AccountPointsRecordDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "管理账号id")
    private Long accountId;

    @ApiModelProperty(value = "类型:1、充值，2、消费")
    private Integer type;

    @ApiModelProperty(value = "积分")
    private Double points;

    @ApiModelProperty(value = "操作前积分")
    private Double beforeOperation;

    @ApiModelProperty(value = "操作后积分")
    private Double afterOperation;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;


    public AccountPointsRecordDTO() {}

    public AccountPointsRecordDTO(AccountPointsRecord entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static AccountPointsRecordDTO convert(AccountPointsRecord entity) {
        return new AccountPointsRecordDTO(entity);
    }

    public static List<AccountPointsRecordDTO> convertList(List<AccountPointsRecord> list) {
        List<AccountPointsRecordDTO> resultList = new ArrayList<>();
        for (AccountPointsRecord entity : list) {
            resultList.add(new AccountPointsRecordDTO(entity));
        }
        return resultList;
    }}
