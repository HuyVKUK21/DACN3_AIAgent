package com.fsoft.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import com.fsoft.config.SpringContext;
import com.fsoft.service.impl.LoggerService;

@Component
public class Log {

    private static Log instance;
    
    @Autowired
    private LoggerService iLoggerService;
    

    private Log() {
    }

    public static Log getInstance() {
        if (instance == null) {
            instance = SpringContext.getBean(Log.class);
        }
        return instance;
    }
    
    public static void writeLog(String text) {
        getInstance().write(text);
    }
    
    private void write(String text) {
        iLoggerService.write(text);
    }
}