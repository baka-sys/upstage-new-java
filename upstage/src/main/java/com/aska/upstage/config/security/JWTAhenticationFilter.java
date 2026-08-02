package com.aska.upstage.config.security;


import com.aska.common.util.JwtUtil;
import com.aska.common.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import static com.aska.common.util.JwtUtil.TOKEN_PREFIX;


public class JWTAhenticationFilter extends BasicAuthenticationFilter {

    @Autowired
    RedisUtil redisUtil;

    public JWTAhenticationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        String tokenHeader = request.getHeader(JwtUtil.HEADER_STRING);
        if (tokenHeader == null || !tokenHeader.startsWith(TOKEN_PREFIX)) {
            chain.doFilter(request, response);
            return;
        }
        // 判断刷新token是否传入
//        String refreshToken = request.getHeader(JwtUtil.REFRESH_HEDAER_STRING);
//        if(StrUtil.isBlank(refreshToken)){
//            response.setCharacterEncoding("utf-8");
//            response.setContentType("application/json; charset=utf-8");
//            response.setStatus(401);
//            ResponseData fail = ResponseData.error(ResultCode.TOKEN_ERROR.code(),ResultCode.REFRESH_TOKEN_IS_EXIT.message());
//            response.getWriter().write(JSON.toJSONString(fail));
//            return;
//        }
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(null, null, AuthorityUtils.commaSeparatedStringToAuthorityList("system"));
        SecurityContextHolder.getContext().setAuthentication(authenticationToken);
        chain.doFilter(request, response);
    }
}
