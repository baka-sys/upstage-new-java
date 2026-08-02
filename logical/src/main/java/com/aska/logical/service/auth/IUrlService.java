package com.aska.logical.service.auth;

import com.aska.repository.entity.Url;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 域名表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-17
 */
public interface IUrlService extends IService<Url> {

    Map<String,String> addAndUpdateByUrl(Url url);

    List<Url> selectList(Long userId);
}
