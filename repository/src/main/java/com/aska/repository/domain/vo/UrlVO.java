package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Url;
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
public class UrlVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "客户或者企业端用户")
    private Long userId;

    @ApiModelProperty(value = "域名")
    private String url;

    @ApiModelProperty(value = "账号类型")
    private Integer accountType;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Url convert(UrlVO vo) {
        Url entity = new Url();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Url> convertList(List<UrlVO> list) {
        List<Url> resultList = new ArrayList<>();
        for (UrlVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
