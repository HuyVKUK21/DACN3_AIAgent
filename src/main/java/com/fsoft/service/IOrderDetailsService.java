package com.fsoft.service;

import java.util.List;

import org.springframework.data.domain.Pageable;

import com.fsoft.dto.OrderDetailsDTO;
import com.fsoft.entity.OrderDetailseEntity;

public interface IOrderDetailsService {

	void saveOrderDetails(OrderDetailseEntity orderDetailseEntity);

	Integer getTotalItemByOrderID(Integer id);

	List<OrderDetailsDTO> findAll(Integer id, Pageable pageable);

}
