package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.FallbackResponse;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import com.aska.common.util.BeanUtils;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;


/**
 * @author sy
 */
@Data
@ApiModel(value = "")
public class FallbackResponseVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账号类型：0客服，1企业")
    private Integer accountType;

    @ApiModelProperty(value = "账号id")
    private Long userId;

    @ApiModelProperty(value = "回复类型：")
    private Integer type;

    @ApiModelProperty(value = "回复内容")
    private String content;

    @ApiModelProperty(value = "开关：0开，1关")
    private Integer status;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static FallbackResponse convert(FallbackResponseVO vo) {
        FallbackResponse entity = new FallbackResponse();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<FallbackResponse> convertList(List<FallbackResponseVO> list) {
        List<FallbackResponse> resultList = new ArrayList<>();
        for (FallbackResponseVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
