package com.aska.logical.service.common;

import com.aska.repository.entity.ScanQrcode;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sy
 * @since 2025-08-28
 */
public interface IScanQrcodeService extends IService<ScanQrcode> {

    Long selectCountBy(Long customerId);
}
