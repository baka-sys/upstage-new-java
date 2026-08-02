package com.aska.repository.mapper;

import com.aska.repository.entity.Customer;
import com.aska.repository.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2026-07-09
 */
@Mapper
public interface CustomerMapper extends BaseMapper<Customer> {

    @Select("select id,type,carmine,is_search from cs_customer where type = 1 and expiration_date is not null and left(active_time,10)!=left(now(),10) and expiration_date > now()")
    List<Customer> selectNotExpired();

}
