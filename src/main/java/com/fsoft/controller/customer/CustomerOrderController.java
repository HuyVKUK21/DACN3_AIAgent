package com.fsoft.controller.customer;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fsoft.api.user.HomeAPI;
import com.fsoft.dto.OrderStatusDTO;
import com.fsoft.response.OrderResponse;

@Controller
public class CustomerOrderController {

    @Autowired
    private HomeAPI homeAPI;

    @GetMapping("/Customer/Order")
    public ModelAndView index(
            @RequestParam(name = "idTable", required = false) Integer idTable,
            @RequestParam(name = "paymentSuccess", required = false) Boolean paymentSuccess,
            HttpServletRequest request
    ) {
        ModelAndView mav = new ModelAndView("customer/order/index");

        // Lấy flash attribute message nếu có
        Object flashMessage = request.getSession().getAttribute("FLASH_MESSAGE");
        if (flashMessage != null) {
            mav.addObject("message", flashMessage.toString());
            request.getSession().removeAttribute("FLASH_MESSAGE");
        }

        // Nếu thanh toán thành công, gửi thông báo cho nhân viên
        if (Boolean.TRUE.equals(paymentSuccess)) {
            OrderResponse orderResponse = new OrderResponse();
            orderResponse.setUserTableID(idTable);
            homeAPI.completeGuestOrder(orderResponse);
        }

        mav.addObject("paymentSuccess", paymentSuccess);
        mav.addObject("idTable", idTable);
        return mav;
    }
} 