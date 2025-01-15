package com.fsoft.converter;

import com.fsoft.dto.WorkScheduleDTO;
import com.fsoft.entity.WorkScheduleEntity;

public class WorkScheduleConverter {

    public static WorkScheduleDTO toDTO(WorkScheduleEntity workSchedule) {
        WorkScheduleDTO workScheduleDTO = new WorkScheduleDTO();
        workScheduleDTO.setId(workSchedule.getId());
        workScheduleDTO.setDate(workSchedule.getDate().toString());
        workScheduleDTO.setShift(ShiftConverter.toDTO(workSchedule.getShift()));
        workScheduleDTO.setAccount(AccountConverter.toDto(workSchedule.getAccount()));
        workScheduleDTO.setIsActive(workSchedule.getIsActive());
        workScheduleDTO.setIsCheckIn(workSchedule.getIsCheckin());
        workScheduleDTO.setIsCheckOut(workSchedule.getIsCheckout());

        return workScheduleDTO;
    }

}
