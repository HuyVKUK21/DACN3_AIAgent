package com.fsoft.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.fsoft.converter.OrderDetailsConverter;
import com.fsoft.dto.OrderDetailsDTO;
import com.fsoft.entity.OrderDetailseEntity;
import com.fsoft.entity.ProductEntity;
import com.fsoft.repository.OrderDetailsRepository;
import com.fsoft.service.IOrderDetailsService;

@Service
public class OrderDetailsService implements IOrderDetailsService{

	@Autowired
	OrderDetailsRepository orderDetailsRepository;
	
	@Autowired
	OrderDetailsConverter detailsConverter;
	
	@Override
	public void saveOrderDetails(OrderDetailseEntity orderDetailseEntity) {
		// TODO Auto-generated method stub
		orderDetailsRepository.save(orderDetailseEntity);
	}

	@Override
	public Integer getTotalItemByOrderID(Integer id) {
		// TODO Auto-generated method stub
		return (int) orderDetailsRepository.countByOrder_OrderId(id);
	}

	@Override
	public List<OrderDetailsDTO> findAll(Integer id, Pageable pageable) {
		// TODO Auto-generated method stub
		List<OrderDetailseEntity> detailseEntities = orderDetailsRepository.findByOrder_OrderId(id, pageable).getContent();
		
		List<OrderDetailsDTO> orderDetailsDTOs = detailsConverter.toListDTO(detailseEntities);
		
		return orderDetailsDTOs;
	}

}
