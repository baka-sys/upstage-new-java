package com.aska.repository.mapper;

import com.aska.repository.entity.CustomerCount;
import com.aska.repository.entity.User;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 用户表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-01-06
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {


    @Select("<script>" +
            "with base as ( " +
            "  select id,account_id,active_state,expiration_date,login_time from cs_user where type = 1 and test_card = 0" +
            "<if test='accountId != null'>" +
            " and account_id = #{accountId}" +
            "</if>" +
            "), " +
            "total as ( " +
            "  select count(*) number from base " +
            "), " +
            "useTotal as ( " +
            "  select count(*) number from base where active_state = 1 and expiration_date &gt;= CURRENT_DATE() and left(login_time,10) = current_date()" +
            "), " +
            "stopTotal as ( " +
            "  select count(*) number from base where active_state = 1 and expiration_date &lt;= CURRENT_DATE() " +
            "), " +
            "notActiveTotal as ( " +
            "  select count(*) number from base where active_state = 0 " +
            "), " +
            "rechargedTotal as ( " +
            "  select sum(days) number from cs_renewal_record where left(create_time,10) = CURRENT_DATE() " +
            ")" +
            "select ifnull(a.number,0) total,ifnull(b.number,0) useTotal, " +
            "ifnull(c.number,0) stopTotal,ifnull(d.number,0) notActiveTotal, " +
            "ifnull(e.number,0) rechargedTotal  " +
            "from total a,useTotal b,stopTotal c,notActiveTotal d,rechargedTotal e" +
            "</script>")
    CustomerCount selectUserCountByAccountId(Long accountId);

    @Select("select count(*) from (select count(*) from cs_friend where left(create_time,10) = #{nowDate} group by from_id,to_id) a")
    Integer selectUserCountByS(String nowDate);

    @Select("select count(*) from cs_user where type = 1 and left(active_time,10) = #{nowDate} and test_card = 0 ")
    Integer selectCountState(String nowDate);

    @Select("select id from cs_user where type = 1 and left(login_time,10) = #{nowDate}")
    List<User> selectCustomerUserByDate(String nowDate);

    @Select("select count(*) from (select count(*) from cs_friend where left(create_time,10) = CURRENT_DATE and from_id=#{fromId} group by from_id,to_id) a")
    Integer selectUserTodayCountBy(Long fromId);

    @Select("select count(*) from (select count(*) from cs_friend where from_id=#{fromId} group by from_id,to_id) a")
    Integer selectUserCountBy(Long fromId);


    @Select("select a.*,c.number dosage from cs_user a left join cs_say_hello b on a.id = b.user_id and b.account_type = 0 " +
            " left join cs_customer_count c on a.id = c.customer_id " +
            " ${ew.customSqlSegment} ")
    Page<User> selectActivePage(Page<User> userPage,@Param(Constants.WRAPPER) Wrapper wrapper);

    @Select("select b.*,d.number dosage from cs_renewal_record a \n " +
            "left join cs_user b on a.user_id = b.id\n " +
            "left join cs_say_hello c on a.user_id = c.user_id and c.account_type = 0\n " +
            "left join cs_customer_count d on a.user_id = d.customer_id " +
            " ${ew.customSqlSegment} ")
    Page<User> selectRenewPage(Page<User> userPage,@Param(Constants.WRAPPER) Wrapper wrapper);

}
