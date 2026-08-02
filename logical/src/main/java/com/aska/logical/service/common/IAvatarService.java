package com.aska.logical.service.common;

import com.aska.repository.entity.Avatar;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * <p>
 * 头像库 服务类
 * </p>
 *
 * @author sy
 * @since 2025-05-15
 */
public interface IAvatarService extends IService<Avatar> {

    Page<Avatar> selectPageList(Integer page, Integer limit);

    Map<String,String> add(MultipartFile file, HttpServletRequest request);
}
