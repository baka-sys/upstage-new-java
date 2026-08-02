package com.aska.repository.entity;


import lombok.Data;

@Data
public class CustomerCount {

    /**
     * 总数
     */
    private Integer total;

    /**
     * 使用中(今天登录并且未过期的卡密)
     */
    private Integer useTotal;

    /**
     * 停用
     */
    private Integer stopTotal;

    /**
     * 未激活
     */
    private Integer notActiveTotal;

    /**
     * 已充值
     */
    private Integer rechargedTotal;

    /**
     * 充值天数
     */
    private Double rechargedDays;

    /**
     * 进人总数
     */
    private Integer userLoginTotal;

    /**
     * 客服在线数量
     */
    private Integer customerOnlineTotal;
}
