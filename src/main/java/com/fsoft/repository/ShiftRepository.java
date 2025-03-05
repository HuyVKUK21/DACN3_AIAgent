package com.fsoft.repository;

import com.fsoft.entity.ShiftEntity;
import com.fsoft.enums.ShiftType;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShiftRepository extends JpaRepository<ShiftEntity, Long> {
    ShiftEntity findByShiftType(ShiftType shiftType);
}
