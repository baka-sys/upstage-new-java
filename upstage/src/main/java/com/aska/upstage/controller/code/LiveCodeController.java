package com.aska.upstage.controller.code;

import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.auth.IUserService;
import com.aska.logical.service.code.ILiveCodeService;
import com.aska.repository.domain.dto.LiveCodeDTO;
import com.aska.repository.domain.vo.LiveCodeVO;
import com.aska.repository.entity.BatchDomain;
import com.aska.repository.entity.CheckData;
import com.aska.repository.entity.LiveCode;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 商户域名表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-07-17
 */
@RestController
@RequestMapping("code")
public class LiveCodeController {

    @Autowired
    ILiveCodeService service;

    @Autowired
    IUserService userService;

    @GetMapping("page")
    @ApiOperation(value = "分页")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "domainName",required = false,type = "string",value = "域名"),
            @ApiImplicitParam(name = "type",required = true,type = "int",value = "域名"),
            @ApiImplicitParam(name = "platformType",required = false,type = "int",value = "平台类型"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数"),
    })
    public ResponseData getDomainPage(
            @RequestParam Integer type,
            @RequestParam(required = false) String domainName,
            @RequestParam(required = false) Integer platformType,
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<LiveCode> domainPage = service.getDomainPage(domainName,type,platformType, page, limit);
        return ResponseData.success(LiveCodeDTO.convertList(domainPage.getRecords()), domainPage.getTotal());
    }

    @PostMapping("addBatch")
    @ApiOperation(value = "商户域名批量添加")
    public ResponseData addBatchDomain(@RequestBody BatchDomain batchDomain){
        service.addBatchDomain(batchDomain);
        return ResponseData.success();
    }

    @PostMapping("top")
    @ApiOperation(value = "上移")
    public ResponseData sortTop(@ApiParam(name = "id", value = "自增id", required = true, type = "long") @RequestParam Long id){
        service.sortTop(id);
        return ResponseData.success();
    }

    @PostMapping("bottom")
    @ApiOperation(value = "下移")
    public ResponseData sortBottom(@ApiParam(name = "id", value = "自增id", required = true, type = "long") @RequestParam Long id){
        service.sortBottom(id);
        return ResponseData.success();
    }


    @PutMapping("update")
    @ApiOperation(value = "商户域名更新")
    public ResponseData updateDomain(@RequestBody @Validated(Update.class) LiveCodeVO vo){
        service.updateDomain(LiveCodeVO.convert(vo));
        return ResponseData.success();
    }

    @PutMapping("status")
    @ApiOperation(value = "切换状态")
    public ResponseData updateStatus(@RequestBody @Validated(Update.class) LiveCodeVO vo){
        service.updateStatus(vo.getId());
        return ResponseData.success();
    }

    @PostMapping("delete")
    @ApiOperation(value = "删除")
    public ResponseData deleteDomain(@ApiParam(name = "id",required = true,type = "long",value = "主键id")@RequestParam Long id){
        service.delete(id);
        return ResponseData.success();
    }

    @PostMapping("deleteBatch")
    @ApiOperation(value = "批量删除")
    public ResponseData batchDeleteDomain(@ApiParam(name = "ids",required = true,type = "string",value = "主键集合") @RequestParam String ids){
        service.batchDelete(ids);
        return ResponseData.success();
    }

    @PostMapping("deleteSet")
    @ApiOperation(value = "批量重置")
    public ResponseData batchResetDomain(
            @ApiParam(name = "ids",required = true,type = "string",value = "主键集合") @RequestParam String ids,
            @ApiParam(name = "type",required = true,type = "int",value = "活码类型") @RequestParam Integer type
    ){
        service.batchReset(ids,type);
        return ResponseData.success();
    }

    @GetMapping("codeCount")
    @ApiOperation(value = "获取活码统计")
    public ResponseData selectCodeCount(){
        return ResponseData.success(service.selectCodeCount());
    }

    @GetMapping("getUrl")
    @ApiOperation(value = "获取入口域名")
    public ResponseData getUrl(){
        return ResponseData.success(service.responseDomainUrl());
    }


    @GetMapping("export")
    @ApiOperation(value = "到处正在使用中的活吗链接")
    public void  exportExcel(HttpServletResponse response){

        service.exportExcelByLiveCode(response);
    }


    @GetMapping("checkUrl")
    @ApiOperation(value = "检查微信连接")
    public ResponseData checkUrl(){
//        service.getWechatCode();
        userService.clearRecord();
        return ResponseData.success();
    }


    @PostMapping("getData")
    @ApiOperation(value = "检查微信连接")
    public ResponseData getData(@RequestBody CheckData checkData){
        System.out.println(checkData.getUrl());
        Map<String,Object> detection = new HashMap<>();
        detection.put("is_blocked",true);
        Map<String,Object> map = new HashMap<>();
        map.put("status","success");
        map.put("detection",detection);
        return ResponseData.success(map);
    }

}
