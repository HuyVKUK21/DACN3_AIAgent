package com.fsoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fsoft.entity.LoggerEntity;
import com.fsoft.repository.LoggerRepository;
import com.fsoft.service.ILoggerService;

@Service
public class LoggerService implements ILoggerService{
	@Autowired
	private LoggerRepository loggerRepository;

	@Override
	public void write(String text) {
		// TODO Auto-generated method stub
		LoggerEntity loggerEntity = new LoggerEntity();
		loggerEntity.setAction(text);
		loggerRepository.save(loggerEntity);
	}

	@Override
	public List<LoggerEntity> findAll() {
		// TODO Auto-generated method stub
		return loggerRepository.findAll();
	}
	
}
