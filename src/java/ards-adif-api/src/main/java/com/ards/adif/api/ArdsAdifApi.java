package com.ards.adif.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@EnableEurekaClient
@RestController
public class ArdsAdifApi {

	@RequestMapping(value = "/")
	public String home() {
		return "Welcome to the Amateur Radio Data Service API via Eureka";
	}
	
	public static void main(String[] args) {
		SpringApplication.run(ArdsAdifApi.class, args);
	}
}
