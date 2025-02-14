package com.fsoft.controller.admin;

import com.fsoft.dto.AccountDTO;
import com.fsoft.service.IAccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ScheduleController {

    @Autowired
    private IAccountService accountService;

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @GetMapping("/admin/schedule")
    public ModelAndView index() {
        ModelAndView mav = new ModelAndView("admin/schedule/index");

        AccountDTO account = new AccountDTO();
        account.setListResult(accountService.findAllByRoleEmployee());

        mav.addObject("employee", account);
        return mav;
    }
}
