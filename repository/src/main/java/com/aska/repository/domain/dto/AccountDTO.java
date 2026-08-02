package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Account;
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
public class AccountDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账户名称")
    private String accountName;

    @ApiModelProperty(value = "头像")
    private String img;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "手机号码")
    private Long phoneNumber;

    @ApiModelProperty(value = "登录唯一key")
    private String accountKey;

    @ApiModelProperty(value = "账号状态：0:启用状态，1：禁用状态")
    private Integer status;

    @ApiModelProperty(value = "积分")
    private Double points;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

    @ApiModelProperty(value = "登录时间")
    private Date loginTime;


    public AccountDTO() {}

    public AccountDTO(Account entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static AccountDTO convert(Account entity) {
        return new AccountDTO(entity);
    }

    public static List<AccountDTO> convertList(List<Account> list) {
        List<AccountDTO> resultList = new ArrayList<>();
        for (Account entity : list) {
            resultList.add(new AccountDTO(entity));
        }
        return resultList;
    }}
