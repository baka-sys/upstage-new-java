package com.aska.upstage.config.druid;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;
import java.sql.SQLException;

@Configuration
public class MyDataSourceConfig {
    @Bean
    @ConfigurationProperties("spring.datasource")
    public DataSource dataSource(){
        DruidDataSource druidDataSource = new DruidDataSource();
        // 加入监控功能 —— setFilters("stat");
        try {
            druidDataSource.setFilters("stat");
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return new DruidDataSource();
    }

    // 配置 druid 监控页功能 —— 在容器中放一 Servlet
    @Bean
    public ServletRegistrationBean statViewServlet(){
        StatViewServlet statViewServlet = new StatViewServlet();
        ServletRegistrationBean<StatViewServlet> registrationBean = new ServletRegistrationBean<StatViewServlet>(statViewServlet, "/druid/*");
        return registrationBean;
    }
}

