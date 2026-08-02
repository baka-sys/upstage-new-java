package com.aska.upstage.controller.common;

import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.auth.IUserService;
import com.aska.logical.service.code.ILiveCodeService;
import com.aska.logical.service.common.ITaskService;
import com.aska.repository.domain.vo.TaskVO;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-07-07
 */
@RestController
@RequestMapping("task")
public class TaskController {

    @Autowired
    ITaskService service;

    @Autowired
    IUserService userService;

    @Autowired
    ILiveCodeService liveCodeService;


    @GetMapping("list")
    @ApiOperation(value = "任务列表")
    public ResponseData selectListBy(){
        return ResponseData.success(service.selectList());
    }

    @PostMapping("add")
    @ApiOperation(value = "添加任务")
    public ResponseData addTask(@Validated(Insert.class) @RequestBody TaskVO vo){
        service.addTask(TaskVO.convert(vo));
        return ResponseData.success();
    }

    @PutMapping("update")
    @ApiOperation(value = "修改任务")
    public ResponseData updateTask(@Validated(Update.class) @RequestBody TaskVO vo){
        service.updateTask(TaskVO.convert(vo));
        return ResponseData.success();
    }

    @DeleteMapping("delete")
    @ApiOperation(value = "删除任务")
    public ResponseData deleteTask(@Validated(Update.class) @RequestBody TaskVO vo){
        service.deleteTask(TaskVO.convert(vo));
        return ResponseData.success();
    }

    @PostMapping("start")
    @ApiOperation(value = "开始任务")
    public ResponseData startTask(Long taskId){
        service.startTask(taskId);
        return ResponseData.success();
    }

    @PostMapping("pause")
    @ApiOperation(value = "暂停任务")
    public ResponseData pauseTask(Long taskId){
        service.pauseTask(taskId);
        return ResponseData.success();
    }

    @PostMapping("resume")
    @ApiOperation(value = "重启任务")
    public ResponseData resumeTask(Long taskId){
        service.resumeTask(taskId);
        return ResponseData.success();
    }

    @PostMapping("test")
    @ApiOperation(value = "测试数据")
    public ResponseData test(){
        liveCodeService.getWechatCode();
        return ResponseData.success();
    }

}
