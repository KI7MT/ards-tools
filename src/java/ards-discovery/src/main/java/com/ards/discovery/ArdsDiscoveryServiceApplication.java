package com.ards.discovery;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.server.EnableEurekaServer;

@SpringBootApplication
@EnableEurekaServer
public class ArdsDiscoveryServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(ArdsDiscoveryServiceApplication.class, args);
	}
}
