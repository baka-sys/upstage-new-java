package com.aska.upstage.controller.customer;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.customer.IEntryRatioService;
import com.aska.repository.domain.vo.EntryRatioVO;
import com.aska.repository.entity.BatchEntryRatio;
import com.aska.repository.entity.BatchUpdateEntry;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 劫持比例表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-01-06
 */
@RestController
@RequestMapping("entryRatio")
public class EntryRatioController {

    @Autowired
    IEntryRatioService service;



    @PostMapping("add")
    @ApiOperation(value = "添加")
    public ResponseData addEntryRatio(@RequestBody EntryRatioVO vo) {
        service.addEntryRatio(EntryRatioVO.convert(vo));
        return ResponseData.success();
    }


    @PostMapping("update")
    @ApiOperation(value = "修改")
    public ResponseData updateEntryRatio(@RequestBody EntryRatioVO vo) {
        service.updateEntryRatio(EntryRatioVO.convert(vo));
        return ResponseData.success();
    }


    @PostMapping("stopOrStart")
    @ApiOperation(value = "开启或者暂停所有")
    public ResponseData stopEntryRatioAll(
            @ApiParam(name = "switchCode",required = true,type = "int",value = "状态码")
            @RequestParam Integer switchCode
    ){
        service.stopOrStartEntryRatioAll(switchCode);
        return ResponseData.success();
    }


    @PostMapping("batchUpdateAll")
    @ApiOperation(value = "全部修改配置（区分类别）")
    public ResponseData batchUpdateEntryRatioAll(@RequestBody BatchUpdateEntry batchUpdateEntry){
        service.batchUpdateEntryRatioAll(batchUpdateEntry);
        return ResponseData.success();
    }

    @PostMapping("synchronizationConfiguration")
    @ApiOperation(value = "同步配置（区分类别）")
    public ResponseData synchronizationConfiguration(){
        service.synchronizationConfiguration();
        return ResponseData.success();
    }




}
