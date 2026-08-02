package com.aska.logical.service.common.impl;

import cn.hutool.core.date.DateUtil;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.UploadFileUtils;
import com.aska.repository.entity.Avatar;
import com.aska.repository.mapper.AvatarMapper;
import com.aska.logical.service.common.IAvatarService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * 头像库 服务实现类
 * </p>
 *
 * @author sy
 * @since 2025-05-15
 */
@Service
public class AvatarServiceImpl extends ServiceImpl<AvatarMapper, Avatar> implements IAvatarService {

    @Autowired
    AvatarMapper mapper;

    @Value("${upload.path}")
    private String uploadPath;

    private final static  String AVATAR_PATH = "/avatar";

    private final static String AVATAR_PREFIX_NAME = "avatar_";


    @Override
    public Page<Avatar> selectPageList(Integer page, Integer limit) {
        Page<Avatar> avatarPage = new Page(page, limit);
        Page<Avatar> result = mapper.selectPage(avatarPage,null);
        return result;
    }

    @Override
    public Map<String,String> add(MultipartFile file, HttpServletRequest request){
        String uploadPathAvatar = uploadPath + AVATAR_PATH;
        try {
            if (file.isEmpty()) {
                throw new CustomException(ResultCode.ERROR.code(),"文件为空,请重新选择!");
            }
            File file1 = new File(uploadPathAvatar);
            if (!file1.exists()) {
                file1.mkdirs();
            }
            // 获取文件原始名(包含后缀名)
            String orgName = file.getOriginalFilename();
            // 获取文件名（不包括后缀）
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
                fileName = AVATAR_PREFIX_NAME + System.currentTimeMillis() + ".jpg";
            } else {
                // 上传的图片没有后缀（这压根就不算是一个正常的图片吧？）
                throw new CustomException(ResultCode.ERROR.code(), "上传图片格式错误,请重新选择！");
            }
            String savePath = file1.getPath() + File.separator + fileName;

            File saveFile = new File(savePath);
            //将上传的文件复制到指定目录
            FileCopyUtils.copy(file.getBytes(), saveFile);
            // 返回给前端的图片保存路径；前台可以根据返回的路径拼接完整地址，即可在浏览器上预览该图片
            String path = AVATAR_PATH + File.separator + fileName;
            if (path.contains("\\")) {
                path = path.replace("\\", "/");
            }
            // 存入数据库
            Avatar avatar = new Avatar();
            avatar.setUrl(path);
            avatar.setCreateTime(DateUtil.date());
            mapper.insert(avatar);
            Map<String,String> map = new HashMap<>();
            map.put("name",fileName);
            map.put("path",path);
            return map;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
