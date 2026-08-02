package com.aska.client;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication(scanBasePackages = {"com.aska"})
@MapperScan("com.aska.*.mapper")
public class ClientApplication extends SpringBootServletInitializer {
	public static void main(String[] args) {
		SpringApplication.run(ClientApplication.class, args);
	}

}
