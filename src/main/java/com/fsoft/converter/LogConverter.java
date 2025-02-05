package com.fsoft.converter;

import com.fsoft.dto.LogDTO;
import com.fsoft.entity.LogEntity;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class LogConverter {
    private static final ModelMapper modelMapper = new ModelMapper();

    public static LogDTO toDto(LogEntity entity) {
        return modelMapper.map(entity, LogDTO.class);
    }
    public static List<LogDTO> toDtoList(List<LogEntity> entityList) {
        return entityList.stream().map(entity -> modelMapper.map(entity, LogDTO.class)).toList();
    }
    public static LogEntity toEntity(LogDTO dto) {
        return modelMapper.map(dto, LogEntity.class);
    }
}