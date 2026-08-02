package com.aska.repository.mapper;

import com.aska.repository.entity.Domain;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-07-21
 */
@Mapper
public interface DomainMapper extends BaseMapper<Domain> {


    /**
     * 截断表，清空所有数据并重置自增主键。
     */
    @Update("TRUNCATE TABLE cs_domain")
    void truncateTable();

}
