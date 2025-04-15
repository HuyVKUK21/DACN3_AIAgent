package com.fsoft.controller.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.fsoft.dto.OrderStatusDTO;
import java.util.HashMap;

@Controller
public class EOrderController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @GetMapping("/user/order")
    public ModelAndView index(@ModelAttribute("message") HashMap<String, String> message) {
        ModelAndView mav = new ModelAndView("user/order/index");
        mav.addObject("message", message);
        return mav;
    }

    @MessageMapping("/order-status")
    @SendTo("/topic/order-status")
    public OrderStatusDTO handleOrderStatus(OrderStatusDTO orderStatus) {
        return orderStatus;
    }

    // Phương thức gửi thông báo đơn hàng mới
    public void sendNewOrderNotification(String tableId, String message) {
        OrderStatusDTO notification = new OrderStatusDTO();
        notification.setType("NEW_ORDER");
        notification.setTableId(tableId);
        notification.setMessage(message);
        
        messagingTemplate.convertAndSend("/topic/order-status", notification);
    }
} 