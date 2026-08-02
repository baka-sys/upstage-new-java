package com.aska.repository.domain.dto;

import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Friend;
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
public class FriendDTO {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "黑名单自增id")
    private Integer id;

    @ApiModelProperty(value = "用户id")
    private Long fromId;

    @ApiModelProperty(value = "好友id")
    private Long toId;

    @ApiModelProperty(value = "原因")
    private String reason;

    @ApiModelProperty(value = "星标：0未选，1已选")
    private Integer star;

    @ApiModelProperty(value = "黑名单状态：0-有效1-无效")
    private Integer status;

    @ApiModelProperty(value = "备注")
    private String remark;

    @ApiModelProperty(value = "创建时间")
    private Date createTime;

    @ApiModelProperty(value = "修改时间")
    private Date updateTime;


    public FriendDTO() {}

    public FriendDTO(Friend entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static FriendDTO convert(Friend entity) {
        return new FriendDTO(entity);
    }

    public static List<FriendDTO> convertList(List<Friend> list) {
        List<FriendDTO> resultList = new ArrayList<>();
        for (Friend entity : list) {
            resultList.add(new FriendDTO(entity));
        }
        return resultList;
    }}
