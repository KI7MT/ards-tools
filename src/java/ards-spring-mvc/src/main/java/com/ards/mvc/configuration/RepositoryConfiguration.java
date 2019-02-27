package com.ards.mvc.configuration;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/*
 * 
 * @Configuraiton              : Informs Spring this is a Java configuration class
 * @EnableAutoConfiguration    : Tell Spring to AutoConfigure
 * @EntityScan                 : Tells Spring to scan the models package
 * @EnableJpaRepositories      : Enables Spring Data JPA
 * EnableTransactionManagement : Enable Spring annotation-driven transaction management 
 * 
 */

@Configuration
@EnableAutoConfiguration
@EntityScan(basePackages = {"com.ards.mvc.models"})
@EnableJpaRepositories(basePackages = {"com.ards.mvc.repositories"})
@EnableTransactionManagement
public class RepositoryConfiguration {

}