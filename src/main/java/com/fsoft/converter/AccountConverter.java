package com.fsoft.converter;

import java.util.ArrayList;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.TableUserEntity;

@Component
public class AccountConverter {
	private static final ModelMapper modelMapper = new ModelMapper();

	public static AccountDTO toDto(AccountEntity entity) {
		if (entity != null) {
			AccountDTO dto = modelMapper.map(entity, AccountDTO.class);
			return dto;
		} else {
			return null;
		}

	}

	public AccountEntity toEntity(AccountDTO toDto) {
		if (toDto != null) {
			AccountEntity entity = modelMapper.map(toDto, AccountEntity.class);
			return entity;
		} else {
			return null;
		}
	}

	public List<AccountDTO> toListDTO(List<AccountEntity> content) {
		// TODO Auto-generated method stub
		List<AccountDTO> accountDTOs  = new ArrayList<>();
		for (AccountEntity entity : content) {
			accountDTOs.add(toDto(entity));
		}
		return accountDTOs;
	}
}
