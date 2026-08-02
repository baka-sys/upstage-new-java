package com.aska.logical.service.code;

import com.aska.repository.entity.BatchDomain;
import com.aska.repository.entity.CodeCount;
import com.aska.repository.entity.LiveCode;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletResponse;

/**
 * <p>
 * 商户域名表 服务类
 * </p>
 *
 * @author sy
 * @since 2025-07-17
 */
public interface ILiveCodeService extends IService<LiveCode> {

    Page<LiveCode> getDomainPage(String domainName,Integer type,Integer platformType, Integer page, Integer limit);

    @Transactional(rollbackFor = RuntimeException.class)
    void addBatchDomain(BatchDomain batchDomain);

    void updateDomain(LiveCode domain);

    void updateStatus(Long id);

    void delete(Long id);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchDelete(String ids);

    @Transactional(rollbackFor = RuntimeException.class)
    void batchReset(String ids,Integer type);

    @Transactional(rollbackFor = RuntimeException.class)
    void sortTop(Long id);

    @Transactional(rollbackFor = RuntimeException.class)
    void sortBottom(Long id);

    void getWechatCode();

    Boolean checkDomain(String httpUrl,String url);

    CodeCount selectCodeCount();

    String responseDomainUrl();

    void exportExcelByLiveCode(HttpServletResponse response);
}
