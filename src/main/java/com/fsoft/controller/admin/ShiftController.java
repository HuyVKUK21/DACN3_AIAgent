package com.fsoft.controller.admin;

import com.fsoft.converter.ShiftConverter;
import com.fsoft.dto.ShiftDTO;
import com.fsoft.enums.ShiftType;
import com.fsoft.service.IShiftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ShiftController {

    @Autowired
    private IShiftService shiftService;

    @GetMapping("/admin/shift")
    public ModelAndView shift() {
        ModelAndView mav = new ModelAndView("admin/shift/index");

        ShiftDTO shift_morning = ShiftConverter.toDTO(shiftService.findByShiftType(String.valueOf(ShiftType.MORNING)));
        ShiftDTO shift_afternoon = ShiftConverter.toDTO(shiftService.findByShiftType(String.valueOf(ShiftType.AFTERNOON)));
        ShiftDTO shift_evening = ShiftConverter.toDTO(shiftService.findByShiftType(String.valueOf(ShiftType.EVENING)));

        mav.addObject("shift_morning", shift_morning);
        mav.addObject("shift_afternoon", shift_afternoon);
        mav.addObject("shift_evening", shift_evening);
        return mav;
    }

    @PostMapping("/admin/shift/save")
    public ModelAndView save(@ModelAttribute("shift_morning") ShiftDTO shift_morning,
                             @ModelAttribute("shift_afternoon") ShiftDTO shift_afternoon,
                             @ModelAttribute("shift_evening") ShiftDTO shift_evening)
    {
        if (shift_morning != null) {
            shiftService.save(ShiftConverter.toEntity(shift_morning));
        }
        if (shift_afternoon != null) {
            shiftService.save(ShiftConverter.toEntity(shift_afternoon));
        }
        if (shift_evening != null) {
            shiftService.save(ShiftConverter.toEntity(shift_evening));
        }

        return new ModelAndView("redirect:/admin/shift");
    }
}
