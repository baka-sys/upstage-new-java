package com.aska.upstage.config.security;

import com.alibaba.fastjson.JSON;
import com.aska.common.model.ResponseData;
import com.aska.common.model.ResultCode;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {

    @Override
    public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException {
        httpServletResponse.setContentType("application/json;charset=UTF-8");
        httpServletResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        ServletOutputStream out = httpServletResponse.getOutputStream();
        out.write(JSON.toJSONBytes(ResponseData.error(ResultCode.ACCESS_NO_PERMISSION.message())));
        out.flush();
        out.close();
    }
}
