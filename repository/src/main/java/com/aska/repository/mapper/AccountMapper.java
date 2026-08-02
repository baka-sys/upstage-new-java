package com.aska.repository.mapper;

import com.aska.repository.entity.Account;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 管理员总表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
@Mapper
public interface AccountMapper extends BaseMapper<Account> {

}
