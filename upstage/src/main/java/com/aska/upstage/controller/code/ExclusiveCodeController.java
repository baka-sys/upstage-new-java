package com.aska.upstage.controller.code;

import com.aska.logical.service.code.IExclusiveCodeService;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 专属域名 前端控制器
 * </p>
 *
 * @author sy
 * @since 2026-03-15
 */
@RestController
@RequestMapping("exclusiveCode")
@Api(tags = "专属域名")
public class ExclusiveCodeController {

    @Autowired
    IExclusiveCodeService service;

}
