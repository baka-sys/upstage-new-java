package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.common.util.BeanUtils;
import com.aska.repository.entity.Friend;
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
public class FriendVO {

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


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static Friend convert(FriendVO vo) {
        Friend entity = new Friend();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<Friend> convertList(List<FriendVO> list) {
        List<Friend> resultList = new ArrayList<>();
        for (FriendVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
