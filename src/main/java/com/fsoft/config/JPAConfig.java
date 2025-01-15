package com.fsoft.config;

import java.util.Properties;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.dao.annotation.PersistenceExceptionTranslationPostProcessor;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.JpaVendorAdapter;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@PropertySource(value = { "classpath:application.properties" })
@Configuration
@EnableJpaRepositories(basePackages = { "com.fsoft.repository" })
@EnableTransactionManagement /* Giúp không làm thủ công đống mở connection , rollback , close all object */
public class JPAConfig {

	@Value("${spring.datasource.driver-class-name}")
	private String driverClassName;

	@Value("${spring.datasource.url}")
	private String url;

	@Value("${spring.datasource.username}")
	private String username;

	@Value("${spring.datasource.password}")
	private String password;
	
    @Value("${spring.datasource.maximum-pool-size:10}")
    private int maxPoolSize;

    @Value("${spring.datasource.minimum-idle:5}")
    private int minIdle;

    @Value("${spring.datasource.idle-timeout:30000}")
    private long idleTimeout;

    @Value("${spring.datasource.max-lifetime:1800000}")
    private long maxLifetime;

    @Value("${spring.datasource.connection-timeout:30000}")
    private long connectionTimeout;

    @Value("${spring.datasource.pool-name:HikariCP}")
    private String poolName;

	@Bean
	public LocalContainerEntityManagerFactoryBean entityManagerFactory() { /* Hỗ trợ thực thi các câu lệnh SQL */
		LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
		em.setDataSource(dataSource());
		em.setPersistenceUnitName("persistence-data"); /* Chất xúc tác giữ enity và table */
		JpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
		em.setJpaVendorAdapter(vendorAdapter);
		em.setJpaProperties(additionalProperties());
		return em;
	}


	@Bean /* Tự động quản lý transactison */
	JpaTransactionManager transactionManager(EntityManagerFactory entityManagerFactory) {
		JpaTransactionManager transactionManager = new JpaTransactionManager();
		transactionManager.setEntityManagerFactory(entityManagerFactory);
		return transactionManager;
	}

	@Bean
	public PersistenceExceptionTranslationPostProcessor exceptionTranslation() {
		return new PersistenceExceptionTranslationPostProcessor();
	}
	
    @Bean
    public DataSource dataSource() { /* lấy mở kết nối */
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setDriverClassName(driverClassName);
        hikariConfig.setJdbcUrl(url);
        hikariConfig.setUsername(username);
        hikariConfig.setPassword(password);
        hikariConfig.setMaximumPoolSize(maxPoolSize);
        hikariConfig.setMinimumIdle(minIdle);
        hikariConfig.setIdleTimeout(idleTimeout);
        hikariConfig.setMaxLifetime(maxLifetime);
        hikariConfig.setConnectionTimeout(connectionTimeout);
        hikariConfig.setPoolName(poolName);

        return new HikariDataSource(hikariConfig);
    }

//	@Bean
//	public DataSource dataSource() { /* lấy mở kết nối */
//		DriverManagerDataSource dataSource = new DriverManagerDataSource();
//		dataSource.setDriverClassName(driverClassName);
//		dataSource.setUrl(url);
//		dataSource.setUsername(username);
//		dataSource.setPassword(password);
//		return dataSource;
//	}

	Properties additionalProperties() { /* Tự tạo table theo mô tả trong enity */
		/* dùng hibernate để ORM Object Relationship Mapping */
		Properties properties = new Properties();
	    // Cấu hình Dialect của Hibernate để phù hợp với cơ sở dữ liệu
	    properties.setProperty("hibernate.dialect", "org.hibernate.dialect.MySQLDialect");
		properties.setProperty("hibernate.show_sql", "false");
		properties.setProperty("hibernate.hbm2ddl.auto", "update");	/* Tạo database từ những enity class */
//		properties.setProperty("hibernate.hbm2ddl.auto", "none");
//		properties.setProperty("hibernate.hbm2ddl.auto", "create");
//		properties.setProperty("hibernate.hbm2ddl.auto", "create-drop");
		properties.setProperty("hibernate.enable_lazy_load_no_trans", "true");
		return properties;
	}
}
