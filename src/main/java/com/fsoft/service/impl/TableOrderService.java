package com.fsoft.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fsoft.converter.TableOrderConverter;
import com.fsoft.dto.TableOrderDTO;
import com.fsoft.entity.TableOrderEntity;
import com.fsoft.repository.TableOrderRepository;
import com.fsoft.response.TableOrderResponse;
import com.fsoft.service.ITableOrderService;

@Service
public class TableOrderService implements ITableOrderService{

	@Autowired
	TableOrderRepository tableOrderRepository;
	@Autowired
	TableOrderConverter tableOrderConverter;
	
	@Override
	public List<TableOrderDTO> findAll() {
		// TODO Auto-generated method stub
		return tableOrderConverter.toListDTO(tableOrderRepository.findAll());
	}

	@Override
	public List<TableOrderEntity> getAll() {
		// TODO Auto-generated method stub
		return tableOrderRepository.findAll();
	}

	@Override
	@Transactional
	public void deleteTable(int userTableID) {
        tableOrderRepository.deleteByTableUser_UserTableID(userTableID);		
	}

	@Override
	@Transactional
	public void deleteItemOrder(int tableOrderId) {
		// TODO Auto-generated method stub
		tableOrderRepository.delete(tableOrderId);
		
	}

	@Override
	public void updateQantityItemOrder(TableOrderResponse tableOrderResponse) {
		// TODO Auto-generated method stub
		TableOrderEntity tableOrderEntity = tableOrderRepository.getOne(tableOrderResponse.getTableOrderId());
		tableOrderEntity.setOrderQuantity(tableOrderResponse.getOrderQuantity());
		tableOrderRepository.save(tableOrderEntity);
	}

	@Override
	public int totalQuantityByTableID(int userTableID) {
		// TODO Auto-generated method stub
		return tableOrderRepository.sumOrderQuantityByUserTableID(userTableID);
	}

	@Override
	public BigDecimal  totalPriceProductByTableID(int userTableID) {
		// TODO Auto-generated method stub
		return tableOrderRepository.sumTotalPriceByUserTableID(userTableID);
	}

	@Override
	public List<TableOrderEntity> findTableOrderByUserTableID(int userTableID) {
		// TODO Auto-generated method stub
		return tableOrderRepository.findByTableUser_UserTableID(userTableID);
	}
	
	public Integer getTotalQuantity() {
        return tableOrderRepository.findTotalQuantity();
    }
	
	public TableOrderResponse getTotalQuantityResponse() {
	    TableOrderResponse response = new TableOrderResponse();
	    response.setTotalOrderQuantity(tableOrderRepository.findTotalQuantity());
	    return response;
	}
}
