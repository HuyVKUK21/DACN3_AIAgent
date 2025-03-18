package com.fsoft.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fsoft.entity.ProductEntity;
import com.fsoft.entity.TableUserEntity;

public class TableOrderDTO extends BaseDTO<TableOrderDTO> {
    private int tableOrderId; // ID của order
    private int orderQuantity; // Số lượng order
    private TableUserDTO tableUser;
    private ProductDTO product;

    // Constructors
    public TableOrderDTO() {}

	public TableOrderDTO(int tableOrderId, int orderQuantity, TableUserDTO tableUser, ProductDTO product) {
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

	public TableUserDTO getTableUser() {
		return tableUser;
	}

	public void setTableUser(TableUserDTO tableUser) {
		this.tableUser = tableUser;
	}

	public ProductDTO getProduct() {
		return product;
	}

	public void setProduct(ProductDTO product) {
		this.product = product;
	}

	

	
	

}
