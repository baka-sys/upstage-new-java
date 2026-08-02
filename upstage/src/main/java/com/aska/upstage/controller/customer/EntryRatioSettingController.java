package com.aska.upstage.controller.customer;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.customer.IEntryRatioSettingService;
import com.aska.repository.domain.dto.EntryRatioSettingDTO;
import com.aska.repository.domain.vo.EntryRatioSettingVO;
import com.aska.repository.entity.EntryRatioSetting;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-05-15
 */
@RestController
@RequestMapping("/entryRatioSetting")
@Api(tags = "劫持默认设置")
public class EntryRatioSettingController {

    @Autowired
    IEntryRatioSettingService service;


    @GetMapping("get")
    @ApiOperation(value = "获取劫持默认配置")
    public ResponseData selectSetting() {
        EntryRatioSetting entryRatioSettingList = service.selectSetting();
        return ResponseData.success(EntryRatioSettingDTO.convert(entryRatioSettingList));
    }


    @PostMapping("update")
    @ApiOperation(value = "修改劫持默认配置")
    public ResponseData updateSetting(@RequestBody EntryRatioSettingVO vo){
        service.updateSetting(EntryRatioSettingVO.convert(vo));
        return ResponseData.success();
    }

}
