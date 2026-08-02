package com.aska.logical.service.auth;

import com.aska.repository.entity.SayHello;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 打招呼表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-11
 */
public interface ISayHelloService extends IService<SayHello> {

    Page<SayHello> selectPageList(Integer page, Integer pageSize, Long userId, Integer accountType);

    void add(SayHello sayHello, Long userId);

    List<SayHello> getList(Long userId, Integer accountType);

    void update(SayHello sayHello);

    int delete(Long id);

    List<SayHello> getList(Long userId);

    void sortTop(Long id);

    void updateStatus(Long id);

    void sortBottom(Long id);

    void addSayHello(Long mainId, List<Long> userSet,Integer isRemove);
}
