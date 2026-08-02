package com.aska.upstage.config.web;

import com.aska.upstage.config.web.interceptor.annotation.AnnotationInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.util.List;

@Configuration
public class WebAppConfigure implements WebMvcConfigurer {

    @Autowired
    TokenMethodArgumentResolver tokenMethodArgumentResolver;

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {

        argumentResolvers.add(tokenMethodArgumentResolver);
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry){
        AnnotationInterceptor interceptor = new AnnotationInterceptor();
        registry.addInterceptor(interceptor);
        WebMvcConfigurer.super.addInterceptors(registry);
    }

//    @Override
//    public void addResourceHandlers(ResourceHandlerRegistry registry) {
//        registry.addResourceHandler("/uploads/**")
//                .addResourceLocations("file:/// "+ FileUtils.UPLOADS_PATH);
//    }
}
