package com.aska.upstage.controller.code;

import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.code.IRealmNameService;
import com.aska.repository.domain.dto.RealmNameDTO;
import com.aska.repository.domain.vo.RealmNameVO;
import com.aska.repository.entity.BatchDomain;
import com.aska.repository.entity.RealmName;
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
 *  前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
@RestController
@RequestMapping("realm")
public class RealmNameController {

    @Autowired
    IRealmNameService service;

    @GetMapping("page")
    @ApiOperation(value = "分页数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page",type = "int",required = true,value = "页码"),
            @ApiImplicitParam(name = "limit",type = "int",required = true,value = "条数"),
    })
    public ResponseData selectPageBy(
            @RequestParam Integer page,
            @RequestParam Integer limit
    ){
        Page<RealmName> realmNamePage = service.selectPage(page, limit);
        return ResponseData.success(RealmNameDTO.convertList(realmNamePage.getRecords()), realmNamePage.getTotal());
    }

    @PostMapping("add")
    @ApiOperation(value = "添加入口域名")
    public ResponseData BatchAdd(@RequestBody BatchDomain batchDomain){
        service.batchAdd(batchDomain);
        return ResponseData.success();
    }

    @PutMapping("update")
    @ApiOperation(value = "修改")
    public ResponseData updateRealm(@RequestBody @Validated(Update.class) RealmNameVO vo){
        service.updateRealmName(RealmNameVO.convert(vo));
        return ResponseData.success();
    }

    @PostMapping("deleteBatch")
    @ApiOperation(value = "批量删除")
    public ResponseData batchDeleteDomain(@ApiParam(name = "ids",required = true,type = "string",value = "主键集合") @RequestParam String ids){
        service.batchDelete(ids);
        return ResponseData.success();
    }

    @PostMapping("set")
    @ApiOperation(value = "设置配置项")
    public ResponseData setShellTypeAndDomain(
            @RequestParam Long id,@RequestParam Integer shellType
    ){
        service.setShellTypeAndDomain(id, shellType);
        return ResponseData.success();
    }
}
