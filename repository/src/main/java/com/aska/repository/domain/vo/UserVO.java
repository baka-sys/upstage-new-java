package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.User;
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
public class UserVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户名")
    private String name;

    @ApiModelProperty(value = "备注")
    private String notes;

    @ApiModelProperty(value = "头像")
    private String img;

    @ApiModelProperty(value = "密码")
    private String password;

    @ApiModelProperty(value = "用户账号")
    private String userAccount;

    @ApiModelProperty(value = "手机号码")
    private String phoneNumber;

    @ApiModelProperty(value = "账号类型，0：客户，1：客服")
    private Integer type;

    @ApiModelProperty(value = "口子类型：0：普通、1、s型")
    private Integer shellType;

    @ApiModelProperty(value = "账号状态，0：启用，1：禁用")
    private Integer status;

    @ApiModelProperty(value = "ip地址")
    private String ipAddress;

    @ApiModelProperty(value = "管理员账号id")
    private Long accountId;

    @ApiModelProperty(value = "设备码")
    private String equipmentCode;

    @ApiModelProperty(value = "ip地址所属地区")
    private String ipDistrict;

    @ApiModelProperty(value = "浏览器名称")
    private String browserName;

    @ApiModelProperty(value = "平台")
    private String platform;

    @ApiModelProperty(value = "用户唯一编码")
    private String userKey;

    @ApiModelProperty(value = "卡密")
    private String carmine;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "登录时间")
    private Date loginTime;

    @ApiModelProperty(value = "到期时间")
    private Date expirationDate;

    @ApiModelProperty(value = "卡密开通天数")
    @NotNull
    private Double days;

    @ApiModelProperty(value = "卡密状态: 0未激活，1已激活，2，已续费")
    private Integer activeState;

    @ApiModelProperty(value = "是否是测试卡密")
    private Integer testCard;

    @ApiModelProperty(value = "最大进人数量")
    private Integer maxNumber;

    @ApiModelProperty(value = "扫码次数")
    private Long scanNumber;

    @ApiModelProperty(value = "是否是劫持比例卡")
    private Integer isSearch;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static User convert(UserVO vo) {
        User entity = new User();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<User> convertList(List<UserVO> list) {
        List<User> resultList = new ArrayList<>();
        for (UserVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
