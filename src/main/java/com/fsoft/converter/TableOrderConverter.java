package com.fsoft.converter;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.fsoft.dto.ProductDTO;
import com.fsoft.dto.TableOrderDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.ProductEntity;
import com.fsoft.entity.TableOrderEntity;
import com.fsoft.response.TableOrderResponse;
import com.fsoft.service.IProductService;
import com.fsoft.service.ITableUserService;

@Component
public class TableOrderConverter {

	private final ModelMapper modelMapper = new ModelMapper();

	private static final Logger logger = Logger.getLogger(TableOrderConverter.class);

	@Autowired
	private IProductService productService;

	@Autowired
	private ITableUserService tableUserService;

	public TableOrderDTO toDto(TableOrderEntity entity) {
		if (entity != null) {
			return modelMapper.map(entity, TableOrderDTO.class);
		} else {
			return null;
		}
	}

	public TableOrderEntity toEntity(TableOrderDTO dto) {
		if (dto != null) {
			return modelMapper.map(dto, TableOrderEntity.class);
		} else {
			return null;
		}
	}

	public List<TableOrderDTO> toListDTO(List<TableOrderEntity> entities) {
		List<TableOrderDTO> DTOs = new ArrayList<>();
		for (TableOrderEntity entity : entities) {
			DTOs.add(toDto(entity));
		}
		return DTOs;
	}

	public List<TableOrderEntity> toListEntity(List<TableOrderDTO> DTOs) {
		List<TableOrderEntity> entities = new ArrayList<>();
		for (TableOrderDTO dto : DTOs) {
			entities.add(toEntity(dto));
		}
		return entities;
	}

	private ProductDTO convertProductEntityToDTO(ProductEntity entity) {
		if (entity == null)
			return null;
		return modelMapper.map(entity, ProductDTO.class);
	}

	public TableOrderDTO convertToDTO(TableOrderResponse response) {
		try {
			TableOrderDTO dto = new TableOrderDTO();
			dto.setOrderQuantity(response.getOrderQuantity());

			// Lấy thông tin đầy đủ của bàn từ service
			TableUserDTO tableUser = tableUserService.findByID(response.getUserTableID());
			if (tableUser == null) {
				tableUser = new TableUserDTO();
				tableUser.setUserTableID(response.getUserTableID());
			}
			dto.setTableUser(tableUser);

			// Lấy thông tin đầy đủ của sản phẩm từ service và chuyển đổi sang DTO
			ProductEntity productEntity = productService.findById(response.getProductId());
			ProductDTO product = convertProductEntityToDTO(productEntity);
			if (product == null) {
				product = new ProductDTO();
				product.setProductId(response.getProductId());
			}
			dto.setProduct(product);

			return dto;
		} catch (Exception e) {
			logger.error("Error converting TableOrderResponse to DTO: " + e.getMessage(), e);
			return null;
		}
	}
}