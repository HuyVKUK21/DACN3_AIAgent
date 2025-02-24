package com.fsoft.service.impl;

import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.WeekSchedule;
import com.fsoft.entity.WorkScheduleEntity;
import com.fsoft.repository.AccountRepository;
import com.fsoft.repository.WeekScheduleRepository;
import com.fsoft.repository.WorkScheduleRepository;
import com.fsoft.service.IWorkScheduleService;
import com.fsoft.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class WorkScheduleService implements IWorkScheduleService {

    @Autowired
    private WorkScheduleRepository repo;
    @Autowired
    private AccountRepository accountRepository;

    @Override
    public void save(WorkScheduleEntity workSchedule) {

        Optional<WorkScheduleEntity> workScheduleEntity = repo.findByDateAndShiftAndAccount(workSchedule.getDate(), workSchedule.getShift(), workSchedule.getAccount());
        if (workScheduleEntity.isPresent()) {
            workSchedule.setId(workScheduleEntity.get().getId());
        }
        repo.save(workSchedule);
    }

    @Override
    public List<WorkScheduleEntity> findByStartDateAndEndDate(String s, String s1) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date startDate = sdf.parse(s);
            Date endDate = sdf.parse(s1);
            return repo.findByDateBetween(startDate, endDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<WorkScheduleEntity> findByStartDateAndEndDateEmployee(String s, String s1) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date startDate = sdf.parse(s);
            Date endDate = sdf.parse(s1);
            return repo.findByDateBetweenAndIsActive(startDate, endDate, true);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public void deleteByWeekSchedule(WeekSchedule weekSchedule) {
        repo.deleteAllByWeekSchedule(weekSchedule);
    }

    @Override
    public void deleteByWeekScheduleAndAccountId(WeekSchedule weekSchedule, Long accountId) {
        repo.deleteAllByWeekScheduleAndAccount_Id(weekSchedule, accountId);
    }

    @Override
    public Double getSalaryEmployeeByDate(Long accountId, String startDate, String endDate) {
        AccountEntity account = accountRepository.findById(accountId);

        if (account == null) {
            return 0.0;
        }

        List<WorkScheduleEntity> workScheduleEntities = repo.findAllByAccountAndIsActiveAndIsCheckinAndDateBetween(account, true, true, Utils.convertStringToDate(startDate), Utils.convertStringToDate(endDate));
        Double salary = 0.0;
        for (WorkScheduleEntity workScheduleEntity : workScheduleEntities) {
            salary += workScheduleEntity.getShift().getSalary();
        }
        return salary;
    }

    @Override
    public int getAttendanceEmployeeByDate(Long accountId, String startDate, String endDate) {
        AccountEntity account = accountRepository.findById(accountId);

        if (account == null) {
            return 0;
        }

        List<WorkScheduleEntity> workScheduleEntities = repo.findAllByAccountAndIsActiveAndIsCheckinAndDateBetween(account, true, true, Utils.convertStringToDate(startDate), Utils.convertStringToDate(endDate));
        return workScheduleEntities.size();

    }
}
