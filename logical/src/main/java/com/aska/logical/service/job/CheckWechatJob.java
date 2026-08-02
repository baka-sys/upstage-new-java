package com.aska.logical.service.job;

import com.aska.logical.service.code.ILiveCodeService;
import lombok.extern.slf4j.Slf4j;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.LocalTime;

@Service
@Slf4j
public class CheckWechatJob extends QuartzJobBean {

    @Autowired
    ILiveCodeService liveCodeService;

    @Override
    protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
        log.info("执行cron定时任务检测域名{}", LocalDateTime.now());
        try {
            handle();
        } catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
    }

    private void handle() throws IllegalAccessException {

        LocalTime currentTime = LocalTime.now();

        // 定义开始时间和结束时间
        LocalTime startTime = LocalTime.of(0, 0, 0); // 00:00:00
        LocalTime endTime = LocalTime.of(8, 30, 0); // 08:30:00

        // 检查当前时间是否在指定范围内
        if (currentTime.isBefore(endTime) && !currentTime.isBefore(startTime)) {
            log.info("当前时间在指定范围内，不执行操作。");
        } else {
            log.info("当前时间不在指定范围内，执行操作。");
            // 在这里添加你需要执行的代码
            liveCodeService.getWechatCode();
        }

    }
}
