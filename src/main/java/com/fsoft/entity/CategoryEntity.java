package com.fsoft.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;



@Entity
@Table(name = "tbl_category")
public class CategoryEntity extends BaseEnity {
	@Id /* Định nghĩa khóa chính và not null */
	@GeneratedValue(strategy = GenerationType.IDENTITY) /* Bật tính năng tự tăng giá trị */
	@Column (name= "category_id", columnDefinition = "int(10)")
	private Integer categoryId;
	
	@Column (name= "category_name", columnDefinition = "varchar(255)")
	private String categoryName;
	
	@Column (name= "category_image", columnDefinition = "varchar(255)")
	private String categoryImage;
	
	@Column (name= "category_desc", columnDefinition = "text")
	private String categoryDesc;
	
	@Column (name= "category_status", columnDefinition = "int(1)")
	private int categoryStatus;
	
	@OneToMany(mappedBy = "category")
	@JsonIgnore
	private List<ProductEntity> products = new ArrayList<>();
	
	
	public CategoryEntity() {		
	}




	public Integer getCategoryId() {
		return categoryId;
	}




	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}




	public List<ProductEntity> getProducts() {
		return products;
	}




	public void setProducts(List<ProductEntity> products) {
		this.products = products;
	}




	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategoryImage() {
		return categoryImage;
	}

	public void setCategoryImage(String categoryImage) {
		this.categoryImage = categoryImage;
	}

	public String getCategoryDesc() {
		return categoryDesc;
	}

	public void setCategoryDesc(String categoryDesc) {
		this.categoryDesc = categoryDesc;
	}

	public int getCategoryStatus() {
		return categoryStatus;
	}

	public void setCategoryStatus(int categoryStatus) {
		this.categoryStatus = categoryStatus;
	}


	public List<ProductEntity> getProductEntities() {
		return products;
	}


	public void setProductEntities(List<ProductEntity> products) {
		this.products = products;
	}
	
	


}
