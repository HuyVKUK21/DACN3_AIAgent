package com.fsoft.service.impl;


import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.fsoft.dto.AccountDTO;
import com.fsoft.security.JWTGenerator;
import com.fsoft.service.IAuthService;

@Service
public class AuthService implements IAuthService{
	private static Logger logger = Logger.getLogger(AuthService.class);
	
    private  PasswordEncoder passwordEncoder;
    private  AuthenticationManager authenticationManager;
    private  JWTGenerator jwtGenerator;
    
    @Autowired
	public AuthService(PasswordEncoder passwordEncoder, AuthenticationManager authenticationManager,
			JWTGenerator jwtGenerator) {
		super();
		this.passwordEncoder = passwordEncoder;
		this.authenticationManager = authenticationManager;
		this.jwtGenerator = jwtGenerator;
	}

	@Override
	public void login(AccountDTO adminDTO) {
		// TODO Auto-generated method stub
	    try {
	    	  Authentication authentication = authenticationManager.authenticate(
	                  new UsernamePasswordAuthenticationToken(
	                		  adminDTO.getUsername(),
	                		  adminDTO.getPassword()));
	        SecurityContextHolder.getContext().setAuthentication(authentication);
	        String token = jwtGenerator.generateToken(authentication);
	        System.out.println("Authentication successful for user: " + adminDTO.getUsername());
	        logger.info(token);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        // Log or handle the exception
	    }
		
	}
    
    
}
