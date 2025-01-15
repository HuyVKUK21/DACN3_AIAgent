package com.fsoft.converter;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.PaymentDTO;
import com.fsoft.entity.PaymentEntity;

@Component
public class PaymentConverter {
    ModelMapper modelMapper = new ModelMapper();

    public PaymentDTO toDto(PaymentEntity entity) {
        if (entity != null) {
            return modelMapper.map(entity, PaymentDTO.class);
        }
        return null;
    }

    public PaymentEntity toEntity(PaymentDTO dto) {
        if (dto != null) {
            return modelMapper.map(dto, PaymentEntity.class);
        }
        return null;
    }
}
