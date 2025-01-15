package com.fsoft.converter;

import com.fsoft.dto.ShiftDTO;
import com.fsoft.entity.ShiftEntity;
import org.modelmapper.ModelMapper;

public class ShiftConverter {

    private static final ModelMapper modelMapper = new ModelMapper();

    public static ShiftEntity toEntity(ShiftDTO shift) {
        return modelMapper.map(shift, ShiftEntity.class);
    }

    public static ShiftDTO toDTO(ShiftEntity shift) {
        return modelMapper.map(shift, ShiftDTO.class);
    }

}
