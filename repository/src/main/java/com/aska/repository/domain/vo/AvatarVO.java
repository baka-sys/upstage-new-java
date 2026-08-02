package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Avatar;
import com.fasterxml.jackson.annotation.JsonFormat;
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
public class AvatarVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "图片地址")
    private String url;

    @ApiModelProperty(value = "创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Avatar convert(AvatarVO vo) {
        Avatar entity = new Avatar();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Avatar> convertList(List<AvatarVO> list) {
        List<Avatar> resultList = new ArrayList<>();
        for (AvatarVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
