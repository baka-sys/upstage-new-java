package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 客服设置表
 * </p>
 *
 * @author sy
 * @since 2025-06-07
 */
@Getter
@Setter
@TableName("cs_user_setup")
public class UserSetup implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 侧边栏开关
     */
    private Integer sideSwitch;

    /**
     * 声音开关
     */
    private Integer audioSwitch;

    /**
     * 跳转开关
     */
    private Integer jumpSwitch;

    /**
     * 进人开关
     */
    private Integer codeSwitch;

    /**
     * 聊天记录顺序
     */
    private Integer chatRecordSort;

    /**
     * 聊天资料开关
     */
    private Integer dataSwitch;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 添加开关
     */
    private Date createTime;

    /**
     * 二维码类型
     */
    private Integer qrcodeSwitch;

    /**
     * 验证码开关
     */
    private Integer verifyCodeSwitch;

    /**
     * 验证码背景图片
     */
    private String verifyCodeImage;


    /**
     * 验证码标题
     */
    private String verifyCodeTitle;


    /**
     * 计数开关
     */
    private Integer countSwitch;

    /**
     * ip限制数量
     */
    private Integer ipNumber;

    /**
     * ip国内国外过滤
     */
    private Integer domesticSwitch;

    /**
     * 秒进秒出开关
     */
    private Integer secondsSwitch;


    /**
     * 停留时间开关
     */
    private Integer stopSwitch;


    /**
     * 停留时长
     */
    private Integer stopTimeNumber;

    /**
     * 微信过滤开关
     */
    private Integer wechatSwitch;


    /**
     * 问答验证背景图片
     */
    private String verifyQuestionsImage;


    /**
     * 问答验证内容
     */
    private String verifyQuestionsContent;


    /**
     * 版本
     */
    private String version;


}
