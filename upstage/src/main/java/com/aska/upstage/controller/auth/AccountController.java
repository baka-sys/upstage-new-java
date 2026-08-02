package com.aska.upstage.controller.auth;


import com.aska.common.model.ResponseData;
import com.aska.logical.service.auth.IAccountService;
import com.aska.repository.domain.dto.AccountDTO;
import com.aska.repository.entity.Account;
import com.aska.upstage.config.annotation.Login;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("account")
@Api(tags = "企业账号")
public class AccountController {

    @Autowired
    IAccountService service;


    @GetMapping("page")
    @ApiOperation(value = "分页")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "accountName",required = true,type = "string",value = "账号名称"),
            @ApiImplicitParam(name = "status",required = true,type = "int",value = "账号状态"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData selectPageBy(
            @RequestParam(required = false) String accountName,
            @RequestParam(required = false) Integer status,
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<Account> pageResult = service.selectPageBy(accountName,status,page,limit);
        return ResponseData.success(AccountDTO.convertList(pageResult.getRecords()), pageResult.getTotal());
    }

    @PostMapping("switch")
    @ApiOperation(value = "切换状态")
    public ResponseData switchUserStatus(
            @ApiParam(hidden = true) @Login Long id,
            @ApiParam(name = "status",required = true,type = "int",value = "状态码")@RequestParam Integer status){
        service.switchStatus(id,status);
        return ResponseData.success();
    }

    @PostMapping("recharge")
    @ApiOperation(value = "企业账户充值")
    public ResponseData rechargeAccount(Long accountId,Double coin){
        service.recharge(accountId, coin);
        return ResponseData.success();
    }

    @GetMapping("list")
    @ApiOperation(value = "管理账户列表")
    public ResponseData selectAccountList(){
        return ResponseData.success(service.selectList());
    }
}
