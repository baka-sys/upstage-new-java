package com.aska.logical.service.common;

import com.aska.repository.entity.Task;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sy
 * @since 2025-07-07
 */
public interface ITaskService extends IService<Task> {

    List<Task> selectList();

    void addTask(Task task);

    void updateTask(Task task);

    void deleteTask(Task task);

    void startTask(Long taskId);

    void pauseTask(Long taskId);

    void pauseTask();

    void resumeTask(Long taskId);
}
