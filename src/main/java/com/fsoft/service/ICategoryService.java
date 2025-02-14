package com.fsoft.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.CategoryDTO;



public interface ICategoryService {
	CategoryDTO insert(CategoryDTO categoryDTO);
	List<CategoryDTO> findAll(Pageable pageable);
	List<CategoryDTO> findAllDesc(Pageable pageable);
	Integer getTotalItem();
	CategoryDTO findByID(int category_id);
	String deleteAdmin(int category_id);
	void deleteAdmins(int[] ids);
	int countByCategoryNameLike(@Param("categoryName") String categoryName);
	List<CategoryDTO> findByCategoryNameContaining(String categoryName, Pageable pageable);
	String updateCategoryStatus(Integer category_id, Integer category_status);
	CategoryDTO update(CategoryDTO categoryDTO);
	List<CategoryDTO> findAll();
	

}
