package com.aska.client.controller.auth;

import com.aska.client.config.annotation.Login;
import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.logical.service.auth.IQuickReplyService;
import com.aska.repository.domain.dto.QuickReplyDTO;
import com.aska.repository.domain.vo.QuickReplyVO;
import com.aska.repository.entity.QuickReply;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 快捷回复表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-01-16
 */
@RestController
@RequestMapping("quickReply")
@Api(tags = "快捷回复")
public class QuickReplyController {

    @Autowired
    IQuickReplyService service;

    @GetMapping("page")
    @ApiOperation(value = "分页数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page", value = "页码", required = true, type = "int"),
            @ApiImplicitParam(name = "limit", value = "条数", required = true, type = "int"),
            @ApiImplicitParam(name = "accountType", value = "账号类型", required = true, type = "int")
    })
    public ResponseData<List<QuickReplyDTO>> selectPageList(
            @RequestParam Integer page,
            @RequestParam Integer limit,
            @RequestParam Integer accountType,
            @ApiParam(hidden = true) @Login Long userId
    ){
        Page<QuickReply> quickReplyPage = service.selectPageList(page, limit, userId,accountType);
        return ResponseData.success(QuickReplyDTO.convertList(quickReplyPage.getRecords()), quickReplyPage.getTotal());
    }

    @PostMapping("add")
    @ApiOperation(value = "添加")
    public ResponseData<Integer> addQuickReply(
            @RequestBody
            @Validated(Insert.class) QuickReplyVO vo,
            @Login @ApiParam(hidden = true) Long userId) {
        service.addQuickReply(QuickReplyVO.convert(vo), userId);
        return ResponseData.success();
    }

    @PutMapping("update")
    @ApiOperation(value = "修改")
    public ResponseData<Integer> updateQuickReply(
            @RequestBody
            @Validated(Update.class) QuickReplyVO vo
    ){
        service.updateQuickReply(QuickReplyVO.convert(vo));
        return ResponseData.success();
    }

    @DeleteMapping("deleted")
    @ApiOperation(value = "删除")
    public ResponseData<Integer> deletedQuickReply(
            @ApiParam(name = "id", value = "自增id", required = true, type = "long")
            @RequestParam Long id) {
        return ResponseData.success(service.deleteQuickReply(id));
    }

    @PostMapping("top")
    @ApiOperation(value = "上移")
    public ResponseData sortTop(@ApiParam(name = "id", value = "自增id", required = true, type = "long") @RequestParam Long id){
        service.sortTop(id);
        return ResponseData.success();
    }

    @PostMapping("bottom")
    @ApiOperation(value = "下移")
    public ResponseData sortBottom(@ApiParam(name = "id", value = "自增id", required = true, type = "long") @RequestParam Long id){
        service.sortBottom(id);
        return ResponseData.success();
    }

}
