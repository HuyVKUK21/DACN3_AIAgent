package com.fsoft.api.admin;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fsoft.response.DailyRevenue;
import com.fsoft.response.OrderResponse;
import com.fsoft.response.RevenueStatistics;
import com.fsoft.service.IOrderService;

@RestController
@RequestMapping("/api/orders")
public class OrderAPI {
	
	 @Autowired
	    private IOrderService orderService;
	 
	 @GetMapping("/statistics-today")
	    public ResponseEntity<OrderResponse> getOrdersCompletedTodayStatistics() {
	        OrderResponse statistics = orderService.getOrdersCompletedTodayStatistics();
	     // Kiểm tra và gán giá trị mặc định cho totalPrice
	        BigDecimal totalPrice = statistics.getTotalPrice();
	        if (totalPrice == null) {
	            totalPrice = BigDecimal.ZERO;
	        }
	        statistics.setTotalPrice(totalPrice);
	        return ResponseEntity.ok(statistics);
	    }
	 
	 @GetMapping("/product-sales-statistics")
	 public ResponseEntity<OrderResponse> getProductSalesStatistics() {
	     OrderResponse statistics = orderService.getProductSalesStatistics();
	     
	     if (statistics == null) {
	         // Tạo đối tượng OrderResponse với giá trị mặc định
	         statistics = new OrderResponse();
	         statistics.setTotalProductsSold(0);
	         statistics.setTotalProductsSoldToday(0); // Hoặc các giá trị mặc định khác
	     }
	     
	     return ResponseEntity.ok(statistics);
	 }
	 
	 @GetMapping("/daily-revenue")
		public ResponseEntity<List<DailyRevenue>> getDailyRevenue() {
			List<DailyRevenue> dailyRevenue = orderService.getDailyRevenue(); // Trả về List<DailyRevenue>
			return ResponseEntity.ok(dailyRevenue);
		}

		@GetMapping("/daily-revenue/last-7-days")
		public ResponseEntity<List<DailyRevenue>> getDailyRevenueLast7Days() {
			List<DailyRevenue> dailyRevenue = orderService.getDailyRevenueLast7Days();
			return ResponseEntity.ok(dailyRevenue);
		}

		@GetMapping("/daily-revenue/last-30-days")
		public ResponseEntity<List<DailyRevenue>> getDailyRevenueLast30Days() {
			List<DailyRevenue> dailyRevenue = orderService.getDailyRevenueLast30Days();
			return ResponseEntity.ok(dailyRevenue);
		}
		
		@GetMapping("/revenue-statistics")
	    public ResponseEntity<RevenueStatistics> getRevenueStatistics() {
	        RevenueStatistics statistics = orderService.getRevenueStatistics();
	        return ResponseEntity.ok(statistics);
	    }


}
