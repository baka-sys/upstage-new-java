package com.aska.upstage.controller.common;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.common.IDomainService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
@RestController
@RequestMapping("domain")
@Api(tags = "二维码管理")
public class DomainController {

    @Autowired
    IDomainService domainService;

    @GetMapping("clear")
    @ApiOperation(value = "清空绑定数量")
    public ResponseData clear(){

        domainService.clearPitJob();

        return ResponseData.success();
    }
}
