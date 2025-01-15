package com.fsoft.converter;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.CategoryEntity;



@Component
public class CategoryConverter {
	 ModelMapper modelMapper = new ModelMapper();
	 public CategoryDTO toDto(CategoryEntity entity) {
	    	if (entity != null) {
	    		CategoryDTO dto = modelMapper.map(entity, CategoryDTO.class);
	    	        return dto;
			}else {
				return null;
			}
	     
	    }
	    public CategoryEntity toEntity(CategoryDTO toDto) {
	    	if (toDto != null) {
	    		CategoryEntity entity = modelMapper.map(toDto, CategoryEntity.class);
	        return entity;
	    	}else {
	    		return null;
	    	}
	    }
	    
		public List<CategoryDTO> toListDTO(List<CategoryEntity> content) {
			// TODO Auto-generated method stub
			List<CategoryDTO> categoryDTOs  = new ArrayList<>();
			for (CategoryEntity entity : content) {
				categoryDTOs.add(toDto(entity));
			}
			return categoryDTOs;
		}
}
