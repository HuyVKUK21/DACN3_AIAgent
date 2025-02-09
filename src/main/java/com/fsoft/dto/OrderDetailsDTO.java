package com.fsoft.dto;

public class OrderDetailsDTO extends BaseDTO<OrderDetailsDTO>{
    private int orderDetailsId;
    private String orderCode;
    private int productId;
    private String productName;
    private String productPrice;
    private int productQuantity;
    
    public OrderDetailsDTO() {}

	public OrderDetailsDTO(int orderDetailsId, String orderCode, int productId, String productName, String productPrice,
			int productQuantity) {
		super();
		this.orderDetailsId = orderDetailsId;
		this.orderCode = orderCode;
		this.productId = productId;
		this.productName = productName;
		this.productPrice = productPrice;
		this.productQuantity = productQuantity;
	}

	public int getOrderDetailsId() {
		return orderDetailsId;
	}

	public void setOrderDetailsId(int orderDetailsId) {
		this.orderDetailsId = orderDetailsId;
	}

	public String getOrderCode() {
		return orderCode;
	}

	public void setOrderCode(String orderCode) {
		this.orderCode = orderCode;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}

	public int getProductQuantity() {
		return productQuantity;
	}

	public void setProductQuantity(int productQuantity) {
		this.productQuantity = productQuantity;
	}
    
    
	
}
