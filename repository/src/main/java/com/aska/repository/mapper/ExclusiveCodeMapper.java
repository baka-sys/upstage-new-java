package com.aska.repository.mapper;

import com.aska.repository.entity.ExclusiveCode;
import com.aska.repository.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 专属域名 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2026-03-15
 */
@Mapper
public interface ExclusiveCodeMapper extends BaseMapper<ExclusiveCode> {


    @Select("select b.carmine from cs_exclusive_code a left join cs_user b on a.user_id = b.id where a.live_code_id = #{liveCodeId}")
    List<User> selectCarmineListById(Long liveCodeId);
}
