package com.fsoft.service;

import com.fsoft.entity.WeekSchedule;
import com.fsoft.entity.WorkScheduleEntity;

import java.util.List;

public interface IWorkScheduleService {
    void save(WorkScheduleEntity workSchedule);

    List<WorkScheduleEntity> findByStartDateAndEndDate(String s, String s1);
    List<WorkScheduleEntity> findByStartDateAndEndDateEmployee(String s, String s1);

    void deleteByWeekSchedule(WeekSchedule weekSchedule);

    void deleteByWeekScheduleAndAccountId(WeekSchedule weekSchedule, Long accountId);

    Double getSalaryEmployeeByDate(Long accountId, String startDate, String endDate);

    int getAttendanceEmployeeByDate(Long accountId, String startDate, String endDate);
}
