package com.aska.repository.mapper;

import com.aska.repository.entity.CodeCount;
import com.aska.repository.entity.LiveCode;
import com.aska.repository.entity.LiveCodeNumber;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 商户域名表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-07-17
 */
@Mapper
public interface LiveCodeMapper extends BaseMapper<LiveCode> {

    @Select("select c.* from cs_domain a join cs_live_code b on a.live_code_id=b.id and b.deleted = 0 " +
            "                          join cs_live_code_number c on a.live_code_id = c.live_code_id " +
            "where a.user_id = #{userId} and c.number > 0")
    LiveCodeNumber selectByUserId(Long userId);

    @Select("with codeBase as (\n" +
            "  select * from cs_live_code where left(create_time,10) = CURRENT_DATE\n" +
            "),\n" +
            "codeTodayNumber as (\n" +
            "  select count(*) number from codeBase\n" +
            "),\n" +
            "localCodeTodayNumber as (\n" +
            "  select count(*) number from codeBase where shell_type = 0\n" +
            "),\n" +
            "sCodeTodayNumber as (\n" +
            "  select count(*) number from codeBase where shell_type = 1\n" +
            "),\n" +
            " failbase as (" +
            "  select * from cs_live_code where left(delete_time,10) = CURRENT_DATE and deleted = 1 " +
            "),"+
            "codeFailTodayNumber as (\n" +
            "  select count(*) number from failbase " +
            "),\n" +
            "localCodeFailTodayNumber as (\n" +
            "  select count(*) number from failbase where shell_type = 0" +
            "),\n" +
            "sCodeFailTodayNumber as (\n" +
            "  select count(*) number from failbase where shell_type = 1 " +
            "),\n" +
            "entranceBase as (\n" +
            "  select * from cs_realm_name where left(create_time,10) = CURRENT_DATE\n" +
            "),\n" +
            "entranceNumber as (\n" +
            "  select count(*) number from entranceBase\n" +
            "),\n" +
            "entranceFailNumber as (\n" +
            "  select count(*) number from entranceBase where deleted = 1\n" +
            ")\n" +
            "select a.number codeTodayNumber,b.number localCodeTodayNumber,c.number sCodeTodayNumber,\n" +
            "d.number codeFailTodayNumber,e.number localCodeFailTodayNumber,f.number sCodeFailTodayNumber,\n" +
            "g.number entranceNumber,h.number entranceFailNumber\n" +
            " from codeTodayNumber a,localCodeTodayNumber b,sCodeTodayNumber c,codeFailTodayNumber d,localCodeFailTodayNumber e,sCodeFailTodayNumber f,entranceNumber g,entranceFailNumber h")
    CodeCount selectCodeCount();


    @Select("<script>" +
            "select a.id,a.type,a.shell_type,a.platform_type,a.domain_name,a.direct,a.sort,a.status,a.deleted,a.delete_time,a.create_time,a.update_time,b.number from cs_live_code a left join cs_live_code_number b on a.id = b.live_code_id where 1=1 and a.deleted=0 " +
            "<if test='domainName != null'>" +
            " and a.domain_name like CONCAT('%', #{domainName}, '%') " +
            "</if>" +
            "<if test='platformType != null'>" +
            " and a.platform_type = #{platformType} " +
            "</if>" +
            "<if test='type != null'>" +
            " and a.type = #{type} " +
            "</if>" +
            " order by sort desc " +
            "</script>")
    Page<LiveCode> selectPageByParams(String domainName,Integer type,Integer platformType,@Param("page") Page<LiveCode> page);


    @Select("select b.* from cs_domain a left join cs_exclusive_code b on a.live_code_id = b.id and a.type = 1 and b.status = 0")
    List<LiveCode> selectByType();
}
