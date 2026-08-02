package com.aska.repository.mapper;

import com.aska.repository.entity.Friend;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 用户黑名单表 Mapper 接口
 * </p>
 *
 * @author sy
 * @since 2025-07-16
 */
@Mapper
public interface FriendMapper extends BaseMapper<Friend> {

}
