package com.aska.upstage.controller.common;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.common.IAvatarService;
import com.aska.repository.domain.dto.AvatarDTO;
import com.aska.repository.entity.Avatar;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.annotations.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Map;

/**
 * <p>
 * 头像库 前端控制器
 * </p>
 *
 * @author sy
 * @since 2025-05-15
 */
@RestController
@RequestMapping("avatar")
@Api(tags = "头像管理")
public class AvatarController {

    @Autowired
    IAvatarService avatarService;

    @GetMapping("page")
    @ApiOperation(value = "获取头像列表")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "page",required = true,type = "int",value = "分页"),
            @ApiImplicitParam(name = "limit",required = true,type = "int",value = "条数"),
    })
    public ResponseData selectImageList(@RequestParam Integer page,@RequestParam Integer limit){
        Page<Avatar> avatarPage = avatarService.selectPageList(page,limit);
        return ResponseData.success(AvatarDTO.convertList(avatarPage.getRecords()), avatarPage.getTotal());
    }

    @PostMapping("uploadImg")
    @ApiOperation(value = "上传头像")
    public ResponseData uploadImg(@RequestParam("file") MultipartFile file, @ApiParam(hidden = true) HttpServletRequest request) throws IOException {
        return ResponseData.success(avatarService.add(file,request));
    }
}
