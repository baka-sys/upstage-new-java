package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Task;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class TaskVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Task convert(TaskVO vo) {
        Task entity = new Task();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Task> convertList(List<TaskVO> list) {
        List<Task> resultList = new ArrayList<>();
        for (TaskVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
