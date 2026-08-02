package com.aska.client.config.web.interceptor.annotation;

import com.aska.client.config.annotation.Login;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.JwtUtil;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Objects;

public class AnnotationInterceptor implements HandlerInterceptor {

//    public static final String RESPONSE_RESULT_ANN = "RESPONSE_RESULT_ANN";

    @Autowired
    ObjectMapper objectMapper;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(handler instanceof HandlerMethod){
            final HandlerMethod handlerMethod = (HandlerMethod) handler;
//            final  Class<?> clazz = handlerMethod.getBeanType();
//            final Method method = handlerMethod.getMethod();
            /**
             * login 注解获取当前id
             */
            Login methodAnnotation = ((HandlerMethod) handler).getMethodAnnotation(Login.class);
            if(Objects.nonNull(methodAnnotation)){
                String token = request.getHeader(JwtUtil.HEADER_STRING);
                if(token!=null){
                    return true;
                }
                response(request,response);
                return false;
            }
        }

        return true;
    }

    /**
     * 返回错误信息
     */
    private void response(HttpServletRequest request, HttpServletResponse response) {
        response.setCharacterEncoding("UTF-8");
        response.setContentType(MediaType.APPLICATION_JSON_VALUE);
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Cache-Control", "no-store");
        response.setHeader("Access-Control-Allow-Origin", "*");
        try (PrintWriter out = response.getWriter()) {
            out.write(objectMapper.writeValueAsString(new CustomException(ResultCode.PARAM_IS_INVALID)));
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
