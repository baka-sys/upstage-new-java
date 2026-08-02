package com.aska.upstage.controller.configuration;

import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.repository.domain.dto.OperationAutoDTO;
import com.aska.repository.domain.vo.OperationAutoVO;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;

@RestController
@RequestMapping("config")
@Api(tags = "系统配置")
public class OperationAutoController {

    @Autowired
    IOperationAutoService service;

    @PostMapping("add")
    @ApiOperation("新增")
    public ResponseData addAuto(@RequestBody @Validated(Insert.class) OperationAutoVO vo){
        return ResponseData.success(service.addAuto(OperationAutoVO.convert(vo)));
    }

    @PostMapping("update")
    @ApiOperation("更新")
    public ResponseData updateAuto(@RequestBody @Validated(Update.class) OperationAutoVO vo ){
        service.updateAuto(OperationAutoVO.convert(vo));
        return ResponseData.success();
    }

    @PostMapping("delete")
    @ApiOperation("删除")
    public ResponseData deleteAuto( @RequestParam
                                    @ApiParam(name = "id",value = "id",required = true, type = "int") Integer id){
        service.deleteAuto(id);
        return ResponseData.success();
    }

    @GetMapping("one")
    @ApiOperation("根据参数编码对应参数")
    public ResponseData autoListByCode(
            @ApiParam(name = "systemCode",required = true,type = "string",value = "参数编码")
            @RequestParam String systemCode
    ){
        return ResponseData.success(service.selectDetailBySystemCode(systemCode));
    }


    @GetMapping("getJson")
    @ApiOperation("获取form表单数据")
    public ResponseData getJson(
            @ApiParam(name = "codeType",required = true,type = "int",value = "参数类别")
            @RequestParam Integer codeType,
            @ApiParam(hidden = true) HttpServletRequest request
    ){
        return ResponseData.success(service.selectDetailByCode(codeType,request));
    }


    @PostMapping("editOne")
    @ApiOperation("修改系统配置保存配置")
    public ResponseData updateOne(@RequestBody HashMap<String,String> hashMap){
        service.updateOne(hashMap);
        return ResponseData.success();
    }

    @GetMapping("list")
    @ApiOperation(value = "获取所有配置项")
    public ResponseData selectAllSystem(){
        return ResponseData.success(OperationAutoDTO.convertList(service.selectAllSystem()));
    }


    @GetMapping("field")
    @ApiOperation(value = "获取单条配置想")
    public ResponseData selectRedisValue(
            @ApiParam(name = "field",required = true,type = "string",value = "code") @RequestParam String field
    ){
        return ResponseData.success(service.selectRedisValueByFiled(field));
    }

    @GetMapping("clear")
    @ApiOperation(value = "清除缓存数据")
    public ResponseData clearRedisConfig(){
        service.cleanRedisConfig();
        return  ResponseData.success();
    }

    @GetMapping("getImageUrl")
    @ApiOperation(value = "获取图片域名")
    public ResponseData getImageUrl(){
        return ResponseData.success(service.selectRedisValueByFiled("image_url"));
    }
}
