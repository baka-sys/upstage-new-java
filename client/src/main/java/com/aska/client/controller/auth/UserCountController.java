package com.aska.client.controller.auth;

import com.aska.client.config.annotation.Login;
import com.aska.common.model.ResponseData;
import com.aska.logical.service.auth.IUserCountService;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 用户统计表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
@RestController
@RequestMapping("userCount")
public class UserCountController {


    @Autowired
    IUserCountService service;


    @GetMapping("count")
    @ApiParam(value = "获取客户统计")
    public ResponseData selectCountData(@ApiParam(hidden = true) @Login Long customerId){
        return ResponseData.success(service.selectCountData(customerId));
    }

    @GetMapping("broken")
    @ApiParam(value = "获取折线图数据")
    public ResponseData selectCountDataByCreateTime(@ApiParam(hidden = true) @Login Long customerId){
        return ResponseData.success(service.selectUserCountBroken(customerId));
    }

    @GetMapping("rate")
    @ApiParam(value = "获取饼图")
    public ResponseData selectCountByRate(@ApiParam(hidden = true) @Login Long customerId){
        return ResponseData.success(service.selectUserCountRate(customerId));
    }
}
