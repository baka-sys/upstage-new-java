package com.aska.logical.service.common.impl;

import cn.hutool.core.util.StrUtil;
import com.aska.logical.service.common.TasksService;
import com.aska.repository.entity.Tasks;
import org.quartz.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.stereotype.Service;


@Service
public class TasksServiceImpl implements TasksService {

    @Autowired
    Scheduler scheduler;

    /**
     * 添加job
     * @param tasks
     */
    @Override
    public void addSchedule(Tasks tasks) {
        try {
            JobDetail jobDetail = scheduler.getJobDetail(JobKey.jobKey(tasks.getJobName(), tasks.getJobGroupName()));
            if(jobDetail == null){
                Class className = Class.forName(tasks.getJobForName());
                QuartzJobBean jobBean = (QuartzJobBean) className.newInstance();
                jobDetail = JobBuilder.newJob(jobBean.getClass())
                        .withIdentity(tasks.getJobName(), tasks.getJobGroupName())
                        .storeDurably()
                        .build();
            }
            //什么时候开始，什么时候结束
            CronTrigger cronTrigger = TriggerBuilder.newTrigger()
                    .forJob(jobDetail.getKey().getName(),jobDetail.getKey().getGroup())
                    .withIdentity(tasks.getTriggerName(), tasks.getTriggerGroup())
                    .withSchedule(CronScheduleBuilder.cronSchedule(tasks.getCronExpression()))
                    .build();
            if(tasks.getStartTime()!=null){
                cronTrigger.getTriggerBuilder().startAt(tasks.getStartTime());
            } else {
                cronTrigger.getTriggerBuilder().startNow();
            }
            //如果参数存在，则传递参数
            if(StrUtil.isNotBlank(tasks.getParams())){
                cronTrigger.getTriggerBuilder().usingJobData("params", tasks.getParams());
            }
            if(tasks.getEndTime()!=null){
                cronTrigger.getTriggerBuilder().endAt(tasks.getEndTime());
            }
            scheduler.addJob(jobDetail,true);
            scheduler.scheduleJob(cronTrigger);
            // 运行该job
            scheduler.start();
        } catch (SchedulerException | ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        }
    }

    /**
     * 暂停任务
     * @param
     * @param jobGroup
     */
    @Override
    public void pauseJob(String jobName, String jobGroup) {
        try {
            scheduler.pauseJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 恢复任务
     * @param jobName
     * @param jobGroup
     */
    @Override
    public void resumeJob(String jobName, String jobGroup) {
        try {
            scheduler.resumeJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 暂停触发器
     * @param triggerName
     * @param triggerGroup
     */
    @Override
    public void pauseTrigger(String triggerName, String triggerGroup){
        try {
            scheduler.pauseTrigger(TriggerKey.triggerKey(triggerName, triggerGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 恢复触发器
     * @param triggerName
     * @param triggerGroup
     */
    @Override
    public void resumeTrigger(String triggerName, String triggerGroup){
        try {
            scheduler.resumeTrigger(TriggerKey.triggerKey(triggerName, triggerGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }

    /**
     * 删除触发器
     * @param triggerName
     * @param triggerGroup
     */
    @Override
    public void unscheduleJob(String triggerName, String triggerGroup){
        try {
            scheduler.unscheduleJob(TriggerKey.triggerKey(triggerName, triggerGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }


    /**
     * 删除调度器
     * @param jobName
     * @param jobGroup
     */
    @Override
    public void deleteJob(String jobName, String jobGroup) {
        try {
            scheduler.deleteJob(JobKey.jobKey(jobName, jobGroup));
        } catch (SchedulerException e) {
            e.printStackTrace();
        }
    }
}
