package com.fsoft.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.CategoryEntity;



public interface CategoryRepository extends JpaRepository<CategoryEntity, Integer> {
	int countByCategoryNameLike(@Param("categoryName") String categoryName);
	List<CategoryEntity> findByCategoryNameContaining(String categoryName, Pageable pageable);
	CategoryEntity findByCategoryId(Integer categoryId);
}
