package com.aska.logical.service.configuration;

import com.aska.repository.entity.OperationAuto;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
public interface IOperationAutoService extends IService<OperationAuto> {

    Integer addAuto(OperationAuto convert);

    void updateAuto(OperationAuto convert);

    @Transactional(rollbackFor = RuntimeException.class)
    void updateOne(HashMap hashMap);

    void deleteAuto(Integer id);

    OperationAuto selectDetailBySystemCode(String field);

    List<Object> selectDetailByCode(Integer codeType, HttpServletRequest request);

    List<OperationAuto> selectAllSystem();

    String selectRedisValueByFiled(String field);

    void cleanRedisConfig();
}
