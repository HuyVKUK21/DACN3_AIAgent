package com.fsoft.service;

import com.fsoft.entity.ShiftEntity;

public interface IShiftService {

    ShiftEntity findById(Long id);

    ShiftEntity findByShiftType(String shiftType);

    ShiftEntity save(ShiftEntity shift);
}
