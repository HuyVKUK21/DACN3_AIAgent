package com.fsoft.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.fsoft.dto.OrderDTO;
import com.fsoft.dto.OrderDetailsDTO;
import com.fsoft.dto.TableOrderDTO;
import com.fsoft.response.CheckOrderResponse;
import com.fsoft.response.DailyRevenue;
import com.fsoft.response.OrderResponse;
import com.fsoft.response.RevenueStatistics;

@Service
public interface IOrderService {

	void putOrder(OrderResponse orderResponse);

	Integer getTotalItem();

	List<OrderDTO> findAll(Pageable pageable);

	CheckOrderResponse checkOrder(int userTableID);
	
	OrderResponse getOrdersCompletedTodayStatistics();
	
	OrderResponse getProductSalesStatistics();

	List<OrderDTO> search(Pageable pageable, String search);

	OrderDTO findByID(Integer id);

	byte[] generateInvoicePdf(Integer id); 
	
	RevenueStatistics getRevenueStatistics();

	List<DailyRevenue> getDailyRevenue();

	List<DailyRevenue> getDailyRevenueLast7Days();

	List<DailyRevenue> getDailyRevenueLast30Days();

	void saveToDatabase(List<TableOrderDTO> tempOrders, OrderResponse orderResponse);
	
	 String getOrderCreator(int tableId);
	 
	 void processNewOrder(String tableId);
}
