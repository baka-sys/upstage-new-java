package com.aska.repository.mapper;

import com.aska.repository.entity.RenewalRecord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 续费记录 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-03-10
 */
@Mapper
public interface RenewalRecordMapper extends BaseMapper<RenewalRecord> {


    @Select("<script>" +
            "select ifnull(sum(days),0) from cs_renewal_record where left(create_time,10) = CURRENT_DATE() " +
            " <if test='userIds != null and userIds.size() > 0'>" +
            " and user_id in" +
            "<foreach item='userId' collection='userIds' open='(' separator=',' close=')' >" +
            "#{userId}" +
            "</foreach>" +
            "</if>" +
            "</script>")
    Double selectTodayCountDays(List<Long> userIds);

}
