package com.fsoft.dto;

import java.math.BigDecimal;

public class ProductBestSellerDTO extends BaseDTO<ProductBestSellerDTO>{
	   private int productId;
	    private String productName;
	    private String productImage;
	    private Double productPrice;
	    private String productDesc;
	    private Long totalQuantity;
	    
	   
		public ProductBestSellerDTO() {
			super();
		}


		public ProductBestSellerDTO(int productId, String productName, String productImage, Double productPrice,
				String productDesc, Long totalQuantity) {
			super();
			this.productId = productId;
			this.productName = productName;
			this.productImage = productImage;
			this.productPrice = productPrice;
			this.productDesc = productDesc;
			this.totalQuantity = totalQuantity;
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


		public String getProductImage() {
			return productImage;
		}

		

		public void setProductImage(String productImage) {
			this.productImage = productImage;
		}


		public Double getProductPrice() {
			return productPrice;
		}


		public void setProductPrice(Double productPrice) {
			this.productPrice = productPrice;
		}


		public String getProductDesc() {
			return productDesc;
		}


		public void setProductDesc(String productDesc) {
			this.productDesc = productDesc;
		}


		public Long getTotalQuantity() {
			return totalQuantity;
		}


		public void setTotalQuantity(Long totalQuantity) {
			this.totalQuantity = totalQuantity;
		}


		


		
}
