package com.fsoft.repository;

import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.LogEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LogRepository extends JpaRepository<LogEntity, Long> {
    LogEntity findTopByAccountAndDateOrderByTimeDesc(AccountEntity account, String date);
    List<LogEntity> findAllByAccountOrderByCreatedDateDesc(AccountEntity account);
}