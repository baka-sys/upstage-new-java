package com.aska.upstage.controller.customer;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.customer.ICustomerService;
import com.aska.repository.domain.dto.CustomerDTO;
import com.aska.repository.domain.dto.UserDTO;
import com.aska.repository.entity.BatchRenewRequest;
import com.aska.repository.entity.Customer;
import com.aska.repository.entity.CustomerGenerateRequest;
import com.aska.repository.entity.User;
import com.aska.upstage.config.annotation.Login;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.*;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * <p>
 * 用户表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
@RestController
@RequestMapping("customer")
@Api(tags = "卡密管理")
public class CustomerController {

    @Autowired
    ICustomerService service;

    @GetMapping("page")
    @ApiOperation(value = "分页数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "userName",required = false,type = "string",value = "用户名"),
            @ApiImplicitParam(name = "status",required = false,type = "int",value = "账号状态"),
            @ApiImplicitParam(name = "activeState",required = false,type = "int",value = "激活状态"),
            @ApiImplicitParam(name = "testCard",required = false,type = "int",value = "是否是测试卡，0会员卡，1测试卡"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData<List<CustomerDTO>> selectPageList(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) Integer status,
            @RequestParam(required = false) Integer activeState,
            @RequestParam(required = false) Integer testCard,
            @RequestParam Integer page,
            @RequestParam Integer limit){
        Page<Customer> customerPage = service.selectPageList(userName,status,activeState,testCard,null,page,limit);
        return ResponseData.success(CustomerDTO.convertList(customerPage.getRecords()),customerPage.getTotal());
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
    @ApiOperation(value = "批量续费")
    public ResponseData batchRenew(
            @RequestBody BatchRenewRequest batchRenewRequest,
            @ApiParam(hidden = true) @Login Long accountId
    ){
        service.batchRenew(batchRenewRequest.getCarmines(),batchRenewRequest.getDays(),batchRenewRequest.getMaxNumber(),accountId);
        return ResponseData.success();
    }

    @SneakyThrows
    @PostMapping("generate")
    @ApiOperation(value = "批量生成账号")
    public void generateUser(@RequestBody CustomerGenerateRequest generateRequest, @ApiParam(hidden = true) HttpServletResponse response){
        service.generateCardPassword(
                generateRequest.getLines(), null,
                generateRequest.getPassword(),
                generateRequest.getDays(),
                generateRequest.getTestCard(),
                generateRequest.getPrefixString(),
                response,false,
                generateRequest.getQrcodeSwitch(),
                generateRequest.getMaxNumber(),
                generateRequest.getIsSearch());
    }


}
