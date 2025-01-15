package com.fsoft.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

@Configuration
@EnableJpaAuditing(auditorAwareRef = "auditorProvider")
public class JPAAuditingConfig {

    @Bean
    public AuditorAware<String> auditorProvider() {
        return new AuditorAwareImpl();
    }

    public static class AuditorAwareImpl implements AuditorAware<String> {

        @Override
        public String getCurrentAuditor() {
            // Kiểm tra xem request có đến từ API customer không
            RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
            if (attributes != null) {
                String requestURI = (String) attributes.getAttribute("javax.servlet.forward.request_uri", RequestAttributes.SCOPE_REQUEST);
                if (requestURI != null && (requestURI.contains("/Customer") || requestURI.contains("/api/home"))) {
                    return "Guest";
                }
            }

            // Nếu không phải request từ customer, lấy từ Security Context
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            
            if (authentication == null || !authentication.isAuthenticated() 
                || authentication instanceof AnonymousAuthenticationToken) {
                return "Guest";
            }
            
            return authentication.getName();
        }
    }
}