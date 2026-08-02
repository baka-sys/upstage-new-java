package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.Admin;
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
public class AdminVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账号")
    private String account;

    @ApiModelProperty(value = "密码")
    private String password;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Admin convert(AdminVO vo) {
        Admin entity = new Admin();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Admin> convertList(List<AdminVO> list) {
        List<Admin> resultList = new ArrayList<>();
        for (AdminVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
