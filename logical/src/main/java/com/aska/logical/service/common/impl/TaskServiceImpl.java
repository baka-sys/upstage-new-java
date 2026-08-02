package com.aska.logical.service.common.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.logical.service.common.TasksService;
import com.aska.repository.entity.Task;
import com.aska.repository.entity.Tasks;
import com.aska.repository.mapper.TaskMapper;
import com.aska.logical.service.common.ITaskService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-07-07
 */
@Service
public class TaskServiceImpl extends ServiceImpl<TaskMapper, Task> implements ITaskService {

    @Autowired
    TaskMapper mapper;

    @Autowired
    TasksService tasksService;

    final static String JOB_NAME = "SYSTEM_JOB_NAME";
    final static String JOB_GROUP_NAME = "SYSTEM_JOB_GROUP_NAME";
    final static String TRIGGER_NAME = "SYSTEM_TRIGGER_NAME";
    final static String TRIGGER_GROUP_NAME = "SYSTEM_TRIGGER_GROUP_NAME";
    final static String JOB_FOR_NAME_PREFIX = "com.aska.logical.service.job.";

    @Override
    public List<Task> selectList(){
        return mapper.selectList(null);
    }

    @Override
    public void addTask(Task task){
        Task task1 = mapper.selectOne(new LambdaQueryWrapper<Task>().eq(Task::getTitle, task.getTitle()));
        if(task1 != null){
            throw new CustomException(ResultCode.ERROR.code(),"任务名称已存在");
        }
        task.setCreateTime(DateUtil.date());
        mapper.insert(task);
    }


    @Override
    public void updateTask(Task task){
        Task task1 = mapper.selectById(task.getId());
        if(task1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        task.setUpdateTime(DateUtil.date());
        mapper.updateById(task);
    }


    @Override
    public void deleteTask(Task task){
        Task task1 = mapper.selectById(task.getId());
        if(task1 == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        mapper.deleteById(task.getId());
        tasksService.deleteJob(JOB_NAME + task.getId(),JOB_GROUP_NAME + task.getId());
        tasksService.unscheduleJob(TRIGGER_NAME + task.getId(),TRIGGER_GROUP_NAME + task.getId());
    }

    /**
     * 开始任务
     * @param taskId
     */
    @Override
    public void startTask(Long taskId){
        Task task = mapper.selectById(taskId);
        if(task == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        Tasks tasks1 = Tasks.builder()
                .jobName(JOB_NAME + task.getId())
                .jobGroupName(JOB_GROUP_NAME + task.getId())
                .triggerName(TRIGGER_NAME + task.getId())
                .triggerGroup(TRIGGER_GROUP_NAME + task.getId())
                .cronExpression(task.getCron())
                .jobForName(JOB_FOR_NAME_PREFIX + task.getHandler())
                .build();
        tasksService.addSchedule(tasks1);
        task.setState(1);
        task.setUpdateTime(DateUtil.date());
        mapper.updateById(task);
    }

    /**
     * 暂停任务
     * @param taskId
     */
    @Override
    public void pauseTask(Long taskId){
        Task task = mapper.selectById(taskId);
        if(task == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        tasksService.pauseJob(JOB_NAME + taskId,JOB_GROUP_NAME + taskId);
        tasksService.pauseTrigger(TRIGGER_NAME + taskId,TRIGGER_GROUP_NAME + taskId);
        task.setState(2);
        task.setUpdateTime(DateUtil.date());
        mapper.updateById(task);
    }

    @Override
    public void pauseTask(){
        pauseTask(2L);
    }

    /**
     * 重启任务
     * @param taskId
     */
    @Override
    public void resumeTask(Long taskId){
        Task task = mapper.selectById(taskId);
        if(task == null){
            throw new CustomException(ResultCode.DATA_IS_NOT_FOUND);
        }
        tasksService.resumeJob(JOB_NAME + taskId,JOB_GROUP_NAME + taskId);
        tasksService.resumeTrigger(TRIGGER_NAME + taskId,TRIGGER_GROUP_NAME + taskId);
        task.setState(1);
        task.setUpdateTime(DateUtil.date());
        mapper.updateById(task);
    }

}
