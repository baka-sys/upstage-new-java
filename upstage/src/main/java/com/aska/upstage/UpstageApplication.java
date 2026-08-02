package com.aska.upstage;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication(scanBasePackages = {"com.aska"})
@MapperScan("com.aska.*.mapper")
@EnableScheduling
public class UpstageApplication extends SpringBootServletInitializer {

    public static void main(String[] args) {
        SpringApplication.run(UpstageApplication.class, args);
    }

}
