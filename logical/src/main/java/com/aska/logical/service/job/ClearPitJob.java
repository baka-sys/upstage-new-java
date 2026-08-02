package com.aska.logical.service.job;


import com.aska.logical.service.common.IDomainService;
import lombok.extern.slf4j.Slf4j;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class ClearPitJob extends QuartzJobBean {

    @Autowired
    IDomainService service;

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        log.info("执行cron定时任务更换图片域名{}", LocalDateTime.now());
        try {
            handle();
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }

    }

    protected void handle() throws IllegalAccessException {
        // 调用清空数量占位
        service.clearPitJob();
    }
}
