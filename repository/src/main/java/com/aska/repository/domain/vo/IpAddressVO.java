package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.IpAddress;
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
public class IpAddressVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "ip次数")
    private String ipAddress;

    @ApiModelProperty(value = "停留次数")
    private Integer number;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static IpAddress convert(IpAddressVO vo) {
        IpAddress entity = new IpAddress();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<IpAddress> convertList(List<IpAddressVO> list) {
        List<IpAddress> resultList = new ArrayList<>();
        for (IpAddressVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
