package com.fsoft.response;

import java.math.BigDecimal;
import java.util.List;

import com.fsoft.dto.TableOrderDTO;
import com.fsoft.entity.TableOrderEntity;

public class CheckOrderResponse {
	private int totalQuantity;
	private BigDecimal totalProductPrice;
	private List<TableOrderDTO> tableOrder;
	
	
	public int getTotalQuantity() {
		return totalQuantity;
	}
	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	public BigDecimal getTotalProductPrice() {
		return totalProductPrice;
	}
	public void setTotalProductPrice(BigDecimal totalProductPrice) {
		this.totalProductPrice = totalProductPrice;
	}
	public List<TableOrderDTO> getTableOrder() {
		return tableOrder;
	}
	public void setTableOrder(List<TableOrderDTO> tableOrder) {
		this.tableOrder = tableOrder;
	}

	

	
	
	
}
