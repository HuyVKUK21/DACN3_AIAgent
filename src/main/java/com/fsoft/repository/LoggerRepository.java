package com.fsoft.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.fsoft.entity.CategoryEntity;
import com.fsoft.entity.LoggerEntity;

public interface LoggerRepository extends JpaRepository<LoggerEntity, Integer> {

}
