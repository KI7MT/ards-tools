package com.ards.adif.api.configuration;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableAutoConfiguration
@EntityScan(basePackages = {"com.ards.adif.api.model"})
@EnableJpaRepositories(basePackages = {"com.ards.adif.api.repository"})
@EnableTransactionManagement
public class RepositoryConfiguration {
	/* Nothing to see here. It just sets up the scanners for the app */	
}