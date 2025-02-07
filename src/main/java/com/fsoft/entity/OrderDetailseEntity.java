package com.fsoft.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.Column;

@Entity
@Table(name = "tbl_order_details")
public class OrderDetailseEntity extends BaseEnity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_details_id", columnDefinition = "int(10) UNSIGNED")
    private int orderDetailsId;
    
	
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_code", referencedColumnName = "order_id")
    private OrderEntity order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", referencedColumnName = "product_id")
    private ProductEntity product;

    @Column(name = "product_name", columnDefinition = "varchar(255)", nullable = false)
    private String productName;

    @Column(name = "product_price", columnDefinition = "decimal(10,0)", nullable = false)
    private Double productPrice;

    @Column(name = "product_quantity", columnDefinition = "int(11)", nullable = false)
    private int productQuantity;

    // Constructors, Getters, and Setters
    public OrderDetailseEntity() {}


	public int getOrderDetailsId() {
		return orderDetailsId;
	}

	public void setOrderDetailsId(int orderDetailsId) {
		this.orderDetailsId = orderDetailsId;
	}

	

	public ProductEntity getProduct() {
		return product;
	}


	public void setProduct(ProductEntity product) {
		this.product = product;
	}


	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}
 
	

	public Double getProductPrice() {
		return productPrice;
	}


	public void setProductPrice(Double productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}


	public OrderEntity getOrder() {
		return order;
	}


	public void setOrder(OrderEntity order) {
		this.order = order;
	}
    
    
   
}
