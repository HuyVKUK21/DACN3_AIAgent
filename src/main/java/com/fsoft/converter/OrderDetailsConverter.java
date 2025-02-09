package com.fsoft.converter;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.OrderDetailsDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.entity.OrderDetailseEntity;
import com.fsoft.entity.ProductEntity;

@Component
public class OrderDetailsConverter {
    ModelMapper modelMapper = new ModelMapper();

    public OrderDetailsDTO toDto(OrderDetailseEntity entity) {
        if (entity != null) {
            return modelMapper.map(entity, OrderDetailsDTO.class);
        }
        return null;
    }

    public OrderDetailseEntity toEntity(OrderDetailsDTO dto) {
        if (dto != null) {
            return modelMapper.map(dto, OrderDetailseEntity.class);
        }
        return null;
    }

	public List<OrderDetailseEntity> toListEntity(List<OrderDetailsDTO> dtos) {
		// TODO Auto-generated method stub
		List<OrderDetailseEntity> entities = new ArrayList<>();
		for (OrderDetailsDTO dto : dtos) {
			entities.add(toEntity(dto));
		}
		return entities;
	}
	
	public List<OrderDetailsDTO> toListDTO(List<OrderDetailseEntity> entities) {
		// TODO Auto-generated method stub
		List<OrderDetailsDTO> dtos  = new ArrayList<>();
		for (OrderDetailseEntity entity : entities) {
			dtos.add(toDto(entity));
		}
		return dtos;
	}
}

