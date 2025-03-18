package com.fsoft.api.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fsoft.response.TableOrderResponse;
import com.fsoft.service.ITableOrderService;

@RestController
@RequestMapping("/api/table-orders")
public class TableOrderAPI {
	
	@Autowired
	private ITableOrderService tableOrderService;

	@GetMapping("/totalQuantity")
	public ResponseEntity<TableOrderResponse> getTotalQuantity() {
	    Integer totalQuantity = tableOrderService.getTotalQuantity();

	    // Kiểm tra null và trả về 0 nếu cần
	    int quantity = totalQuantity != null ? totalQuantity : 0; 

	    // Sử dụng TableOrderResponse để trả về dữ liệu
	    TableOrderResponse response = new TableOrderResponse();
	    response.setTotalOrderQuantity(quantity);

	    return new ResponseEntity<>(response, HttpStatus.OK);
	}

}
