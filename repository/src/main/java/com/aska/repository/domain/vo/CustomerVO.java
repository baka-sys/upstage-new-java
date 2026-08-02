package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.Customer;
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
public class CustomerVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户名")
    private String name;

    @ApiModelProperty(value = "头像")
    private String img;

    @ApiModelProperty(value = "密码")
    private String password;

    @ApiModelProperty(value = "用户账号")
    private String userAccount;

    @ApiModelProperty(value = "手机号码")
    private String phoneNumber;

    @ApiModelProperty(value = "账号状态，0：启用，1：禁用")
    private Integer status;

    @ApiModelProperty(value = "企业账号id")
    private Long accountId;

    @ApiModelProperty(value = "卡密")
    private String carmine;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "登录时间")
    private Date loginTime;

    @ApiModelProperty(value = "激活时间")
    private Date activeTime;

    @ApiModelProperty(value = "卡密购买天数,可以是小数")
    private Double days;

    @ApiModelProperty(value = "到期时间")
    private Date expirationDate;

    @ApiModelProperty(value = "激活状态：0，未激活，1、已激活、2、已续费，3、已过期")
    private Integer activeState;

    @ApiModelProperty(value = "测试卡：0不是，1是")
    private Integer testCard;

    @ApiModelProperty(value = "最大进人数量")
    private Integer maxNumber;

    @ApiModelProperty(value = "1:普通卡，2：劫持卡")
    private Integer isSearch;

    @ApiModelProperty(value = "渠道备注")
    private String channelRemark;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Customer convert(CustomerVO vo) {
        Customer entity = new Customer();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Customer> convertList(List<CustomerVO> list) {
        List<Customer> resultList = new ArrayList<>();
        for (CustomerVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
