package com.aska.client.controller.auth;

import com.aska.client.config.annotation.Login;
import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.auth.IUserService;
import com.aska.repository.domain.dto.UserDTO;
import com.aska.repository.domain.vo.UserVO;
import com.aska.repository.entity.SpeechData;
import com.aska.repository.entity.User;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.*;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * <p>
 * 用户表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
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

    @PostMapping("add")
    @ApiOperation(value = "添加")
    public ResponseData addUser(@RequestBody @Validated(Insert.class) UserVO vo, @ApiParam(hidden = true) @Login Long accountId){
        service.add(UserVO.convert(vo),accountId);
        return ResponseData.success();
    }

    @PostMapping("switch")
    @ApiOperation(value = "切换状态")
    public ResponseData switchUserStatus(
            @ApiParam(hidden = true) @Login Long id,
            @ApiParam(name = "status",required = true,type = "int",value = "状态码")@RequestParam Integer status){
        service.switchStatus(id,status);
        return ResponseData.success();
    }

    @SneakyThrows
    @GetMapping("generate")
    @ApiOperation(value = "批量生成账号")
    public void generateUser(
            @ApiParam(name = "lines",required = true,type = "int",value = "条数") @RequestParam Integer lines,
            @ApiParam(hidden = true) @Login Long accountId,
            @ApiParam(name = "password",required = true,type = "string",value = "默认密码")@RequestParam(required = false) String password,
            @ApiParam(name = "days",required = true,type = "double",value = "到期天数")@RequestParam Double days,
            @ApiParam(name = "shellType",required = true,type = "string",value = "口子类型") @RequestParam Integer shellType,
            @ApiParam(name = "qrcodeSwitch",required = false,type = "int",value = "二维码类型") @RequestParam Integer qrcodeSwitch,
            @ApiParam(name = "testCard",required = true,type = "int",value = "是否是测试卡") @RequestParam Integer testCard,
            @ApiParam(name = "prefixString",required = false,type = "string",value = "前缀")@RequestParam(required = false) String prefixString,
            @ApiParam(name = "maxNumber",required = false,type = "int",value = "最大进人数量")@RequestParam(required = false) Integer maxNumber,
            @ApiParam(hidden = true) HttpServletResponse response){
        service.generateCardPassword(lines, accountId, password,days,testCard,prefixString,response,true,shellType,qrcodeSwitch,maxNumber,null);
    }

    @PostMapping("speech")
    @ApiOperation(value = "话术同步")
    public ResponseData setUpSynchronous(
            @ApiParam(hidden = true) @Login Long id, @RequestBody SpeechData speechData
            ){
        service.updateUserSpeech(id,speechData.getUserIds(),speechData.getIsRemove(),speechData.getFunctionIds());
        return ResponseData.success();
    }

    @GetMapping("count")
    @ApiOperation(value = "获取客服统计数据")
    public ResponseData selectUserCountByAccountId(@ApiParam(hidden = true) @Login Long id){
        return ResponseData.success(service.selectUserCountByAccountId(id));
    }

    @PostMapping("renewal")
    @ApiOperation(value = "客服充值")
    public ResponseData renewUserByDays(
            @ApiParam(hidden = true) @Login Long id,
            @ApiParam(name = "userId",required = true,type = "long",value = "客户id") @RequestParam Long userId,
            @ApiParam(name = "days",required = true,type = "double",value = "天数")@RequestParam Double days
    ){
        service.renewUserByDays(id,userId,days);
        return ResponseData.success();
    }

    @GetMapping("getUrl")
    @ApiOperation(value = "获取推广链接")
    public ResponseData getShowUrl(
            @ApiParam(name = "userId",required = true,type = "long",value = "客服id")@RequestParam Long userId
    ){
        return ResponseData.success(service.selectUrlByUserId(userId));
    }
}
