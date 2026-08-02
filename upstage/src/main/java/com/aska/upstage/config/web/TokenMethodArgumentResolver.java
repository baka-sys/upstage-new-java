package com.aska.upstage.config.web;

import cn.hutool.core.map.MapUtil;
import com.alibaba.fastjson.JSON;
import com.aska.upstage.config.annotation.Login;
import com.aska.common.model.ResultCode;
import com.aska.common.model.exception.CustomException;
import com.aska.common.util.JwtUtil;
import org.springframework.core.MethodParameter;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import java.util.Map;

/**
 * create by: songyu
 * description: 解析token，注入userId
 * create time: 2021/2/24 21:33
 */
@Component
public class TokenMethodArgumentResolver implements HandlerMethodArgumentResolver {

    @Override
    public boolean supportsParameter(MethodParameter methodParameter) {
        return methodParameter.getParameterType().isAssignableFrom(Long.class) && methodParameter.hasParameterAnnotation(Login.class);
    }

    @Override
    public Object resolveArgument(MethodParameter methodParameter, ModelAndViewContainer modelAndViewContainer, NativeWebRequest nativeWebRequest, WebDataBinderFactory webDataBinderFactory) throws Exception {
        String tokenHeader = nativeWebRequest.getHeader(JwtUtil.HEADER_STRING);
        //获取token值
        String token = JwtUtil.validateToken(tokenHeader);
        if (token != null) {
            Map map = JSON.parseObject(token, Map.class);
            String userId = MapUtil.get(map, "id", String.class);
            return Long.valueOf(userId);
        }
		throw new CustomException(ResultCode.PARAM_IS_INVALID.code(),"请携带header:token");
    }
}
