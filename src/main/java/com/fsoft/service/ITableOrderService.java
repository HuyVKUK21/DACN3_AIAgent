package com.fsoft.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fsoft.dto.TableOrderDTO;
import com.fsoft.entity.TableOrderEntity;
import com.fsoft.response.TableOrderResponse;

@Service
public interface ITableOrderService {

	List<TableOrderDTO> findAll();

	List<TableOrderEntity> getAll();

	void deleteTable(int userTableID);

	void deleteItemOrder(int tableOrderId);

	void updateQantityItemOrder(TableOrderResponse tableOrderResponse);

	int totalQuantityByTableID(int userTableID);

	BigDecimal  totalPriceProductByTableID(int userTableID);

	List<TableOrderEntity> findTableOrderByUserTableID(int userTableID);
	
	TableOrderResponse getTotalQuantityResponse();
	
	Integer getTotalQuantity();

}
