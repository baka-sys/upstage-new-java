package com.aska.repository.domain.vo;

import com.aska.common.model.Update;
import com.aska.repository.entity.AskedQuestionsSon;
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
public class AskedQuestionsSonVO {

    private static final long serialVersionUID = 1L;

    private Long id;

    @ApiModelProperty(value = "账号类型:0客服账号，1、企业账号")
    private Integer accountType;

    private Long mainId;

    private String questionName;

    private Integer answerType;

    private String answerContent;

    private Integer sort;

    private String status;

    private Date createTime;

    private Date updateTime;


    @NotNull(groups = Update.class,message = "主键不能为空")
    public static AskedQuestionsSon convert(AskedQuestionsSonVO vo) {
        AskedQuestionsSon entity = new AskedQuestionsSon();
        BeanUtils.copyProperties(vo,entity);
        return entity;
    }
    public static List<AskedQuestionsSon> convertList(List<AskedQuestionsSonVO> list) {
        List<AskedQuestionsSon> resultList = new ArrayList<>();
        for (AskedQuestionsSonVO vo : list) {
            resultList.add(convert(vo));
        }
        return resultList;
    }
}
