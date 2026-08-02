package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Task;
import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author sy
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class TaskDTO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "名称")
    private String title;

    @ApiModelProperty(value = "触发类")
    private String handler;

    @ApiModelProperty(value = "定时器表达式")
    private String cron;

    @ApiModelProperty(value = "任务状态：0，未开始，1，执行中，2.暂停中")
    private Integer state;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public TaskDTO() {}

    public TaskDTO(Task entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static TaskDTO convert(Task entity) {
        return new TaskDTO(entity);
    }

    public static List<TaskDTO> convertList(List<Task> list) {
        List<TaskDTO> resultList = new ArrayList<>();
        for (Task entity : list) {
            resultList.add(new TaskDTO(entity));
        }
        return resultList;
    }}
