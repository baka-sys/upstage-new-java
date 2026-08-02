package com.aska.repository.mapper;

import com.aska.repository.entity.EntryRatio;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 劫持比例表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2026-01-06
 */
@Mapper
public interface EntryRatioMapper extends BaseMapper<EntryRatio> {


    @Select("select * from cs_entry_ratio where left(create_time,10) = left(now(),10)")
    List<EntryRatio> selectListAllByCreateTime();


    @Select("select * from cs_entry_ratio a left join cs_user b on a.main_user_id = b.id " +
            "where b.type = #{type} and left(a.create_time,10) = left(now(),10)")
    List<EntryRatio> selectListByType(Integer type);

}
