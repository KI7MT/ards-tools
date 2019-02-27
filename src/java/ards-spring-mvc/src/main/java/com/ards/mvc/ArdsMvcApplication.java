package com.ards.mvc;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan
@EnableAutoConfiguration
@SpringBootApplication
public class ArdsMvcApplication {

	public static void main(String[] args) {
		SpringApplication.run(ArdsMvcApplication.class, args);
	}
}
