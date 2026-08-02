package com.aska.logical.service.common;


import com.aska.repository.entity.Tasks;

public interface TasksService {

    void addSchedule(Tasks tasks);

    /**
     * 暂停任务
     * @param jobName
     * @param jobGroup
     */
    void pauseJob(String jobName, String jobGroup);

    /**
     * 暂停触发器
     * @param jobName
     * @param jobGroup
     */
    void pauseTrigger(String jobName, String jobGroup);

    /**
     * 删除触发器
     * @param jobName
     * @param jobGroup
     */
    void deleteJob(String jobName, String jobGroup);

    /**
     * 重启定时任务
     * @param jobName
     * @param jobGroup
     */
    void resumeJob(String jobName, String jobGroup);

    void resumeTrigger(String triggerName, String triggerGroup);

    /**
     * 删除触发器
     * @param triggerName
     * @param triggerGroup
     */
    void unscheduleJob(String triggerName, String triggerGroup);
}
