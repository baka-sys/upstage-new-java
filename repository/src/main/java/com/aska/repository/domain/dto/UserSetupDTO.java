package com.aska.repository.domain.dto;

import com.aska.repository.entity.UserSetup;
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
public class UserSetupDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "声音开关:0开启，1关闭")
    private Integer audioSwitch;

    @ApiModelProperty(value = "跳转开关0开启，1关闭")
    private Integer jumpSwitch;

    @ApiModelProperty(value = "聊天资料开关：0,开启，1,关闭")
    private Integer dataSwitch;

    @ApiModelProperty(value = "聊天记录顺序")
    private Integer chatRecordSort;

    @ApiModelProperty(value = "二维码类型：0，全网码，1：浏览器码，2:微信码")
    private Integer qrcodeSwitch;

    @ApiModelProperty(value = "进人开关0开启，1关闭")
    private Integer codeSwitch;

    @ApiModelProperty(value = "验证码开关:0,开启，1关闭")
    private Integer verifyCodeSwitch;

    @ApiModelProperty(value = "验证码背景图片")
    private String verifyCodeImage;

    @ApiModelProperty(value = "验证码标题")
    private String verifyCodeTitle;

    @ApiModelProperty(value = "计算方式：0、设备过滤，1、ip过滤")
    private Integer countSwitch;

    @ApiModelProperty(value = "ip计数过滤数量")
    private Integer ipNumber;

    @ApiModelProperty(value = "国外过滤：0开启，1关闭")
    private Integer domesticSwitch;

    @ApiModelProperty(value = "秒进秒出：0开启，1关闭")
    private Integer secondsSwitch;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "添加开关")
    private Date createTime;


    public UserSetupDTO() {}

    public UserSetupDTO(UserSetup entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static UserSetupDTO convert(UserSetup entity) {
        return new UserSetupDTO(entity);
    }

    public static List<UserSetupDTO> convertList(List<UserSetup> list) {
        List<UserSetupDTO> resultList = new ArrayList<>();
        for (UserSetup entity : list) {
            resultList.add(new UserSetupDTO(entity));
        }
        return resultList;
    }}
