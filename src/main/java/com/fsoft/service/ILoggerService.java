package com.fsoft.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.fsoft.entity.LoggerEntity;

@Service
public interface ILoggerService {

	void write(String text);

	List<LoggerEntity> findAll();

}
