package com.fsoft.controller.customer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.*;

import com.fsoft.dto.OrderStatusDTO;
import com.fsoft.dto.ResponseDTO;

@RestController
@RequestMapping("/api/customer")
public class OrderStatusController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @PostMapping("/new-order")
    public ResponseDTO newOrder(@RequestBody OrderStatusDTO orderStatus) {
        try {
            // Gửi thông báo đến tất cả nhân viên về đơn hàng mới
            OrderStatusDTO notification = new OrderStatusDTO();
            notification.setType("NEW_ORDER");
            notification.setTableId(orderStatus.getTableId());
            notification.setMessage("Có đơn đặt hàng mới từ bàn " + orderStatus.getTableId());
            notification.setIsPaid(orderStatus.getIsPaid());
            
            messagingTemplate.convertAndSend("/topic/order-status", notification);
            
            return new ResponseDTO(200, "Đã gửi đơn hàng thành công", null);
        } catch (Exception e) {
            return new ResponseDTO(500, "Lỗi khi gửi đơn hàng: " + e.getMessage(), null);
        }
    }

    @PostMapping("/complete-order")
    public ResponseDTO completeOrder(@RequestBody OrderStatusDTO orderStatus) {
        try {
            // Gửi thông báo đến khách hàng về việc hoàn thành đơn
            OrderStatusDTO notification = new OrderStatusDTO();
            notification.setType("COMPLETED_ORDER");
            notification.setTableId(orderStatus.getTableId());
            notification.setMessage("Đơn hàng của bạn đã hoàn thành");
            
            messagingTemplate.convertAndSend("/topic/order-status", notification);
            
            return new ResponseDTO(200, "Đã hoàn thành đơn hàng", null);
        } catch (Exception e) {
            return new ResponseDTO(500, "Lỗi khi hoàn thành đơn hàng: " + e.getMessage(), null);
        }
    }
} 