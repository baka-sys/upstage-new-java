package com.aska.logical.service.job;

import com.aska.logical.service.auth.IUserService;
import lombok.extern.slf4j.Slf4j;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class CardExpiredJob extends QuartzJobBean {

    @Autowired
    IUserService userService;

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        log.info("执行cron定时任务账户过期{}", LocalDateTime.now());
        try {
            handle();
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
    }

    private void handle() throws IllegalAccessException {
        userService.cardExpired();
    }
}
