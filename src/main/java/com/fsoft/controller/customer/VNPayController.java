package com.fsoft.controller.customer;

import com.fsoft.dto.VnPayRequestDTO;
import com.fsoft.service.IVNPayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.Map;

@Controller
public class VNPayController {

    @Autowired
    private IVNPayService vnPayService;

    // Khi user click chọn thanh toán => redirect sang VNPay
    @GetMapping("/vnpay/payment")
    public String vnpayRedirect(@RequestParam("amount") long amount,
                                 @RequestParam("orderInfo") String orderInfo,
                                 @RequestParam("idTable") Long idTable,
                                 HttpServletRequest request) throws Exception {
        String ipAddress = request.getRemoteAddr();
        String paymentUrl = vnPayService.createPaymentUrl(amount, orderInfo, ipAddress);
        return "redirect:" + paymentUrl;
    }

    // Gọi từ Ajax (nếu dùng POST để lấy URL và xử lý redirect client-side)
    @PostMapping("/vnpay/create-url")
    @ResponseBody
    public String createVnpayUrl(@RequestBody VnPayRequestDTO request, HttpServletRequest servletRequest) throws Exception {
        String ip = servletRequest.getRemoteAddr();
        return vnPayService.createPaymentUrl(request.getAmount(), request.getOrderInfo(), ip);
    }

    @GetMapping("/vnpay/return")
    public String handleVNPayReturn(HttpServletRequest request, RedirectAttributes redirectAttributes) {
        Map<String, String[]> parameterMap = request.getParameterMap();
        Map<String, String> vnpParams = new HashMap<>();

        for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
            vnpParams.put(entry.getKey(), entry.getValue()[0]);
        }

        String responseCode = vnpParams.get("vnp_ResponseCode");
        String transactionStatus = vnpParams.get("vnp_TransactionStatus");
        String orderInfo = vnpParams.get("vnp_OrderInfo");
        Long idTable = extractIdTableFromOrderInfo(orderInfo);

        // Lưu thông tin thanh toán vào session
        request.getSession().setAttribute("vnpay_response_code", responseCode);
        request.getSession().setAttribute("vnpay_transaction_status", transactionStatus);
        
        if ("00".equals(responseCode)) {
            request.getSession().setAttribute("FLASH_MESSAGE", "✅ Đã thanh toán bàn " + idTable);
            return "redirect:/Customer/Order?idTable=" + idTable + "&paymentSuccess=true";
        } else {
            request.getSession().setAttribute("FLASH_MESSAGE", "❌ Thanh toán thất bại! Mã lỗi: " + responseCode);
            return "redirect:/Customer/Order?idTable=" + idTable + "&paymentSuccess=false";
        }
    }


    // Hàm tách số bàn từ orderInfo
    private Long extractIdTableFromOrderInfo(String orderInfo) {
        // "Thanh toan hoa don ban 6" => lấy số 6
        String[] parts = orderInfo.split(" ");
        try {
            return Long.parseLong(parts[parts.length - 1]);
        } catch (NumberFormatException e) {
            return 0L;
        }
    }


}
