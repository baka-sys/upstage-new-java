package com.aska.upstage.controller.configuration;

import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.configuration.IPlanConfigService;
import com.aska.repository.domain.dto.PlanConfigDTO;
import com.aska.repository.domain.vo.PlanConfigVO;
import com.aska.repository.entity.PlanConfig;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * 方案设置 前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-05-17
 */
@RestController
@RequestMapping("planConfig")
@Api(tags = "问答方案设置")
public class PlanConfigController {

    @Autowired
    IPlanConfigService service;

    @GetMapping("page")
    @ApiOperation(value = "分页")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData selectPageList(@RequestParam Integer page,@RequestParam Integer limit){
        Page<PlanConfig> result = service.selectPageBy(page,limit);

        return ResponseData.success(PlanConfigDTO.convertList(result.getRecords()),result.getTotal());
    }

    @PostMapping("add")
    @ApiOperation(value = "添加")
    public ResponseData addConfig(@RequestBody @Validated(Insert.class) PlanConfigVO vo){
        service.add(PlanConfigVO.convert(vo));
        return ResponseData.success();
    }

    @PostMapping("update")
    @ApiOperation(value = "修改")
    public ResponseData updateConfig(@RequestBody @Validated(Update.class) PlanConfigVO vo){
        service.updateConfig(PlanConfigVO.convert(vo));
        return ResponseData.success();
    }

    @PostMapping("delete")
    @ApiOperation(value = "删除")
    public ResponseData deleteConfig(@RequestParam Long id){
        service.deleteConfig(id);
        return ResponseData.success();
    }


    @PostMapping("status")
    @ApiOperation(value = "切换状态")
    public ResponseData switchStatus(@RequestParam Long id,@RequestParam Integer status){
        service.switchStatus(id,status);
        return ResponseData.success();
    }


}
