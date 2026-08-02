package com.aska.client.controller.auth;

import com.aska.client.config.annotation.Login;
import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.logical.service.auth.IAccountService;
import com.aska.repository.domain.dto.AccountDTO;
import com.aska.repository.domain.dto.LoginInfoDTO;
import com.aska.repository.domain.vo.AccountVO;
import com.aska.repository.entity.Account;
import com.aska.repository.entity.LoginInfo;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 管理员总表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
@RestController
@RequestMapping("account")
@Api(tags = "管理员登录管理")
public class AccountController {

    @Autowired
    IAccountService service;

    @PostMapping("login")
    @ApiOperation(value = "登录账号")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account",required = true,type = "string",value = "账号"),
            @ApiImplicitParam(name = "password",required = true,type = "string",value = "密码")
    })
    public ResponseData<LoginInfoDTO> login(@RequestParam String account, @RequestParam String password) {
        LoginInfo loginInfo = service.login(account, password);
        return ResponseData.success(LoginInfoDTO.convert(loginInfo));
    }

    @PostMapping("register")
    @ApiOperation(value = "注册账号")
    public ResponseData register(@RequestBody @Validated(Insert.class) AccountVO vo) {
        service.register(AccountVO.convert(vo));
        return ResponseData.success();
    }

    @PostMapping("verifyUnique")
    @ApiOperation(value = "验证账号唯一")
    public ResponseData verifyUnique(@RequestBody @Validated(Insert.class) AccountVO vo) {
        service.verifyAccount(AccountVO.convert(vo));
        return ResponseData.success();
    }

    @GetMapping("info")
    @ApiOperation(value = "获取用户信息")
    public ResponseData getAccountInfo(@ApiParam(hidden = true) @Login Long id) {
        Account account = service.getAccountInfo(id);
        return ResponseData.success(AccountDTO.convert(account));
    }

    @PostMapping("updateAuth")
    @ApiOperation(value = "修改密码")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "ordPassword",required = true,type = "string",value = "旧密码"),
            @ApiImplicitParam(name = "newPassword",required = true,type = "string",value = "新密码"),
            @ApiImplicitParam(name = "confirmPassword",required = true,type = "string",value = "确认密码"),
    })
    public ResponseData updatePassword(@ApiParam(hidden = true) @Login Long id,
                                          @RequestParam String ordPassword,
                                          @RequestParam String newPassword,
                                          @RequestParam String confirmPassword) {
        service.updateAccountPassword(id, ordPassword, newPassword, confirmPassword);
        return ResponseData.success();
    }

    @PostMapping("update")
    @ApiOperation(value = "修改用户信息")
    public ResponseData updateInfo(@RequestBody AccountVO vo){
        service.updateAccountInfo(AccountVO.convert(vo));
        return ResponseData.success();
    }

}
