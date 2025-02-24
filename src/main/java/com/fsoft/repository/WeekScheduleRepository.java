package com.fsoft.repository;

import com.fsoft.entity.WeekSchedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface WeekScheduleRepository extends JpaRepository<WeekSchedule, Long> {

    Optional<WeekSchedule> findByStartDateAndEndDate(String startDate, String endDate);
}
