package com.fsoft.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.MappedSuperclass;
import java.util.Date;

@Entity
@Table(name = "tbl_table_order")
public class TableOrderEntity extends BaseEnity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "table_order_id", columnDefinition = "int(11)")
    private int tableOrderId;

    @Column(name = "table_order_quantity", columnDefinition = "int(10)")
    private int orderQuantity;

	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "table_user_id")
    private TableUserEntity tableUser;
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    private ProductEntity product;

	public TableOrderEntity() {}

	public TableOrderEntity(int tableOrderId, int orderQuantity, TableUserEntity tableUser, ProductEntity product) {
		super();
		this.tableOrderId = tableOrderId;
		this.orderQuantity = orderQuantity;
		this.tableUser = tableUser;
		this.product = product;
	}

	public int getTableOrderId() {
		return tableOrderId;
	}

	public void setTableOrderId(int tableOrderId) {
		this.tableOrderId = tableOrderId;
	}

	public int getOrderQuantity() {
		return orderQuantity;
	}

	public void setOrderQuantity(int orderQuantity) {
		this.orderQuantity = orderQuantity;
	}

	public TableUserEntity getTableUser() {
		return tableUser;
	}

	public void setTableUser(TableUserEntity tableUser) {
		this.tableUser = tableUser;
	}

	public ProductEntity getProduct() {
		return product;
	}

	public void setProduct(ProductEntity product) {
		this.product = product;
	}


	
	
	
}

