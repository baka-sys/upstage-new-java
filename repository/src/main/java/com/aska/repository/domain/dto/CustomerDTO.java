package com.aska.repository.domain.dto;

import com.aska.repository.entity.Customer;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class CustomerDTO {

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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

    @ApiModelProperty(value = "登录时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date loginTime;

    @ApiModelProperty(value = "激活时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date activeTime;

    @ApiModelProperty(value = "卡密购买天数,可以是小数")
    private Double days;

    @ApiModelProperty(value = "到期时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
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


    public CustomerDTO() {}

    public CustomerDTO(Customer entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static CustomerDTO convert(Customer entity) {
        return new CustomerDTO(entity);
    }

    public static List<CustomerDTO> convertList(List<Customer> list) {
        List<CustomerDTO> resultList = new ArrayList<>();
        for (Customer entity : list) {
            resultList.add(new CustomerDTO(entity));
        }
        return resultList;
    }}
