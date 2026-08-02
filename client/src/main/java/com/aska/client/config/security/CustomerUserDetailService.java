package com.aska.client.config.security;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.aska.common.model.ResultCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Service
public class CustomerUserDetailService implements UserDetailsService {

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        if(StrUtil.isBlank(s)){
            throw new UsernameNotFoundException(JSON.toJSONString(ResultCode.USER_INFO_NOT_FOUND));
        }
        return new User(s,"", AuthorityUtils.commaSeparatedStringToAuthorityList("system"));
    }
}
