package com.aska.common.model;

public enum ResultCode {
    /* 成功状态码 */
    SUCCESS(200, "成功"),
    ERROR(400,"失败"),
    /* 参数错误 */
    PARAM_IS_INVALID(1001, "参数无效"),
    PARAM_IS_BLANK(1002, "参数为空"),
    LONGIN_ERROR(1003,"请先登录"),
    LOGOUT_SUCCESS(1004,"退出成功"),
    TOKEN_EXPIRESS_ERROR(1005,"token已过期"),
    TOKEN_ERROR(1006,"token异常"),
    TOKEN_NOT_FOUND(1007,"未检测到token值"),
    ACCESS_NO_PERMISSION(1008,"访问资源无权限"),
    AUTH_ERROR(1009,"token认证失败"),
    TOKEN_IS_LOGIN_ERROR(1012,"该账号已在其他地方登录，请重新登录或者修改密码"),
    REFRESH_TOKEN_IS_EXIT(1013,"账号已过期，请重新登录"),
    DATA_IS_NOT_FOUND(1014,"该数据不存在"),
    SEND_MESSAGE_ERROR(1015,"发送信息失败"),
    CUSTOMER_IS_NOT_FOUND(1014,"客服不存在，请联系管理员"),



    /* 用户错误 2001-2999*/
    ACCOUNT_INFO_IS_FOUND(2000,"账号已存在，请重新录入"),
    USER_INFO_NOT_FOUND(2001,"账号不存在"),
    USER_INFO_NOT_PASSWORD(2002,"请输入用户密码"),
    USER_INFO_NOT_PASSWORD_ERROR(2003,"密码错误"),
    CLIENT_USER_INFO_NOT_FOUND(2004,"账号或者手机号不存在"),
    USER_FAILED_TO_ADD(2005,"添加用户信息失败"),
    USER_INFO_NOT_PASSWORD_NULL(2006,"密码不能为空"),
    USER_TWO_PASSWORD_NOT_SOME(2007,"两次密码不一致"),
    USER_OLD_PASSWORD_NOT_SAME(2008,"当前旧密码输入错误"),
    ACCOUNT_IS_STATUS(2009,"当前账户已被禁用无法登录，请联系系统管理员"),
    CUSTOMER_ACCOUNT_IS_FOUND(2010,"客服账号已存在,请重新添加"),
    USER_ACCOUNT_IS_EXPIRE(2011,"账号已过期,请续费"),
    ACCOUNT_IS_NOT_FOUND(2012,"账号不存在，请联系系统管理员"),
    CARMINE_IS_NOT_FOUND(2013,"卡密不存在，请重新输入有效卡密"),
    CARMINE_IS_EXPIRE(2014,"卡密已激活，请重新输入未续费未激活的卡密"),
    CARMINE_IS_RENEW(2015,"该卡密已续费，请重新输入未续费未激活的卡密"),
    URL_IS_REPEATED(2016,"该域名集合中存在已经绑定过的域名，请重新录入域名"),
    NGINX_CONF_UPDATE_ERROR(2017,"nginx 更新失败"),
    CARMINE_MAX_SIZE(2018,"卡密最大长度不超过50"),
    DAYS_IS_REQUIRE(2019,"必须填写开通天数"),
    POINTS_IS_ENOUGH(2020,"积分不够，请联系后台管理员充值"),
    COIN_IS_VALID(2021,"请输入大于0的两位小数"),
    DAYS_IS_MORE_THEN(2022,"测试卡时间不能大于一小时"),

    /* 黑名单错误 */
    BLACKLIST_EXIST_USER(3000, "该用户已在黑名单中，请勿重复添加"),
    URL_IS_NOT_FOUND(2024,"连接未找到,请链接系统管理员"),
    URL_IS_NOT_REPAIR(2024,"请勿重复添加相同域名"),
    URL_IS_NEW_URL(2025,"已经是最新活码，无法更换活码"),
    URL_IS_NOT_NULL(2026,"填写的域名的为空，请重新填写"),
    URL_INFO_IS_ERROR(2022,"url格式不对请重新录入"),
    ;

    private Integer code;
    private String message;

    private ResultCode(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public Integer code() {
        return this.code;
    }
    public String message() {
        return this.message;
    }
}
