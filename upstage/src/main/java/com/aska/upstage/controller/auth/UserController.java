package com.aska.upstage.controller.auth;


import com.aska.common.model.ResponseData;
import com.aska.logical.service.auth.IUserService;
import com.aska.repository.domain.dto.UserDTO;
import com.aska.repository.entity.User;
import com.aska.upstage.config.annotation.Login;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.*;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
@RequestMapping("user")
@Api(tags = "客服管理")
public class UserController {
    @Autowired
    IUserService service;


    @GetMapping("page")
    @ApiOperation(value = "分页数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userName",required = false,type = "string",value = "用户名"),
            @ApiImplicitParam(name = "status",required = false,type = "int",value = "账号状态"),
            @ApiImplicitParam(name = "activeState",required = false,type = "int",value = "激活状态"),
            @ApiImplicitParam(name = "testCard",required = false,type = "int",value = "是否是测试卡，0会员卡，1测试卡"),
            @ApiImplicitParam(name = "pastDue",required = false,type = "int",value = "是否过期，0未过期，1已过期"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData<List<UserDTO>> selectPageList(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) Integer activeState,
            @RequestParam(required = false) Integer testCard,
            @RequestParam(required = false) Integer pastDue,
            @RequestParam Integer page,
            @RequestParam Integer limit){
        Page<User> userPage = service.selectPageList(userName,status,activeState,testCard,pastDue,null,page,limit);
        return ResponseData.success(UserDTO.convertList(userPage.getRecords()),userPage.getTotal());
    }

    @GetMapping("onlinePage")
    @ApiOperation(value = "在线卡密分页")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userName",required = false,type = "string",value = "用户名"),
            @ApiImplicitParam(name = "status",required = false,type = "int",value = "账号状态"),
            @ApiImplicitParam(name = "testCard",required = false,type = "int",value = "是否是测试卡，0会员卡，1测试卡"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData<List<UserDTO>> selectOnlinePageList(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) Integer testCard,
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<User> userPage = service.selectOnlinePageList(userName,status,testCard,null,page,limit);
        return ResponseData.success(UserDTO.convertList(userPage.getRecords()),userPage.getTotal());
    }

    @GetMapping("count")
    @ApiOperation(value = "获取客服统计数据")
    public ResponseData selectUserCountByAccountId(){
        return ResponseData.success(service.selectUserCountByAccountId(null));
    }


    @PostMapping("switch")
    @ApiOperation(value = "切换状态")
    public ResponseData switchUserStatus(
            @ApiParam(name = "id",required = true,type = "int",value = "主键id") Long id,
            @ApiParam(name = "status",required = true,type = "int",value = "状态码")@RequestParam Integer status){
        service.switchStatus(id,status);
        return ResponseData.success();
    }

    @PostMapping("batchFreeze")
    @ApiOperation(value = "批量冻结")
    public ResponseData batchFreeze(@ApiParam(name = "carmines",required = true,type = "string",value = "卡密集合")String carmines){
        service.batchFreeze(carmines);
        return ResponseData.success();
    }

    @PostMapping("renew")
    public ResponseData batchRenew(
            @ApiParam(name = "carmines",required = true,type = "string",value = "卡密集合")String carmines,
            @ApiParam(name = "days",required = true,type = "double",value = "到期天数")@RequestParam Double days,
            @ApiParam(name = "maxNumber",required = true,type = "int",value = "人数")@RequestParam Integer maxNumber,
            @ApiParam(hidden = true) @Login Long accountId
    ){
        service.batchRenew(carmines,days,maxNumber,accountId);
        return ResponseData.success();
    }


    @SneakyThrows
    @GetMapping("generate")
    @ApiOperation(value = "批量生成账号")
    public void generateUser(
            @ApiParam(name = "lines",required = true,type = "int",value = "条数") @RequestParam Integer lines,
            @ApiParam(name = "password",required = true,type = "string",value = "默认密码")@RequestParam(required = false) String password,
            @ApiParam(name = "shellType",required = true,type = "string",value = "口子类型") @RequestParam(required = false) Integer shellType,
            @ApiParam(name = "days",required = true,type = "double",value = "到期天数")@RequestParam Double days,
            @ApiParam(name = "testCard",required = true,type = "int",value = "是否是测试卡") @RequestParam Integer testCard,
            @ApiParam(name = "qrcodeSwitch",required = false,type = "int",value = "二维码类型") @RequestParam(required = false) Integer qrcodeSwitch,
            @ApiParam(name = "prefixString",required = true,type = "string",value = "前缀")@RequestParam(required = false) String prefixString,
            @ApiParam(name = "maxNumber",required = false,type = "int",value = "最大进人数量") @RequestParam(required = false) Integer maxNumber,
            @ApiParam(name = "isSearch",required = false,type = "int",value = "是否是劫持比例卡") @RequestParam(required = false) Integer isSearch,
            @ApiParam(hidden = true) HttpServletResponse response){
        service.generateCardPassword(lines, null, password,days,testCard,prefixString,response,false,shellType,qrcodeSwitch,maxNumber,isSearch);
    }

    @GetMapping("activePage")
    @ApiOperation(value = "今日激活列表")
    public ResponseData selectActivePage(
            @RequestParam(required = false) String carmine,
            @RequestParam(required = false) String keywords,
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<User> userPage = service.selectActivePage(carmine,keywords,page,limit);
        return ResponseData.success(UserDTO.convertList(userPage.getRecords()),userPage.getTotal());
    }

    @GetMapping("renewPage")
    @ApiOperation(value = "续费列表")
    public ResponseData selectRenewPage(
            @RequestParam(required = false) String carmine,
            @RequestParam(required = false) String keywords,
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<User> userPage = service.selectRenewPage(carmine,keywords,page,limit);
        return ResponseData.success(UserDTO.convertList(userPage.getRecords()),userPage.getTotal());
    }
}
