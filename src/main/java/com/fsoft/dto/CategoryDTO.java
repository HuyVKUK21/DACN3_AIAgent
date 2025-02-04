package com.fsoft.dto;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Transient;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class CategoryDTO extends BaseDTO<CategoryDTO> {
	private int categoryId;
	private String categoryName;
	private String categoryImage;
	private String categoryDesc;
	private int categoryStatus;
	@Transient
	private CommonsMultipartFile categoryImageFile;
	
	public CategoryDTO() {
	}

	public CategoryDTO(int categoryId, String categoryName, String categoryImage, String categoryDesc,
			int categoryStatus) {
		super();
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryImage = categoryImage;
		this.categoryDesc = categoryDesc;
		this.categoryStatus = categoryStatus;
	}

	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
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
	
	

	
	public CommonsMultipartFile getCategoryImageFile() {
		return categoryImageFile;
	}

	public void setCategoryImageFile(CommonsMultipartFile categoryImageFile) {
		this.categoryImageFile = categoryImageFile;
	}

	@Override
	public String toString() {
		return "CategoryDTO [categoryId=" + categoryId + ", categoryName=" + categoryName + ", categoryImage="
				+ categoryImage + ", categoryDesc=" + categoryDesc + ", categoryStatus=" + categoryStatus + "]";
	}

	
}
