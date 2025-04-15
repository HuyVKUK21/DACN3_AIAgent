package com.fsoft.controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EScheduleController {

    @GetMapping("/user/schedule")
    public ModelAndView schedule() {
        ModelAndView mav = new ModelAndView("user/schedule/index");


        return mav;
    }
}
