package com.fsoft.repository;

import com.fsoft.entity.*;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

public interface WorkScheduleRepository extends JpaRepository<WorkScheduleEntity, Long> {
    Optional<WorkScheduleEntity> findByDateAndShiftAndAccount(Date date, ShiftEntity shift, AccountEntity account);

    List<WorkScheduleEntity> findByDateBetween(Date startDate, Date endDate);
    List<WorkScheduleEntity> findByDateBetweenAndIsActive(Date startDate, Date endDate, Boolean isActive);

    @Transactional
    void deleteAllByWeekSchedule(WeekSchedule weekSchedule);

    @Transactional
    void deleteAllByWeekScheduleAndAccount_Id(WeekSchedule weekSchedule, Long accountId);

    List<WorkScheduleEntity> findByDateAndIsActiveAndAccount_Id(Date date, Boolean isActive, Long id);


    List<WorkScheduleEntity> findAllByAccountAndIsActiveAndIsCheckinAndDateBetween(AccountEntity account, Boolean isActive, Boolean isCheckin, Date date, Date date2);
}
