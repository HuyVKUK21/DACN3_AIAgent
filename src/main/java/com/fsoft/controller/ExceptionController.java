package com.fsoft.controller;

import java.io.IOException;
import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import com.fsoft.dto.AccountDTO;
import com.fsoft.service.IAccountService;
import com.fsoft.utils.SecurityUtils;

@ControllerAdvice
public class ExceptionController {

    @Autowired
    IAccountService iAccountService;

    private static Logger logger = Logger.getLogger(ExceptionController.class);

    @ModelAttribute("currentAccount")
    public AccountDTO getCurrentAccount() {
        return iAccountService.findByUserNameDTO(SecurityUtils.getSessionUser());
    }

    @ExceptionHandler(value = {NoHandlerFoundException.class})
    @ResponseStatus(code = HttpStatus.NOT_FOUND)
    public ModelAndView
    exception404Handler(Exception exception, HttpServletResponse response
            , HttpServletRequest request) throws IOException {
        ModelAndView mav = new
                ModelAndView("/error/404");
        return mav;
    }

    @ExceptionHandler(value = {Exception.class})
    public ModelAndView
    allExceptionHandler(Exception exception, HttpServletResponse
            response, HttpServletRequest request) throws IOException {
        ModelAndView mav =
                new ModelAndView("/error/505"); // Add error details to the model
        mav.addObject("exception", exception.getClass().getName());
        mav.addObject("message", exception.getMessage());
        mav.addObject("method",
                request.getMethod());
        mav.addObject("url",
                request.getRequestURL().toString());
        mav.addObject("timestamp",
                LocalDateTime.now().toString());
        return mav;
    }

}
