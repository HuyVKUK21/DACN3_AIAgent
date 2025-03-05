package com.fsoft.service.impl;

import com.fsoft.entity.ShiftEntity;
import com.fsoft.enums.ShiftType;
import com.fsoft.repository.ShiftRepository;
import com.fsoft.service.IShiftService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShiftService implements IShiftService {

    @Autowired
    private ShiftRepository repo;

    @Override
    public ShiftEntity findById(Long id) {
        return repo.findOne(id);
    }

    @Override
    public ShiftEntity findByShiftType(String shiftType) {
        return repo.findByShiftType(ShiftType.valueOf(shiftType));
    }

    @Override
    public ShiftEntity save(ShiftEntity shift) {
        return repo.save(shift);
    }
}
