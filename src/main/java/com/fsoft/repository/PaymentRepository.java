package com.fsoft.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.fsoft.entity.PaymentEntity;

public interface PaymentRepository extends JpaRepository<PaymentEntity, Integer> {
    // Additional custom queries can be defined here if needed
}
