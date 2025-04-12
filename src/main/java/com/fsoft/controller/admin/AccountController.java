package com.fsoft.controller.admin;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fsoft.dto.AccountDTO;
import com.fsoft.service.IAccountService;
import com.fsoft.utils.SecurityUtils;
import com.fsoft.utils.Utils;

@Controller
public class AccountController {

    private static final Logger logger = Logger.getLogger(AccountController.class);

    @Autowired
    private IAccountService iUserService;

    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/account-admin/add")
    public ModelAndView addAccountAdminPage(@ModelAttribute("accountAdmin") AccountDTO accountAdmin,
                                            @ModelAttribute("message") HashMap<String, Object> message,
                                            HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/admin/add-admin");
        String adminId = request.getParameter("admin_id");
        if (adminId != null && !adminId.isEmpty()) {
            accountAdmin = iUserService.findByID(Long.parseLong(adminId));
        }
        logger.info(accountAdmin);
        mav.addObject("message", message);
        mav.addObject("accountAdmin", accountAdmin);
        return mav;
    }

//    @PreAuthorize("hasRole('ADMIN')")
    @PostMapping("/admin/account-admin/save")
    public String saveAccountAdmin(@Valid @ModelAttribute("accountAdmin") AccountDTO accountAdmin, 
                                   BindingResult result, Model model, 
                                   HttpServletRequest request, 
                                   RedirectAttributes redirectAttributes,
                                   HttpServletResponse response) {
       
        Map<String, String> message;
        
        if (result.hasErrors()) {
        	message = Utils.messageUtils("error", "Có lỗi khi thêm dữ liệu vào");
        	model.addAttribute("message", message);
            return "admin/admin/add-admin"; 
        }

        try {
            iUserService.saveUser(accountAdmin);
            message = Utils.messageUtils("success", "Dữ liệu đã được gửi thành công!");
        } catch (Exception e) {
            logger.error("Error saving user: " + e.getMessage(), e);
            message = Utils.messageUtils("error", "Error saving user: " + e.getMessage());
        }
        redirectAttributes.addFlashAttribute("message", message);
        return "redirect:/admin/account-admin/list";
    }

//    @PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
    
    @GetMapping("/admin/testcode")
    public void test() {
    	List<AccountDTO> accountDTOs = iUserService.getListUser();
    	
    }
    
    @GetMapping("/admin/account-admin/list")
    public ModelAndView listAccountAdminPage(@ModelAttribute("message") HashMap<String, Object> message) {
    	String currentUser = SecurityUtils.getSessionUser();
    	logger.info("currentUser : " + currentUser);
    	
        ModelAndView mav = new ModelAndView("admin/admin/list-admin");
        mav.addObject("message", message);
        return mav;
    }

    @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_MANAGER')")
    @GetMapping("/admin/account-admin/load-table-admin")
    public void loadAccountAdmin(HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        response.getWriter().write(iUserService.loadTableListUser());
    }

//    @PreAuthorize("hasRole('ADMIN')")
    @GetMapping("/admin/account-admin/assign-roles")
    public void assignRolesAccountAdmin(HttpServletResponse response, HttpServletRequest request) throws IOException, RuntimeException {
        Long idUser = Long.parseLong(request.getParameter("admin_id"));
        Long idRole = Long.parseLong(request.getParameter("index_roles"));
        String statusUpdate;
        try {
            statusUpdate = iUserService.updateRoleUser(idUser, idRole);
        } catch (Exception e) {
            logger.error(e);
            statusUpdate = e.getMessage();
        }

        response.setContentType("text/plain");
        response.getWriter().write(statusUpdate);
    }

//    @PreAuthorize("hasAnyRole('ADMIN','MANAGER')")
    @GetMapping("/admin/account-admin/delete")
    public void deleteAccountAdmin(HttpServletResponse response, HttpServletRequest request) throws IOException {
        Long id = Long.parseLong(request.getParameter("admin_id"));
        response.setContentType("text/plain");
        try {
            response.getWriter().write(iUserService.deleteAdmin(id));
        } catch (Exception e) {
            logger.error(e);
            response.getWriter().write(e.getMessage());
        }
    }
}
