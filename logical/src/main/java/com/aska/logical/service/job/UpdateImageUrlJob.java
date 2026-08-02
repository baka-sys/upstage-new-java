package com.aska.logical.service.job;


import com.aska.logical.service.configuration.ISystemDomainService;
import lombok.extern.slf4j.Slf4j;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class UpdateImageUrlJob extends QuartzJobBean {

    @Autowired
    ISystemDomainService service;

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        log.info("执行cron定时任务更换图片域名{}", LocalDateTime.now());
        try {
            handle();
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
    }

    private void handle() throws IllegalAccessException {
        log.info("更换图片域名{}", LocalDateTime.now());
        service.updateMainUrlJobForImage();
    }
}
