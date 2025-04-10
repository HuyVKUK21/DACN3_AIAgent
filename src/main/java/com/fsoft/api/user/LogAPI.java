package com.fsoft.api.user;

import com.fsoft.converter.LogConverter;
import com.fsoft.dto.LogDTO;
import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.LogEntity;
import com.fsoft.entity.WorkScheduleEntity;
import com.fsoft.enums.LogType;
import com.fsoft.repository.AccountRepository;
import com.fsoft.repository.LogRepository;
import com.fsoft.repository.WorkScheduleRepository;
import com.fsoft.response.ResponseAPI;
import com.fsoft.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/log")
public class LogAPI {

    @Autowired
    private LogRepository logRepository;
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private WorkScheduleRepository workScheduleRepository;

    @GetMapping("/get-log")
    public ResponseAPI<?> getLog(@RequestParam Long accountId) {
        AccountEntity account = accountRepository.findById(accountId);
        String date = Utils.getCurrentDate();
        LogEntity logEntity = logRepository.findTopByAccountAndDateOrderByTimeDesc(account, date);

        if (logEntity == null) {
            return new ResponseAPI<>(400, "Ngày mới tốt đẹp!", null);
        }

        if (logEntity.getAction() == LogType.CHECK_OUT) {
            return new ResponseAPI<>(200, "Chuẩn bị vào ca làm việc mới thôi nào!", "CHECKED_IN");
        }

        if (logEntity.getAction() == LogType.CHECK_IN) {
            return new ResponseAPI<>(200, "Sắp đến giờ về rùi!", "CHECKED_OUT");
        }


        return new ResponseAPI<>(400, "Lỗi không xác định", null);
    }


    @PostMapping("/check-in")
    public ResponseAPI<?> checkIn(@RequestParam Long accountId) {

        AccountEntity account = accountRepository.findById(accountId);
        String time = Utils.getCurrentTime();
        String date = Utils.getCurrentDate();

        // find account have shift today
        List<WorkScheduleEntity> workScheduleInDBs = workScheduleRepository.findByDateAndIsActiveAndAccount_Id(Utils.convertStringToDate(date), true, accountId);

        if (workScheduleInDBs.isEmpty()) {
            return new ResponseAPI<>(400, "Hôm nay bạn không có ca làm!", null);
        }

        for (WorkScheduleEntity workSchedule : workScheduleInDBs) {
            if (Utils.compareTimeString(workSchedule.getShift().getStartTime(), time)) {
                return new ResponseAPI<>(400, "Chưa đến giờ check in", null);
            }
            if (Utils.compareTimeString(time, workSchedule.getShift().getEndTime())) {
                return new ResponseAPI<>(400, "Đã quá giờ check in", null);
            }
            if (Utils.compareTimeString(time, workSchedule.getShift().getStartTime()) && Utils.compareTimeString(workSchedule.getShift().getEndTime(), time)) {
                // check in success
                LogEntity logInDB = logRepository.findTopByAccountAndDateOrderByTimeDesc(account, date);

                if (logInDB != null) {
                    if (logInDB.getAction() == LogType.CHECK_IN) {
                        return new ResponseAPI<>(400, "Bạn đã check in rồi", null);
                    }
                }


                LogEntity logEntity = new LogEntity();
                logEntity.setAccount(account);
                logEntity.setDate(date);
                logEntity.setTime(time);
                logEntity.setAction(LogType.CHECK_IN);
                logEntity.setStatus(true);
                logRepository.save(logEntity);

                workSchedule.setIsCheckin(true);
                workScheduleRepository.save(workSchedule);
                return new ResponseAPI<>(200, "Check-in thành công!", null);
            }
        }

        return new ResponseAPI<>(400, "Lỗi không xác định", null);
    }

    @PostMapping("/check-out")
    public ResponseAPI<?> checkOut(@RequestParam Long accountId) {
        String time = Utils.getCurrentTime();
        String date = Utils.getCurrentDate();

        AccountEntity account = accountRepository.findById(accountId);

        // find account have shift today
        List<WorkScheduleEntity> workScheduleInDBs = workScheduleRepository.findByDateAndIsActiveAndAccount_Id(Utils.convertStringToDate(date), true, accountId);

        if (workScheduleInDBs.isEmpty()) {
            return new ResponseAPI<>(400, "Hôm nay bạn không có ca làm!", null);
        }

        for (WorkScheduleEntity workSchedule : workScheduleInDBs) {
            if (Utils.compareTimeString(workSchedule.getShift().getStartTime(), time)) {
                return new ResponseAPI<>(400, "Chưa đến giờ check out", null);
            }
            if (Utils.compareTimeString(time, workSchedule.getShift().getEndTime())) {
                return new ResponseAPI<>(400, "Đã quá giờ check out", null);
            }
            if (Utils.compareTimeString(time, workSchedule.getShift().getStartTime()) && Utils.compareTimeString(workSchedule.getShift().getEndTime(), time)) {
                // check out success
                LogEntity logInDB = logRepository.findTopByAccountAndDateOrderByTimeDesc(account, date);

                if (logInDB != null) {
                    if (logInDB.getAction() == LogType.CHECK_OUT) {
                        return new ResponseAPI<>(400, "Bạn đã check out rồi", null);
                    }
                }

                LogEntity logEntity = new LogEntity();
                logEntity.setAccount(account);
                logEntity.setDate(date);
                logEntity.setTime(time);
                logEntity.setAction(LogType.CHECK_OUT);
                logEntity.setStatus(true);
                logRepository.save(logEntity);

                workSchedule.setIsCheckout(true);
                workScheduleRepository.save(workSchedule);
                return new ResponseAPI<>(200, "Check-out thành công!", null);
            }
        }

        return new ResponseAPI<>(400, "Lỗi không xác định", null);
    }

    @GetMapping("/get-all-log")
    public ResponseAPI<?> getAllLog(@RequestParam Long accountId) {

        if (accountId == null) {
            List<LogEntity> logEntities = logRepository.findAll();
            List<LogDTO> logDTOS = LogConverter.toDtoList(logEntities);

            return new ResponseAPI<>(200, "Success", logDTOS);
        }

        AccountEntity account = accountRepository.findById(accountId);
        List<LogEntity> logEntities = logRepository.findAllByAccountOrderByCreatedDateDesc(account);
        List<LogDTO> logDTOS = LogConverter.toDtoList(logEntities);

        return new ResponseAPI<>(200, "Success", logDTOS);
    }

    @PostMapping("/delete")
    public ResponseAPI<?> deleteLog(@RequestBody  List<Long> logIds) {
        for (Long logId : logIds) {
            logRepository.delete(logId);
        }
        return new ResponseAPI<>(200, "Success", null);
    }

}
