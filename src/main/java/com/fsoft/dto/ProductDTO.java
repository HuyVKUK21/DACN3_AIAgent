package com.fsoft.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class ProductDTO extends BaseDTO<ProductDTO> {
    private int productId;
    private int categoryId;
    private String productName;
    private String productDesc;
    private Double productPrice;
    private String productImage;
    private int productStatus;
    private CategoryDTO category;

    // Constructors
    public ProductDTO() {}
    
    

	public ProductDTO(int productId, int categoryId, String productName, String productDesc, Double productPrice,
			String productImage, int productStatus) {
		this.productId = productId;
		this.categoryId = categoryId;
		this.productName = productName;
		this.productDesc = productDesc;
		this.productPrice = productPrice;
		this.productImage = productImage;
		this.productStatus = productStatus;
	}
	

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getProductDesc() {
		return productDesc;
	}

	public void setProductDesc(String productDesc) {
		this.productDesc = productDesc;
	}

	public Double getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(Double productPrice) {
		this.productPrice = productPrice;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public int getProductStatus() {
		return productStatus;
	}

	public void setProductStatus(int productStatus) {
		this.productStatus = productStatus;
	}



	public CategoryDTO getCategory() {
		return category;
	}



	public void setCategory(CategoryDTO category) {
		this.category = category;
	}






	
  
}
