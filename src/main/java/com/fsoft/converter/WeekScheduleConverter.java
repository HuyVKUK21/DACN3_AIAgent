package com.fsoft.converter;

import com.fsoft.dto.WeekScheduleDTO;
import com.fsoft.dto.WorkScheduleDTO;
import com.fsoft.entity.WeekSchedule;
import com.fsoft.entity.WorkScheduleEntity;

import java.util.ArrayList;
import java.util.List;

public class WeekScheduleConverter {
    public static WeekScheduleDTO toDTO(WeekSchedule weekSchedule) {
        WeekScheduleDTO weekScheduleDTO = new WeekScheduleDTO();
        weekScheduleDTO.setId(weekSchedule.getId());
        weekScheduleDTO.setStartDate(weekSchedule.getStartDate().toString());
        weekScheduleDTO.setEndDate(weekSchedule.getEndDate().toString());

        List<WorkScheduleDTO> workScheduleDTOs = new ArrayList<>();
        for (WorkScheduleEntity workSchedule : weekSchedule.getWorkSchedules()) {
            workScheduleDTOs.add(WorkScheduleConverter.toDTO(workSchedule));
        }
        weekScheduleDTO.setWorkSchedules(workScheduleDTOs);
        return weekScheduleDTO;
    }
}
