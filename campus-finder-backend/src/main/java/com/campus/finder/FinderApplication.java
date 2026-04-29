package com.campus.finder;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 校园失物招领平台启动类
 *
 * @author Campus Finder Team
 */
@SpringBootApplication
@MapperScan("com.campus.finder.module.*.mapper")
public class FinderApplication {

    public static void main(String[] args) {
        SpringApplication.run(FinderApplication.class, args);
    }

}
