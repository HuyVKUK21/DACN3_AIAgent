package com.fsoft.service.impl;

import org.apache.log4j.Logger;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fsoft.converter.CategoryConverter;
import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.entity.CategoryEntity;
import com.fsoft.repository.CategoryRepository;
import com.fsoft.service.ICategoryService;

@Service
public class CategoryService implements ICategoryService {
	private static final Logger logger = Logger.getLogger(CategoryService.class);

	@Autowired
	private CategoryRepository categoryRepository;

	@Autowired
	private CategoryConverter categoryConverter;

	@Override
	public List<CategoryDTO> findAll(Pageable pageable) {
		// TODO Auto-generated method stub
		Sort sort = new Sort(Sort.Direction.ASC, "categoryName");
		 Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
		return categoryConverter.toListDTO(categoryRepository.findAll(sortedByName).getContent());
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) categoryRepository.count();
	}

	@Override
	public CategoryDTO findByID(int category_id) {
		// TODO Auto-generated method stub
		CategoryDTO categoryDTO = new CategoryDTO();
		CategoryEntity categoryEntity = categoryRepository.findOne(category_id);
		categoryDTO = categoryConverter.toDto(categoryEntity);
		return categoryDTO;
	}

	@Override
//	@Transactional
	public CategoryDTO insert(CategoryDTO categoryDTO) {
		// TODO Auto-generated method stub
		CategoryEntity categoryEntity = categoryConverter.toEntity(categoryDTO);
		categoryEntity = categoryRepository.save(categoryEntity);
		categoryDTO = categoryConverter.toDto(categoryEntity);
		return categoryDTO;
	}

	@Override
//	@Transactional
	public CategoryDTO update(CategoryDTO categoryDTO) {
	    
	    CategoryEntity categoryEntity = categoryConverter.toEntity(categoryDTO);

	    if (categoryEntity.getCategoryId() != null) {
	        Optional<CategoryEntity> existingCategory = Optional.ofNullable(categoryRepository.findByCategoryId(categoryEntity.getCategoryId()));

	        if (existingCategory.isPresent()) {
	            CategoryEntity updatedCategory = existingCategory.get();
	            updatedCategory.setCategoryName(categoryEntity.getCategoryName());
	            updatedCategory.setCategoryImage(categoryEntity.getCategoryImage());
	            updatedCategory.setCategoryDesc(categoryEntity.getCategoryDesc());
	            updatedCategory.setCategoryStatus(categoryEntity.getCategoryStatus());

	            categoryEntity = categoryRepository.save(updatedCategory);
	        } else {
	            throw new EntityNotFoundException("Category with id " + categoryDTO.getCategoryId() + " not found");
	        }
	    } else {
	        throw new IllegalArgumentException("Category ID cannot be null");
	    }

	    return categoryConverter.toDto(categoryEntity);
	}



	@Override
	public void deleteAdmins(int[] ids) {
		// TODO Auto-generated method stub
		for (int id : ids) {
			deleteAdmin(id);
		}
	}

	@Override
	public String deleteAdmin(int category_id) {
		try {
			categoryRepository.delete(category_id);
			logger.info("Category deleted successfully");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";

	}

	@Override
	public int countByCategoryNameLike(String categoryName) {
		// TODO Auto-generated method stub
		return categoryRepository.countByCategoryNameLike("%" + categoryName + "%");
	}

	@Override
	public List<CategoryDTO> findByCategoryNameContaining(String categoryName, Pageable pageable) {
		// TODO Auto-generated method stub
		return categoryConverter.toListDTO(categoryRepository.findByCategoryNameContaining(categoryName, pageable));
	}

	@Override
	public String updateCategoryStatus(Integer category_id, Integer category_status) {
	    Optional<CategoryEntity> categoryOptional = Optional.ofNullable(categoryRepository.findByCategoryId(category_id));

	    if (categoryOptional.isPresent()) {
	        CategoryEntity category = categoryOptional.get();
	        category.setCategoryStatus(category_status);
	        categoryRepository.save(category);
	        return "Category status updated successfully";
	    } else {
	        throw new EntityNotFoundException("Category not found with id: " + category_id);
	    }
	}

	@Override
	public List<CategoryDTO> findAllDesc(Pageable pageable) {
		Sort sort = new Sort(Sort.Direction.DESC, "categoryName");
        Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
        return categoryConverter.toListDTO(categoryRepository.findAll(sortedByName).getContent());
	}

	@Override
	public List<CategoryDTO> findAll() {
		// TODO Auto-generated method stub
		return categoryConverter.toListDTO(categoryRepository.findAll());
	}


}
