package com.aska.upstage.controller.configuration;

import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.configuration.ISystemDomainService;
import com.aska.repository.domain.dto.SystemDomainDTO;
import com.aska.repository.domain.vo.SystemDomainVO;
import com.aska.repository.entity.BatchDomainUrl;
import com.aska.repository.entity.SystemDomain;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 系统域名配置 前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-02-25
 */
@RestController
@RequestMapping("systemDomain")
public class SystemDomainController {

    @Autowired
    ISystemDomainService service;

    @GetMapping("page")
    @ApiOperation(value = "配置域名分页")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type",type = "int",value = "域名类型"),
            @ApiImplicitParam(name = "status",type = "int",value = "使用状态"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData selectPage(
            @RequestParam(required = false) Integer type,
            @RequestParam(required = false) Integer status,
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<SystemDomain> systemDomainPage = service.getPageByLimit(type,status,page, limit);

        return ResponseData.success(SystemDomainDTO.convertList(systemDomainPage.getRecords()), systemDomainPage.getTotal());
    }


    @PostMapping("add")
    @ApiOperation(value = "添加域名")
    public ResponseData addDomain(@RequestBody @Validated(Insert.class) SystemDomainVO vo){

        service.addDomain(SystemDomainVO.convert(vo));

        return ResponseData.success();
    }

    @PostMapping("batchAdd")
    @ApiOperation(value = "批量添加域名")
    public ResponseData addDomainBatch(@RequestBody BatchDomainUrl batchDomainUrl){

        service.addBatchDomain(batchDomainUrl);
        return ResponseData.success();
    }

    @PostMapping("update")
    @ApiOperation(value = "修改单条域名")
    public ResponseData updateDomain(@RequestBody @Validated(Update.class) SystemDomainVO vo){
        service.updateDomain(SystemDomainVO.convert(vo));
        return ResponseData.success();
    }


    @PostMapping("status")
    @ApiOperation(value = "使用域名")
    public ResponseData useDomain(@RequestParam @ApiParam(name = "id",required = true,type = "long",value = "id") Long id){
        service.updateStatus(id);
        return ResponseData.success();
    }


    @PostMapping("delete")
    @ApiOperation(value = "删除域名")
    public ResponseData deleteMain(@RequestParam @ApiParam(name = "id",required = true,type = "long",value = "id") Long id){
        service.deleteDomain(id);
        return ResponseData.success();
    }

    @GetMapping("mainJob")
    @ApiOperation(value = "更新入口域名")
    public ResponseData updateMainDomainJob(){
        service.updateMainUrlJob();
        return ResponseData.success();
    }

    @GetMapping("imageJob")
    @ApiOperation(value = "更新最新的图片域名")
    public ResponseData updateImageDomainJob(){
       service.updateMainUrlJobForImage();
       return ResponseData.success();
    }

}
