package com.aska.repository.mapper;

import com.aska.repository.entity.UserCount;
import com.aska.repository.entity.UserCountBroken;
import com.aska.repository.entity.UserCountData;
import com.aska.repository.entity.UserCountRate;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 用户统计表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-03-26
 */
@Mapper
public interface UserCountMapper extends BaseMapper<UserCount> {

    /**
     * 获取面板统计数据
     * @param customerIds
     * @return
     */
    @Select("<script>" +
            "with base as (" +
            "  select * from cs_user_count where 1 = 1 " +
            " <if test='customerIds != null and customerIds.size() > 0'>" +
            " and customer_id in" +
            "<foreach item='customerId' collection='customerIds' open='(' separator=',' close=')' >" +
            "#{customerId}" +
            "</foreach>" +
            "</if>" +
            ")," +
            "total as ( " +
            "  select count(*) number from (select count(user_id) from base GROUP BY user_id) a " +
            ")," +
            "todayTotal as ( " +
            "  select count(*) number from (select user_id from base where left(create_time,10) = curdate()  GROUP BY user_id) a " +
            "), " +
            "secondTotal as ( " +
            "  select count(*) number from (select user_id from base where left(create_time,10) = curdate() and (offline_time-login_time) > 5  GROUP BY user_id) a " +
            "), " +
            "activeUserTotal as ( " +
            "  select count(*) number from (select count(*) as activeNum from base where left(create_time,10) = curdate() GROUP BY user_id)a where a.activeNum > 1 " +
            "), " +
            "responseTotal as ( " +
            "  select count(*) number from (select count(*) from base where left(create_time,10) = curdate() and client_reply=1 GROUP BY user_id,client_reply)a " +
            ") " +
            "select a.number total,b.number todayTotal,c.number secondTotal,d.number activeUserTotal,ifnull(e.number/b.number,0) responseRate from total a,todayTotal b,secondTotal c,activeUserTotal d,responseTotal e " +
            "</script>")
    UserCountData selectCountData(List<Long> customerIds);

    @Select("<script>" +
            "with base as (\n" +
            " select a.*,b.to_id,left(b.create_time,10) group_time from cs_user_count  a left join cs_friend b on a.customer_id=b.from_id and a.user_id = b.to_id and left(a.create_time,10) = left(b.create_time,10) " +
            "where a.customer_id = #{customerId} and left(b.create_time,10) = curdate()\n" +
            "), \n" +
            "baseTotal as ( \n" +
            "select to_id,Max(time_slot) time_slot,MAX(create_time) create_time,MAX(offline_time) offline_time,MIN(is_domestic) is_domestic,MIN(is_wechat) is_wechat,ip_address,client_reply,customer_reply,MAX((offline_time - login_time)/1000) stop_time from base group by ip_address,to_id,create_time\n" +
            "),\n" +
            "totalUserTotal as (\n" +
            "select b.name,a.*,a.create_time loginTime,b.create_time registerTime,b.ip_address register_ipaddress from (select * from (select * from baseTotal GROUP BY ip_address,left(create_time,10)) a) a left join cs_user b on a.to_id = b.id \n" +
            "),\n" +
            "sendMessageTotalJoin as (\n" +
            "select a.to_id,sum(a.messageNumber) number from (select to_id,ifnull(sum(client_reply),0) messageNumber from base where client_reply > 0 GROUP BY ip_address,left(create_time,10)) a group by to_id \n" +
            "),\n" +
            "totalList as (\n" +
            " select a.*,b.number ipAddressCount from (select a.*,ifnull(b.number,0) messageNumber from totalUserTotal a left join sendMessageTotalJoin b on a.to_id = b.to_id) a left join cs_ip_address b on a.ip_address = b.ip_address " +
            "),\n" +
            "filterTotalList as (\n" +
            "   select * from totalList where 1=1 " +
            "<if test='domesticSwitch == null'>" +
            " and is_domestic = 0 " +
            "</if>" +
            "<if test='secondsSwitch == null'>" +
            " and (offline_time != 0 or time_slot!=0)" +
            "</if>" +
            "<if test='stopSwitch == null'>" +
            " and stop_time &gt;= #{stopTimeNumber}" +
            "</if>" +
            "<if test='wechatSwitch == null'>" +
            " and is_wechat = 0 " +
            "</if>" +
            "<if test='countSwitch == 1'>" +
            " and ipAddressCount &lt;= #{ipAddressNumber} " +
            "</if>" +
            "),\n" +
            "todayTotal as (\n" +
            "  select count(*) number from (select to_id,left(create_time,10) create_time from filterTotalList group by ip_address,left(create_time,10)) a group by create_time\n" +
            ")" +
            "select number todayTotal from todayTotal " +
            "</script>")
    UserCountData selectCountDataByIpAddress(Long customerId,Integer domesticSwitch,Integer secondsSwitch,Integer countSwitch,
                                             Integer ipAddressNumber,Integer stopSwitch,Integer stopTimeNumber,Integer wechatSwitch);


    @Select("<script> " +
            "with base as ( " +
            "  select count(*) as number,create_time from (select user_id,LEFT(create_time,10) create_time from cs_user_count where LEFT(create_time,10) &lt;= CURDATE() " +
            " and LEFT(create_time,10) &gt; DATE_SUB(CURDATE(),INTERVAL 7 DAY) " +
            " <if test='customerIds != null and customerIds.size() > 0'>" +
            " and customer_id in" +
            "<foreach item='customerId' collection='customerIds' open='(' separator=',' close=')' >" +
            "#{customerId}" +
            "</foreach>" +
            "</if>" +
            " group by user_id,LEFT(create_time,10)) a GROUP BY create_time " +
            "), " +
            "dateIndex as ( " +
            "  SELECT CURDATE() - INTERVAL N DAY AS recent_date " +
            "  FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6) AS days " +
            "  ORDER BY recent_date DESC " +
            ") " +
            "select SUBSTRING(a.recent_date,6,6) recentDate,IFNULL(b.number,0) number from dateIndex a left join base b on a.recent_date = b.create_time order by a.recent_date asc " +
            "</script>")
    List<UserCountBroken> selectCountByCreateTime(List<Long> customerIds);


    @Select("<script> " +
            "with base as ( " +
            "  select user_id,city_name from cs_user_count where left(create_time,10) = curdate()" +
            " <if test='customerIds != null and customerIds.size() > 0'>" +
            " and customer_id in" +
            "<foreach item='customerId' collection='customerIds' open='(' separator=',' close=')' >" +
            "#{customerId}" +
            "</foreach>" +
            "</if>" +
            ")," +
            "todayTotal as (" +
            "   select count(*) number from (select user_id from base GROUP BY user_id) a " +
            ")," +
            "cityTotal as ( " +
            "  select count(*) as number,city_name from (select count(*) as number,city_name from base GROUP BY city_name,user_id) a GROUP BY a.city_name " +
            ") " +
            "select IFNULL(a.number/b.number,0) rate,a.city_name cityName from cityTotal a,todayTotal b " +
            "</script>")
    List<UserCountRate> selectCountByRate(List<Long> customerIds);

}
