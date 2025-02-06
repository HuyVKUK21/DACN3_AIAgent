package com.fsoft.converter;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.ProductDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.ProductEntity;
import com.fsoft.entity.TableUserEntity;

@Component
public class ProductConverter {
    ModelMapper modelMapper = new ModelMapper();

    public ProductDTO toDto(ProductEntity entity) {
        if (entity != null) {
            return modelMapper.map(entity, ProductDTO.class);
        }
        return null;
    }

    public ProductEntity toEntity(ProductDTO dto) {
        if (dto != null) {
            return modelMapper.map(dto, ProductEntity.class);
        }
        return null;
    }
    
	public List<ProductEntity> toListEntity(List<ProductDTO> dtos) {
		// TODO Auto-generated method stub
		List<ProductEntity> entities = new ArrayList<>();
		for (ProductDTO dto : dtos) {
			entities.add(toEntity(dto));
		}
		return entities;
	}
	
	public List<ProductDTO> toListDTO(List<ProductEntity> entities) {
		// TODO Auto-generated method stub
		List<ProductDTO> dtos  = new ArrayList<>();
		for (ProductEntity entity : entities) {
			dtos.add(toDto(entity));
		}
		return dtos;
	}
	
	
}
