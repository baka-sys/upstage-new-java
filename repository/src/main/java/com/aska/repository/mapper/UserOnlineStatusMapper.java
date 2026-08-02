package com.aska.repository.mapper;

import com.aska.repository.entity.UserOnlineStatus;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * 用户在线表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Mapper
public interface UserOnlineStatusMapper extends BaseMapper<UserOnlineStatus> {


    @Select("select count(*) from cs_user_online_status a left join cs_user b on a.user_id = b.id and b.test_card = 0 and b.expiration_date > current_date where a.type = 1 and b.expiration_date is not null")
    Long selectUserOnlineStatus(Long userId);

}
