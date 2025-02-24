package com.fsoft.service;

import com.fsoft.entity.WeekSchedule;

public interface IWeekSchedule {
    WeekSchedule findByStartDateAndEndDate(String startDate, String endDate);
    WeekSchedule findByStartDateAndEndDateEmployee(String startDate, String endDate);
    WeekSchedule save(WeekSchedule weekSchedule);
}
