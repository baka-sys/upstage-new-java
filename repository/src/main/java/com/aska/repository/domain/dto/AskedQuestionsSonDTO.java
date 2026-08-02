package com.aska.repository.domain.dto;

import com.aska.repository.entity.AskedQuestionsSon;
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
public class AskedQuestionsSonDTO {

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


    public AskedQuestionsSonDTO() {}

    public AskedQuestionsSonDTO(AskedQuestionsSon entity) {
        BeanUtils.copyProperties(entity,this);
    }

    public static AskedQuestionsSonDTO convert(AskedQuestionsSon entity) {
        return new AskedQuestionsSonDTO(entity);
    }

    public static List<AskedQuestionsSonDTO> convertList(List<AskedQuestionsSon> list) {
        List<AskedQuestionsSonDTO> resultList = new ArrayList<>();
        for (AskedQuestionsSon entity : list) {
            resultList.add(new AskedQuestionsSonDTO(entity));
        }
        return resultList;
    }}
