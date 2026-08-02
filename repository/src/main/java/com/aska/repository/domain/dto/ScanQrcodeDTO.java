package com.aska.repository.domain.dto;

import com.aska.repository.entity.ScanQrcode;
import lombok.Data;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.aska.common.util.BeanUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Date;


/**
 * @author sy
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class ScanQrcodeDTO {

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


    public ScanQrcodeDTO() {}

    public ScanQrcodeDTO(ScanQrcode entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static ScanQrcodeDTO convert(ScanQrcode entity) {
        return new ScanQrcodeDTO(entity);
    }

    public static List<ScanQrcodeDTO> convertList(List<ScanQrcode> list) {
        List<ScanQrcodeDTO> resultList = new ArrayList<>();
        for (ScanQrcode entity : list) {
            resultList.add(new ScanQrcodeDTO(entity));
        }
        return resultList;
    }}
