package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.CustomerSetup;
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
public class CustomerSetupVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "用户id")
    private Long userId;

    @ApiModelProperty(value = "声音开关:0开启，1关闭")
    private Integer audioSwitch;

    @ApiModelProperty(value = "侧边栏：0开启，1关闭")
    private Integer sideSwitch;

    @ApiModelProperty(value = "跳转开关0开启，1关闭")
    private Integer jumpSwitch;

    @ApiModelProperty(value = "聊天资料开关：0,开启，1,关闭")
    private Integer dataSwitch;

    @ApiModelProperty(value = "聊天记录显示顺序：0、从下往上，1从上往下")
    private Integer chatRecordSort;

    @ApiModelProperty(value = "二维码类型：0，全网码，1：浏览器码，2:微信码,3:qq码，4：抖音码，5，微博码")
    private Integer qrcodeSwitch;

    @ApiModelProperty(value = "进人开关0开启，1关闭")
    private Integer codeSwitch;

    @ApiModelProperty(value = "验证码开关:0,开启，1关闭")
    private Integer verifyCodeSwitch;

    @ApiModelProperty(value = "验证码背景图片")
    private String verifyCodeImage;

    @ApiModelProperty(value = "验证码标题")
    private String verifyCodeTitle;

    @ApiModelProperty(value = "问答验证内容")
    private String verifyQuestionsContent;

    @ApiModelProperty(value = "问答验证背景图片")
    private String verifyQuestionsImage;

    @ApiModelProperty(value = "计算方式：0、关闭，1、ip过滤")
    private Integer countSwitch;

    @ApiModelProperty(value = "ip计数过滤数量")
    private Integer ipNumber;

    @ApiModelProperty(value = "国外过滤：0开启，1关闭")
    private Integer domesticSwitch;

    @ApiModelProperty(value = "秒进秒出：0开启，1关闭")
    private Integer secondsSwitch;

    @ApiModelProperty(value = "停留时间开关:0开启，1关闭")
    private Integer stopSwitch;

    @ApiModelProperty(value = "停留时间")
    private Integer stopTimeNumber;

    @ApiModelProperty(value = "非微信过滤：0开启，1关闭")
    private Integer wechatSwitch;

    @ApiModelProperty(value = "模拟器过滤：0开启，1关闭")
    private Integer phoneModelSwitch;

    @ApiModelProperty(value = "代理过滤：0开启，1关闭")
    private Integer isProxySwitch;

    @ApiModelProperty(value = "表单字段设置,多选id")
    private String formSettings;

    @ApiModelProperty(value = "版本")
    private String version;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;

    @ApiModelProperty(value = "添加时间")
    private Date createTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static CustomerSetup convert(CustomerSetupVO vo) {
        CustomerSetup entity = new CustomerSetup();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<CustomerSetup> convertList(List<CustomerSetupVO> list) {
        List<CustomerSetup> resultList = new ArrayList<>();
        for (CustomerSetupVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
