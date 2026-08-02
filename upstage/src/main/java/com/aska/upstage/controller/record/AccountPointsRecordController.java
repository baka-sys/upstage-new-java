package com.aska.upstage.controller.record;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.record.IAccountPointsRecordService;
import com.aska.repository.domain.dto.AccountPointsRecordDTO;
import com.aska.repository.entity.AccountPointsRecord;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * <p>
 * 积分消费记录 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-03-27
 */
@RestController
@RequestMapping("record")
@Api(tags = "积分充值记录")
public class AccountPointsRecordController {

    @Autowired
    IAccountPointsRecordService service;


    @GetMapping("page")
    @ApiOperation(value = "积分变动记录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "type",required = false,type = "int",value = "积分类型"),
            @ApiImplicitParam(name = "accountId",required = false,type = "long",value = "管理账号id"),
            @ApiImplicitParam(name = "startTime",required = false,type = "string",value = "开始时间"),
            @ApiImplicitParam(name = "endTime",required = false,type = "string",value = "结束时间"),
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "页码"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数")
    })
    public ResponseData<List<AccountPointsRecordDTO>> selectPage(
            @RequestParam(required = false) Integer type,
            @RequestParam(required = false) Long accountId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            @RequestParam Integer page,
            @RequestParam Integer limit){

        Page<AccountPointsRecord> result = service.selectPageBy(type, accountId, startTime, endTime, page, limit);

        return ResponseData.success(AccountPointsRecordDTO.convertList(result.getRecords()), result.getTotal());
    }

}
