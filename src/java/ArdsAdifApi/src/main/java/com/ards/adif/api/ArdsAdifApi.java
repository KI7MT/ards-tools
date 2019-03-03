package com.ards.adif.api;

import org.apache.catalina.servlets.WebdavServlet;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class ArdsAdifApi {

	public static void main(String[] args) {
		SpringApplication.run(ArdsAdifApi.class, args);
	}
	
	@Bean
	public ServletRegistrationBean h2servletRegistration() {
	    ServletRegistrationBean registration = new ServletRegistrationBean(new WebdavServlet());
	    registration.addUrlMappings("/console/*");
	    return registration;
	}

}
