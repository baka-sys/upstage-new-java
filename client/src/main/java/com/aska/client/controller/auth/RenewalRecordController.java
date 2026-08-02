package com.aska.client.controller.auth;

import com.aska.logical.service.auth.IRenewalRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 续费记录 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
@RestController
@RequestMapping("renewalRecord")
public class RenewalRecordController {

    @Autowired
    IRenewalRecordService service;
}
