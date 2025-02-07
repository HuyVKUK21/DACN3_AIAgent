
package com.fsoft.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;

@Entity
@Table(name = "tbl_order")
public class OrderEntity extends BaseEnity{
	
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column (name= "order_id", columnDefinition = "int(10)")
    private int orderId;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "table_user_id")
    private TableUserEntity tableUser;
	
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "payment_id")
    private PaymentEntity payment;


	@Column (name= "order_status", columnDefinition = "int(10)")
    private int orderStatus;

	@Column (name= "order_code", columnDefinition = "varchar(256)")
    private String orderCode;

	@Column (name= "total_price", columnDefinition = "decimal(10,0)")
    private BigDecimal totalPrice;

	@Column (name= "total_quantity", columnDefinition = "int(10)")
    private int totalQuantity;

	
	@OneToMany(mappedBy = "order")
	@JsonIgnore
	private List<OrderDetailseEntity> orderDetailseEntities = new ArrayList<>();
	
	public OrderEntity() {}

	
	


	public int getOrderId() {
		return orderId;
	}

	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}

	public TableUserEntity getTableUser() {
		return tableUser;
	}

	public void setTableUser(TableUserEntity tableUser) {
		this.tableUser = tableUser;
	}

	


	public PaymentEntity getPayment() {
		return payment;
	}





	public void setPayment(PaymentEntity payment) {
		this.payment = payment;
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





	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}





	public int getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
		
}
