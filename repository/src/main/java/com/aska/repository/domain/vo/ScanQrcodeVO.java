package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.ScanQrcode;
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
public class ScanQrcodeVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "卡密id")
    private Long customerId;

    @ApiModelProperty(value = "扫码次数")
    private Integer number;

    @ApiModelProperty(value = "ip地址")
    private String ipAddress;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static ScanQrcode convert(ScanQrcodeVO vo) {
        ScanQrcode entity = new ScanQrcode();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<ScanQrcode> convertList(List<ScanQrcodeVO> list) {
        List<ScanQrcode> resultList = new ArrayList<>();
        for (ScanQrcodeVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
