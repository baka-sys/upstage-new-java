package com.aska.client.controller.auth;

import com.aska.common.model.ResponseData;
import com.aska.logical.service.auth.IUploadFileService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("other")
@Api(tags = "其他")
public class OtherController {

    @Autowired
    IUploadFileService uploadFileService;

    @PostMapping("upload")
    @ApiOperation(value = "上传图片")
    public ResponseData upload(MultipartFile file) throws IOException {
        HashMap<String, String> url = uploadFileService.saveImage(file);
        return ResponseData.success(url);
    }

    @PostMapping("uploadImg")
    @ApiOperation(value = "上传图片到本地")
    public ResponseData<Map<String, String>> uploadImg(@RequestParam("file") MultipartFile file,@ApiParam(hidden = true) HttpServletRequest request) throws IOException {
        Map<String, String> map = uploadFileService.uploadImageLocal(file,request);
        return ResponseData.success(map);
    }

}
