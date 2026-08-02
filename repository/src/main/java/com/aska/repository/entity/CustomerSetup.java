package com.aska.repository.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 客服设置表
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
@Getter
@Setter
@TableName("cs_customer_setup")
public class CustomerSetup implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 用户id
     */
    private Long userId;

    /**
     * 声音开关:0开启，1关闭
     */
    private Integer audioSwitch;

    /**
     * 侧边栏：0开启，1关闭
     */
    private Integer sideSwitch;

    /**
     * 跳转开关0开启，1关闭
     */
    private Integer jumpSwitch;

    /**
     * 聊天资料开关：0,开启，1,关闭
     */
    private Integer dataSwitch;

    /**
     * 聊天记录显示顺序：0、从下往上，1从上往下
     */
    private Integer chatRecordSort;

    /**
     * 二维码类型：0，全网码，1：浏览器码，2:微信码,3:qq码，4：抖音码，5，微博码
     */
    private Integer qrcodeSwitch;

    /**
     * 进人开关0开启，1关闭
     */
    private Integer codeSwitch;

    /**
     * 验证码开关:0,开启，1关闭
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
     * 问答验证内容
     */
    private String verifyQuestionsContent;

    /**
     * 问答验证背景图片
     */
    private String verifyQuestionsImage;

    /**
     * 计算方式：0、关闭，1、ip过滤
     */
    private Integer countSwitch;

    /**
     * ip计数过滤数量
     */
    private Integer ipNumber;

    /**
     * 国外过滤：0 开启，1关闭
     */
    private Integer domesticSwitch;

    /**
     * 秒进秒出：0 开启，1关闭
     */
    private Integer secondsSwitch;

    /**
     * 停留时间开关:0 开启，1关闭
     */
    private Integer stopSwitch;

    /**
     * 停留时间
     */
    private Integer stopTimeNumber;

    /**
     * 非微信过滤：0开启，1关闭
     */
    private Integer wechatSwitch;

    /**
     * 模拟器过滤：0开启，1关闭
     */
    private Integer phoneModelSwitch;

    /**
     * 代理过滤：0开启，1关闭
     */
    private Integer isProxySwitch;

    /**
     * 表单字段设置,多选id
     */
    private String formSettings;

    /**
     * 版本
     */
    private String version;

    /**
     * 修改时间
     */
    private Date updateTime;

    /**
     * 添加时间
     */
    private Date createTime;


}
