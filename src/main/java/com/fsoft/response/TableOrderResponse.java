package com.fsoft.response;

public class TableOrderResponse {
	private int tableOrderId;
    private int orderQuantity;
    private int userTableID;
    private int productId;
    private int totalOrderQuantity;
    
    public TableOrderResponse() {}
    
    
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

	public int getUserTableID() {
		return userTableID;
	}

	public void setUserTableID(int userTableID) {
		this.userTableID = userTableID;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}
	

	public int getTotalOrderQuantity() {
		return totalOrderQuantity;
	}


	public void setTotalOrderQuantity(int totalOrderQuantity) {
		this.totalOrderQuantity = totalOrderQuantity;
	}


	@Override
	public String toString() {
		return "TableOrderResponse [orderQuantity=" + orderQuantity + ", userTableID=" + userTableID + ", productId="
				+ productId + "]";
	}



}
