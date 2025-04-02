package com.fsoft.response;

import java.math.BigDecimal;
import java.util.Date;

public class RevenueStatistics {
    private Date create_date;
    private BigDecimal total_price;
    private Double growthRate; // Tỉ lệ tăng trưởng doanh thu
    
	public RevenueStatistics(Date create_date, BigDecimal total_price, Double growthRate) {
		super();
		this.create_date = create_date;
		this.total_price = total_price;
		this.growthRate = growthRate;
	}
	
	 // Constructor
    public RevenueStatistics(Date create_date, BigDecimal total_price) {
        this.create_date = create_date;
        this.total_price = total_price;
    }


	public RevenueStatistics() {
		super();
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public BigDecimal getTotal_price() {
		return total_price;
	}

	public void setTotal_price(BigDecimal total_price) {
		this.total_price = total_price;
	}

	public Double getGrowthRate() {
		return growthRate;
	}

	public void setGrowthRate(Double growthRate) {
		this.growthRate = growthRate;
	}
}