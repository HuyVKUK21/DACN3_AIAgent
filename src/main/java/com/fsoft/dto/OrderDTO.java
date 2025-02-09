package com.fsoft.dto;

import java.math.BigDecimal;

public class OrderDTO extends BaseDTO<OrderDTO> {
    private int orderId;
    private TableUserDTO tableUser;
    private PaymentDTO payment;
    private int orderStatus;
    private String orderCode;
    private BigDecimal totalPrice;
    private int totalQuantity;
    
    public OrderDTO() {}

  
    

	public PaymentDTO getPayment() {
		return payment;
	}




	public void setPayment(PaymentDTO payment) {
		this.payment = payment;
	}




	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}




	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public TableUserDTO getTableUser() {
		return tableUser;
	}

	public void setTableUser(TableUserDTO tableUser) {
		this.tableUser = tableUser;
	}


	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}


	public BigDecimal getTotalPrice() {
		return totalPrice;
	}




	public int getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}

    
}
