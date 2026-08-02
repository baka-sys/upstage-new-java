package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.SystemDomain;
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
public class SystemDomainVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "域名")
    private String domainUrl;

    @ApiModelProperty(value = "1:直连域名，2：图片域名，3、上传域名")
    private Integer type;

    @ApiModelProperty(value = "0:未使用，1：使用中")
    private Integer status;

    private Date updateTime;

    private Date createTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static SystemDomain convert(SystemDomainVO vo) {
        SystemDomain entity = new SystemDomain();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<SystemDomain> convertList(List<SystemDomainVO> list) {
        List<SystemDomain> resultList = new ArrayList<>();
        for (SystemDomainVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
