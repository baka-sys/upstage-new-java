package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.AccountPointsRecord;
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
public class AccountPointsRecordVO {

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
    private Date createTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static AccountPointsRecord convert(AccountPointsRecordVO vo) {
        AccountPointsRecord entity = new AccountPointsRecord();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<AccountPointsRecord> convertList(List<AccountPointsRecordVO> list) {
        List<AccountPointsRecord> resultList = new ArrayList<>();
        for (AccountPointsRecordVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
