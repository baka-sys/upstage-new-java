package com.aska.client.controller.auth;

import com.aska.common.model.Insert;
import com.aska.common.model.ResponseData;
import com.aska.common.model.Update;
import com.aska.client.config.annotation.Login;
import com.aska.logical.service.auth.ISayHelloService;
import com.aska.repository.domain.dto.SayHelloDTO;
import com.aska.repository.domain.vo.SayHelloVO;
import com.aska.repository.entity.SayHello;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 打招呼表 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-03-11
 */
@RestController
@RequestMapping("sayHello")
public class SayHelloController {

    @Autowired
    ISayHelloService service;

    @GetMapping("page")
    @ApiOperation(value = "分页数据")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page", value = "页码", required = true, type = "int"),
            @ApiImplicitParam(name = "limit", value = "条数", required = true, type = "int"),
            @ApiImplicitParam(name = "accountType", value = "账号类型", required = true, type = "int")
    })
    public ResponseData<List<SayHelloDTO>> selectPageList(
            @RequestParam Integer page,
            @RequestParam Integer limit,
            @RequestParam Integer accountType,
            @ApiParam(hidden = true) @Login Long userId
    ){
        Page<SayHello> result = service.selectPageList(page, limit, userId,accountType);
        return ResponseData.success(SayHelloDTO.convertList(result.getRecords()), result.getTotal());
    }

    @PostMapping("add")
    @ApiOperation(value = "添加")
    public ResponseData<Integer> addQuickReply(
            @RequestBody
            @Validated(Insert.class) SayHelloVO vo,
            @Login @ApiParam(hidden = true) Long userId) {
        service.add(SayHelloVO.convert(vo), userId);
        return ResponseData.success();
    }

    @PutMapping("update")
    @ApiOperation(value = "修改")
    public ResponseData<Integer> updateQuickReply(
            @RequestBody
            @Validated(Update.class) SayHelloVO vo
    ){
        service.update(SayHelloVO.convert(vo));
        return ResponseData.success();
    }

    @DeleteMapping("deleted")
    @ApiOperation(value = "删除")
    public ResponseData<Integer> deletedQuickReply(
            @ApiParam(name = "id", value = "自增id", required = true, type = "long")
            @RequestParam Long id) {
        return ResponseData.success(service.delete(id));
    }

    @PostMapping("status")
    @ApiOperation(value = "切换状态")
    public ResponseData updateStatus(
            @ApiParam(name = "id", value = "自增id", required = true, type = "long")
            @RequestParam Long id) {
        service.updateStatus(id);
        return ResponseData.success();
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
