package com.fsoft.response;

import java.math.BigDecimal;
import java.util.Date;

public class DailyRevenue {
	private Date date;
	private BigDecimal revenue;

	// Constructor
	public DailyRevenue(Date date, BigDecimal revenue) {
		this.date = date;
		this.revenue = revenue;
	}

	// Getters and setters (you probably have these already)
	// ...
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public BigDecimal getRevenue() {
		return revenue;
	}

	public void setRevenue(BigDecimal revenue) {
		this.revenue = revenue;
	}
}