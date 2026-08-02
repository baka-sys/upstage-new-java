package com.aska.upstage.controller.auth;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.auth.IAdminService;
import com.aska.repository.entity.LoginInfo;
import com.aska.repository.entity.LoginRequestInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 总后台账号表 前端控制器
 * </p>
 *
 * @author
 * @since 2025-03-28
 */
@RestController
@RequestMapping("admin")
@Api(tags = "总后台登录")
public class AdminController {

    @Autowired
    IAdminService service;


    @PostMapping("login")
    @ApiOperation(value = "后台登录")
    public ResponseData login(@RequestBody LoginRequestInfo loginRequestInfo) {
        return ResponseData.success(service.login(loginRequestInfo.getUsername(), loginRequestInfo.getPassword()));
    }

}
