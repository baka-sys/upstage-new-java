package com.aska.client.controller.configuration;


import com.aska.common.model.ResponseData;
import com.aska.logical.service.configuration.IOperationAutoService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("config")
@Api(tags = "配置")
public class ConfigurationController {

    @Autowired
    IOperationAutoService service;

    @GetMapping("field")
    @ApiOperation(value = "获取单条配置想")
    public ResponseData selectRedisValue(
            @ApiParam(name = "field",required = true,type = "string",value = "code") @RequestParam String field
    ){
        return ResponseData.success(service.selectRedisValueByFiled(field));
    }
}
