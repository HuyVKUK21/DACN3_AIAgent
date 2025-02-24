package com.fsoft.service.impl;

import com.fsoft.entity.WeekSchedule;
import com.fsoft.repository.WeekScheduleRepository;
import com.fsoft.service.IWeekSchedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class WeekScheduleService implements IWeekSchedule {

    @Autowired
    private WeekScheduleRepository repo;

    @Override
    public WeekSchedule findByStartDateAndEndDate(String startDate, String endDate) {
        // if exists return week schedule, else insert new week schedule
        Optional<WeekSchedule> weekSchedule = repo.findByStartDateAndEndDate(startDate, endDate);

        if (weekSchedule.isEmpty()) {
            WeekSchedule newWeekSchedule = new WeekSchedule();
            newWeekSchedule.setStartDate(startDate);
            newWeekSchedule.setEndDate(endDate);
            return repo.save(newWeekSchedule);
        }
        return weekSchedule.orElse(null);
    }

    @Override
    public WeekSchedule findByStartDateAndEndDateEmployee(String startDate, String endDate) {
        // if exists return week schedule, else insert new week schedule
        Optional<WeekSchedule> weekSchedule = repo.findByStartDateAndEndDate(startDate, endDate);
        weekSchedule.ifPresent(value -> value.getWorkSchedules().removeIf(workSchedule -> !workSchedule.getIsActive()));

        if (weekSchedule.isEmpty()) {
            WeekSchedule newWeekSchedule = new WeekSchedule();
            newWeekSchedule.setStartDate(startDate);
            newWeekSchedule.setEndDate(endDate);
            return repo.save(newWeekSchedule);
        }
        return weekSchedule.orElse(null);
    }

    @Override
    public WeekSchedule save(WeekSchedule weekSchedule) {
        return repo.save(weekSchedule);
    }


}
