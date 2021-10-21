package com.uzykj.mall;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Springboot 启动器
 * @date  2021-10-12
 * @author gostxbh
 */
@Slf4j
@SpringBootApplication
@EnableScheduling
@MapperScan("com.uzykj.mall.dao")
public class MallApplication {
    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(MallApplication.class, args);
        String serverPort = context.getEnvironment().getProperty("server.port");
        log.info("This project is started! http://localhost:" + serverPort);
    }
}