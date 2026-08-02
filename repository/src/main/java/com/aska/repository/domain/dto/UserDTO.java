package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.EntryRatio;
import com.aska.repository.entity.SayHello;
import com.aska.repository.entity.User;
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
public class UserDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户名")
    private String name;

    @ApiModelProperty(value = "备注")
    private String notes;

    @ApiModelProperty(value = "头像")
    private String img;

    @ApiModelProperty(value = "用户账号")
    private String userAccount;

    @ApiModelProperty(value = "手机号码")
    private String phoneNumber;

    @ApiModelProperty(value = "今日进人总数")
    private Integer number;

    @ApiModelProperty(value = "累计进人总数")
    private Integer totalNumber;

    @ApiModelProperty(value = "账号类型，0：客户，1：客服")
    private Integer type;

    @ApiModelProperty(value = "口子类型:0,普通，1、s型")
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
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date updateTime;

    @ApiModelProperty(value = "登录时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date loginTime;

    @ApiModelProperty(value = "客服积分")
    private Double days;

    @ApiModelProperty(value = "到期时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone = "GMT+8")
    private Date expirationDate;

    @ApiModelProperty(value = "卡密状态: 0未激活，1已激活，2，已续费")
    private Integer activeState;

    @ApiModelProperty(value = "域名")
    private String url;

    @ApiModelProperty(value = "是否是测试卡密")
    private Integer testCard;

    @ApiModelProperty(value = "最大进人数量")
    private Integer maxNumber;

    @ApiModelProperty(value = "扫码次数")
    private Long scanNumber;

    @ApiModelProperty(value = "是否是劫持比例卡")
    private Integer isSearch;

    @ApiModelProperty(value = "打招呼列表")
    private List<SayHello> sayHellos;

    @ApiModelProperty(value = "劫持设置")
    private EntryRatio entryRatio;

    @ApiModelProperty(value = "用量")
    private Integer dosage;

    @ApiModelProperty(value = "今日进人总量")
    private Integer todayTotal;


    public UserDTO() {}

    public UserDTO(User entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static UserDTO convert(User entity) {
        return new UserDTO(entity);
    }

    public static List<UserDTO> convertList(List<User> list) {
        List<UserDTO> resultList = new ArrayList<>();
        for (User entity : list) {
            resultList.add(new UserDTO(entity));
        }
        return resultList;
    }}
