package com.aska.upstage.config.security;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.session.HttpSessionEventPublisher;


@Slf4j
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;

    @Autowired
    JwtAccessDeniedHandler jwtAccessDeniedHandler;

    //数据库获取用户信息
    @Autowired
    CustomerUserDetailService userDetaislService;

    /**
     * bea注入密码
     *
     * @return
     */

    @Bean
    JWTAhenticationFilter jwtAhenticationFilter() throws Exception {
        return new JWTAhenticationFilter(authenticationManager());
    }

    @Bean
    HttpSessionEventPublisher httpSessionEventPublisher() {
        return new HttpSessionEventPublisher();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    private static final String[] URL_WHITELIST = {
            "/account/login",
            "/account/register",
            "/druid/**",
            "/favicon.ico",
            "/doc.html",
            "/v2/**",
            "/api/**",
            "/webjars/**",
            "/swagger-resources/**",
            "/swagger-resources",
            "/noInterception/**",
            "/productSpecs/export",
            "/admin/login",
            "/task/test",
            "/code/getUrl",
            "/code/checkUrl",
            "/code/getData",
            "/telegramChat/send",
            "/telegram/webhook"
    };

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        //允许跨域
        http.cors().and().csrf().disable()
                .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                //配置拦截规则
                .authorizeRequests()
                .antMatchers(URL_WHITELIST).permitAll()
                .anyRequest()
                .authenticated()
                //token过滤器
                .and()
                .addFilter(jwtAhenticationFilter())
                //配置异常处理器
                .exceptionHandling()
                .authenticationEntryPoint(jwtAuthenticationEntryPoint)
                .accessDeniedHandler(jwtAccessDeniedHandler);
    }

    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetaislService);
    }
}
