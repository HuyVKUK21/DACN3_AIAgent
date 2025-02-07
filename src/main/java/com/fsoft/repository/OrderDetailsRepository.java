package com.fsoft.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import com.fsoft.entity.OrderDetailseEntity;
import com.fsoft.entity.ProductEntity;

public interface OrderDetailsRepository extends JpaRepository<OrderDetailseEntity, Integer> {
    // Additional custom queries can be defined here if needed
	long countByOrder_OrderId(int id);
	Page<OrderDetailseEntity> findByOrder_OrderId(int id, Pageable pageable);
}
