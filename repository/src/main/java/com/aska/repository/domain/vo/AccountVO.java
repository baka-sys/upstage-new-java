package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.Account;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import com.aska.common.util.BeanUtils;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class AccountVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账户名称")
    private String accountName;

    @ApiModelProperty(value = "头像")
    private String img;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "密码")
    private String password;

    @ApiModelProperty(value = "确认密码")
    private String confirmPassword;

    @ApiModelProperty(value = "手机号码")
    private Long phoneNumber;

    @ApiModelProperty(value = "登录唯一key")
    private String accountKey;

    @ApiModelProperty(value = "账号状态：0:启用状态，1：禁用状态")
    private Integer status;

    @ApiModelProperty(value = "积分")
    private Double points;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "登录时间")
    private Date loginTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Account convert(AccountVO vo) {
        Account entity = new Account();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Account> convertList(List<AccountVO> list) {
        List<Account> resultList = new ArrayList<>();
        for (AccountVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
