package com.fsoft.converter;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.OrderDTO;
import com.fsoft.entity.OrderEntity;

@Component
public class OrderConverter {
    ModelMapper modelMapper = new ModelMapper();

    public OrderDTO toDto(OrderEntity entity) {
        if (entity != null) {
            return modelMapper.map(entity, OrderDTO.class);
        }
        return null;
    }

    public OrderEntity toEntity(OrderDTO dto) {
        if (dto != null) {
            return modelMapper.map(dto, OrderEntity.class);
        }
        return null;
    }
    
	
	public List<OrderDTO> toListDTO(List<OrderEntity> entities) {
		// TODO Auto-generated method stub
		List<OrderDTO> DTOs  = new ArrayList<>();
		for (OrderEntity entity : entities) {
			DTOs.add(toDto(entity));
		}
		return DTOs;
	}
	
	public List<OrderEntity> toListEntity(List<OrderDTO> DTOs) {
		// TODO Auto-generated  entities stub
		List<OrderEntity>  entities = new ArrayList<>();
		for (OrderDTO dto : DTOs) {
			entities.add(toEntity(dto));
		}
		return entities;
	}
}
