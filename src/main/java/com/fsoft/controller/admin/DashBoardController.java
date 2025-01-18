package com.fsoft.controller.admin;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.fsoft.entity.LoggerEntity;
import com.fsoft.service.ILoggerService;

@Controller
public class DashBoardController {
	
	@Autowired
	ILoggerService loggerService;
	
	 @RequestMapping(value = "/", method = RequestMethod.GET)
	   public RedirectView firstPage() {
		 	RedirectView redirectView = new RedirectView();
	        redirectView.setUrl("admin/dashboard");
	        return redirectView;
	  }
	 
	 @PreAuthorize("hasAnyRole('ADMIN', 'MANAGER')")
	 @RequestMapping(value = "admin/dashboard", method = RequestMethod.GET)
	   public ModelAndView homePage(@ModelAttribute("message") HashMap<String, String> message) {
	      ModelAndView mav = new ModelAndView("admin/dashboard/dashboard");
	      
	      List<LoggerEntity> loggerEntities = loggerService.findAll();
	      
	      mav.addObject("message", message);
	      mav.addObject("logs", loggerEntities);
	      return mav;
	  }
}
