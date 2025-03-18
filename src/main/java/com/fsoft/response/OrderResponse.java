package com.fsoft.response;

import java.math.BigDecimal;

public class OrderResponse {
	int userTableID;
	int paymentID;
	private long orderCount;
	private BigDecimal totalPrice;
	private long totalProductsSold;
	private long totalProductsSoldToday;

	public int getUserTableID() {
		return userTableID;
	}

	public void setUserTableID(int userTableID) {
		this.userTableID = userTableID;
	}

	public int getPaymentID() {
		return paymentID;
	}

	public void setPaymentID(int paymentID) {
		this.paymentID = paymentID;
	}

	public long getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(long orderCount) {
		this.orderCount = orderCount;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public long getTotalProductsSold() {
		return totalProductsSold;
	}

	public void setTotalProductsSold(long totalProductsSold) {
		this.totalProductsSold = totalProductsSold;
	}

	public long getTotalProductsSoldToday() {
		return totalProductsSoldToday;
	}

	public void setTotalProductsSoldToday(long totalProductsSoldToday) {
		this.totalProductsSoldToday = totalProductsSoldToday;
	}
	
	

}
