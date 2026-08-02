package com.aska.logical.service.auth;

import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;


public interface IUploadFileService {

    /**
     * 上传图片到七牛云  返回名称 和 url
     */
    HashMap<String, String> saveImage(MultipartFile file) throws IOException;

    /**
     * 上传图片到本地路径
     */
    Map<String, String> uploadImageLocal(MultipartFile file, HttpServletRequest request) throws IOException;

}