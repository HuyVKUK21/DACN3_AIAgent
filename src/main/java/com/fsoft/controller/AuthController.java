package com.fsoft.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import com.fsoft.dto.AccountDTO;
import com.fsoft.service.IAccountService;
import com.fsoft.service.IAuthService;
import com.fsoft.utils.Log;
import com.fsoft.utils.SecurityUtils;
import com.fsoft.utils.Utils;

@Controller
public class AuthController {
	
	private static Logger logger = Logger.getLogger(AuthController.class);

	@Autowired
	IAccountService iAccountService;
	
	@Autowired
	IAuthService iAuthService;

	@RequestMapping(value = "auth/login", method = RequestMethod.GET)
	public ModelAndView homePage(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("/auth/login");
		Map<String, Object> message = new HashMap<>();
		
		if (request.getParameter("logout") != null && request.getParameter("logout").equals("true")) {
			message.put("message", "Đăng xuất thành công !");
			message.put("type", "success");
		}
		
		if (request.getParameter("error") != null && request.getParameter("error").equals("true")) {
			message.put("message", "Tài khoản mật khẩu không đúng !");
			message.put("type", "warning");
		}
		
		if (request.getParameter("timeout") != null && request.getParameter("timeout").equals("true")) {
			message.put("message", "Phiên đăng nhập đã hết hạn !");
			message.put("type", "warning");
		}

		mav.addObject("message", message);
		
		logger.info(message);
		return mav;
	}
	
	
	@RequestMapping(value = "/auth/redirect", method = RequestMethod.GET)
	public String handleRole(HttpServletRequest request,  RedirectAttributes redirectAttributes) {
		String userName = SecurityUtils.getSessionUser();
		AccountDTO accountDTO = iAccountService.findByUserNameDTO(userName);
		Map<String, String> message;
		  
		if (accountDTO == null) {
			message = Utils.messageUtils("info", "Đã Xảy Ra Lỗi Trong Quá Trình Đăng Nhập");
			redirectAttributes.addFlashAttribute("message", message);
		    return "redirect:/auth/login";
		}
		
		if (accountDTO.getRoles() == null) {
			message = Utils.messageUtils("warning", "Tài Khoản Này Chưa Được Phân Quyền!");
			redirectAttributes.addFlashAttribute("message", message);
		    return "redirect:/auth/login";
		}
		
		if (accountDTO.getRoles() != null && accountDTO.getRoles().get(0).getName().equals("ROLE_EMPLOYEE") ) {
			Log.writeLog("Đăng nhập vào trang Home !");
			message = Utils.messageUtils("success", "Xin Chào "+accountDTO.getFullname()+" !");
			redirectAttributes.addFlashAttribute("message", message);
		    return "redirect:/user/home";
		}else {
			Log.writeLog("Đăng nhập vào trang Admin !");
			message = Utils.messageUtils("success", "Xin Chào "+accountDTO.getFullname()+" !");
			redirectAttributes.addFlashAttribute("message", message);
		    return "redirect:/admin/dashboard";
		}
		
	}
	
	

}
