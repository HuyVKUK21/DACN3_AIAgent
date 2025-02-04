package com.fsoft.controller.admin;

import com.fsoft.converter.LogConverter;
import com.fsoft.dto.LogDTO;
import com.fsoft.repository.LogRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class LogController {

    @Autowired
    private LogRepository logRepository;

    @GetMapping("/admin/log")
    public ModelAndView showLog() {
        ModelAndView mav = new ModelAndView("admin/log/index");

        List<LogDTO> logs = LogConverter.toDtoList(logRepository.findAll());

        mav.addObject("logs", logs);

        return mav;
    }

}
