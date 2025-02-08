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

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;

@Entity
@Table(name = "tbl_product")
public class ProductEntity extends BaseEnity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id", columnDefinition = "int(10) UNSIGNED")
    private int productId;

    @Column(name = "product_name", columnDefinition = "varchar(256)", nullable = false)
    private String productName;

    @Column(name = "product_desc", columnDefinition = "text", nullable = false)
    private String productDesc;

    @Column(name = "product_price", columnDefinition = "decimal(10,0)", nullable = false)
    private Double productPrice;
    

    @Column(name = "product_image", columnDefinition = "text", nullable = false)
    private String productImage;

    @Column(name = "product_status", columnDefinition = "int(11)", nullable = false)
    private int productStatus;
    
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private CategoryEntity category;
	
	@OneToMany(mappedBy = "product")
	@JsonIgnore
	private List<TableOrderEntity> tableOrderEntities = new ArrayList<>();
	

	@OneToMany(mappedBy = "product")
	@JsonIgnore
	private List<OrderDetailseEntity> orderDetailsEntities = new ArrayList<>();

    // Constructors, Getters, and Setters
    public ProductEntity() {}

	public ProductEntity(int productId, String productName, String productDesc, Double productPrice,
			String productImage, int productStatus) {
		super();
		this.productId = productId;
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

	public CategoryEntity getCategory() {
		return category;
	}

	public void setCategory(CategoryEntity category) {
		this.category = category;
	}
	
	
}
