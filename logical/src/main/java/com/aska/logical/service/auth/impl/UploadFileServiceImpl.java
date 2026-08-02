package com.aska.logical.service.auth.impl;


import com.alibaba.fastjson.JSONObject;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.FileUtil;
import com.aska.common.util.UploadFileUtils;
import com.aska.logical.service.auth.IUploadFileService;
import com.aska.logical.service.configuration.IOperationAutoService;
import com.aska.repository.entity.OperationAuto;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.system.ApplicationHome;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;


@Service
public class UploadFileServiceImpl implements IUploadFileService {
    /**
     * 域名
     */
    private final static String UPLOAD_URL = "http://pic.cqdragon.top";

    /**
     * access_key
     */
    private final  static String UPLOAD_ACCESS_KEY = "jX8nKFnaZFR7io75Y1f67mU28_hznlsC5t4Vlk20";

    /**
     * secret
     */
    private final static String UPLOAD_SECRET_KEY = "WrocoinzKsjZuRG6mO15A3rGDy34BfztuIc8fYCP";

    /**
     * bucket
     */
    private final static String UPLOAD_BUCKET = "dragon-system";

    Auth auth = Auth.create(UPLOAD_ACCESS_KEY,UPLOAD_SECRET_KEY);

    /* 配置七牛云 */
    Configuration configuration = new Configuration(Zone.zone2());

    UploadManager uploadManager = new UploadManager(configuration);

    private static final ObjectMapper objectMapper = new ObjectMapper();

    /* 本地存放路径 */
//    @Value(value = "E:/Other/Img")
    //@Value(value = "E:/Other/Img/ServerPro")
    //private static final String uploadPath = FileUtil.UPLOADS_PATH;
    //private String uploadPath;

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    IOperationAutoService autoService;


    /**
     * 获取凭证
     */
    public String getUpToken() {
        return auth.uploadToken(UPLOAD_BUCKET);
    }

    @Override
    public HashMap<String, String> saveImage(MultipartFile file) throws IOException {
        HashMap<String, String> hashMap = new HashMap<>();
        String authToken = getUpToken();
        try {
            int dotPos = file.getOriginalFilename().lastIndexOf(".");
            if (dotPos < 0) {
                return null;
            }
            String fileExt = file.getOriginalFilename().substring(dotPos + 1).toLowerCase();
            // 判断是否是合法的文件后缀
            if (!UploadFileUtils.isFileAllowed(fileExt)) {
                throw new CustomException(ResultCode.ERROR.code(), "非法的文件类型");
            }

            String fileName = UUID.randomUUID().toString().replaceAll("-", "") + "." + fileExt;
            // 调用put方法上传
            Response res = uploadManager.put(file.getBytes(), fileName, authToken);
            // 打印返回的信息
            if (res.isOK() && res.isJson()) {
                // 返回这张存储照片的地址
                hashMap.put("filePath",UPLOAD_URL + "/" + JSONObject.parseObject(res.bodyString()).get("key"));
                hashMap.put("fileName",file.getOriginalFilename());
                return hashMap;
            } else {
                throw new CustomException(ResultCode.ERROR.code(),"七牛异常:" + res.bodyString());
                //log.error("七牛异常:" + res.bodyString());
            }
        } catch (QiniuException e) {
            // 请求失败时打印的异常的信息
            throw new CustomException(ResultCode.ERROR.code(),"七牛异常:" + e.getMessage());
        }
    }

    @Override
    public Map<String, String> uploadImageLocal(MultipartFile file,HttpServletRequest request) throws IOException {
        // 获取图片服务器路径
        OperationAuto operationAuto  = autoService.selectDetailBySystemCode("image_url");
        String urlPath = operationAuto.getValue();
        try {
            if (file.isEmpty()) {
                throw new CustomException(ResultCode.ERROR.code(),"文件为空,请重新选择!");
            }
            File file1 = new File(uploadPath);
            if (!file1.exists()) {
                file1.mkdirs();
            }
            // 获取文件原始名(包含后缀名)
            String orgName = file.getOriginalFilename();
            // 获取文件名（不包括后缀）
            String prefixName = orgName.substring(0, orgName.lastIndexOf("."));
            // 获取文件后缀名
            String suffixName = orgName.substring(orgName.lastIndexOf("."));
            // 判断是否是合法的文件后缀
            if (!UploadFileUtils.isFileAllowed(suffixName.replace(".", ""))) {
                throw new CustomException(ResultCode.ERROR.code(), "非法的文件类型");
            }
            // 这是处理后的新文件名
            String fileName;
            if (orgName.contains(".")) {
                // 示例：avatar.123.png，经过处理后得到：avatar.123_1661136943533.png
                fileName = prefixName + "_" + System.currentTimeMillis() + suffixName;
            } else {
                // 上传的图片没有后缀（这压根就不算是一个正常的图片吧？）
                throw new CustomException(ResultCode.ERROR.code(), "上传图片格式错误,请重新选择！");
            }
           String savePath = file1.getPath() + File.separator + fileName;
            File saveFile = new File(savePath);
            // 将上传的文件复制到指定目录
            FileCopyUtils.copy(file.getBytes(), saveFile);
            // 返回给前端的图片保存路径；前台可以根据返回的路径拼接完整地址，即可在浏览器上预览该图片
            String path = urlPath + File.separator + fileName;
            if (path.contains("\\")) {
                path = path.replace("\\", "/");
            }
            Map<String, String> hashMap = new HashMap<>();
            hashMap.put("fileName", orgName);
            hashMap.put("filePath", path);
            return hashMap;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
