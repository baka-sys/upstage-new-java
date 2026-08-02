package com.aska.upstage.config.security;

import com.alibaba.fastjson.JSON;
import com.aska.common.model.ResponseData;
import com.aska.common.model.ResultCode;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.charset.StandardCharsets;


/**
 * token认证处理失败类
 */
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        httpServletResponse.setCharacterEncoding("UTF-8");
        httpServletResponse.setContentType("application/json; charset=utf-8");
        ServletOutputStream out = httpServletResponse.getOutputStream();
        ResponseData responseData = ResponseData.error(ResultCode.AUTH_ERROR.message());
        out.write(JSON.toJSONString(responseData).getBytes(StandardCharsets.UTF_8));
        out.flush();
        out.close();
    }
}
