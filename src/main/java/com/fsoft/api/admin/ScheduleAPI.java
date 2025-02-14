package com.fsoft.api.admin;

import com.fsoft.converter.WeekScheduleConverter;
import com.fsoft.dto.WeekScheduleDTO;
import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.WeekSchedule;
import com.fsoft.entity.WorkScheduleEntity;
import com.fsoft.response.ResponseAPI;
import com.fsoft.service.IAccountService;
import com.fsoft.service.IShiftService;
import com.fsoft.service.IWeekSchedule;
import com.fsoft.service.IWorkScheduleService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/schedule")
public class ScheduleAPI {

    @Autowired
    private IWeekSchedule weekScheduleService;

    @Autowired
    private IAccountService accountService;

    @Autowired
    private IShiftService shiftService;

    @Autowired
    private IWorkScheduleService workScheduleService;

    @GetMapping("/data")
    public ResponseAPI<WeekScheduleDTO> getData(@RequestParam("startDate") String monday, @RequestParam("endDate") String sunday) {

        if (monday == null || sunday == null) {
            monday = LocalDate.now().with(DayOfWeek.MONDAY).toString();
            sunday = LocalDate.now().with(DayOfWeek.SUNDAY).toString();
        }
        WeekSchedule weekSchedule = weekScheduleService.findByStartDateAndEndDate(monday, sunday);

        return new ResponseAPI<>(200, "Successfully", WeekScheduleConverter.toDTO(weekSchedule));
    }

    @GetMapping("/dataEmployee")
    public ResponseAPI<WeekScheduleDTO> getDataEmployee(@RequestParam("startDate") String monday, @RequestParam("endDate") String sunday) {

        if (monday == null || sunday == null) {
            monday = LocalDate.now().with(DayOfWeek.MONDAY).toString();
            sunday = LocalDate.now().with(DayOfWeek.SUNDAY).toString();
        }
        WeekSchedule weekSchedule = weekScheduleService.findByStartDateAndEndDateEmployee(monday, sunday);

        return new ResponseAPI<>(200, "Successfully", WeekScheduleConverter.toDTO(weekSchedule));
    }

    @PostMapping("/save")
    public ResponseAPI<WeekScheduleDTO> save(@RequestParam("schedule") String schedule,
                                             @RequestParam("startDate") String startDate,
                                             @RequestParam("endDate") String endDate) {

        JSONObject scheduleObject = new JSONObject(schedule);

        WeekSchedule weekSchedule = weekScheduleService.findByStartDateAndEndDate(startDate, endDate);
        if (weekSchedule == null) {
            weekSchedule = new WeekSchedule(startDate, endDate);

            weekSchedule = weekScheduleService.save(weekSchedule);
        }
        workScheduleService.deleteByWeekSchedule(weekSchedule);

        Map<String, Object> map = scheduleObject.toMap();
        for (Map.Entry<String, Object> day : map.entrySet()) {
            for (Map.Entry<String, Object> shift : ((Map<String, Object>) day.getValue()).entrySet()) {
                for (String employeeId : (List<String>) shift.getValue()) {
                    AccountEntity account = accountService.findByIdAndRoles_name(Long.parseLong(employeeId), "ROLE_EMPLOYEE");
                    WorkScheduleEntity workScheduleEntity = new WorkScheduleEntity();
                    workScheduleEntity.setDate(day.getKey());
                    workScheduleEntity.setShift(shiftService.findById(Long.parseLong(shift.getKey())));
                    workScheduleEntity.setAccount(account);
                    workScheduleEntity.setWeekSchedule(weekSchedule);
                    workScheduleEntity.setIsActive(true);
                    workScheduleEntity.setIsCheckin(false);
                    workScheduleEntity.setIsCheckout(false);

                    // save work schedule
                    workScheduleService.save(workScheduleEntity);
                }
            }
        }
        weekSchedule.setWorkSchedules(workScheduleService.findByStartDateAndEndDate(String.valueOf(startDate), String.valueOf(endDate)));
        weekScheduleService.save(weekSchedule);

        // return OK status code and message
        return new ResponseAPI<>(200, "Successfully", WeekScheduleConverter.toDTO(weekSchedule));
    }
    @PostMapping("/register")
    public ResponseAPI<WeekScheduleDTO> register(@RequestParam("schedule") String schedule,
                                             @RequestParam("startDate") String startDate,
                                             @RequestParam("endDate") String endDate, @RequestParam("accountId") Long accountId) {

        JSONObject scheduleObject = new JSONObject(schedule);

        WeekSchedule weekSchedule = weekScheduleService.findByStartDateAndEndDate(startDate, endDate);
        if (weekSchedule == null) {
            weekSchedule = new WeekSchedule(startDate, endDate);

            weekSchedule = weekScheduleService.save(weekSchedule);
        }
        workScheduleService.deleteByWeekScheduleAndAccountId(weekSchedule, accountId);

        Map<String, Object> map = scheduleObject.toMap();
        for (Map.Entry<String, Object> day : map.entrySet()) {
            for (Map.Entry<String, Object> shift : ((Map<String, Object>) day.getValue()).entrySet()) {
                for (String employeeId : (List<String>) shift.getValue()) {
                    AccountEntity account = accountService.findByIdAndRoles_name(Long.parseLong(employeeId), "ROLE_EMPLOYEE");
                    WorkScheduleEntity workScheduleEntity = new WorkScheduleEntity();
                    workScheduleEntity.setDate(day.getKey());
                    workScheduleEntity.setShift(shiftService.findById(Long.parseLong(shift.getKey())));
                    workScheduleEntity.setAccount(account);
                    workScheduleEntity.setWeekSchedule(weekSchedule);
                    workScheduleEntity.setIsCheckin(false);
                    workScheduleEntity.setIsCheckout(false);
                    workScheduleEntity.setIsActive(false);

                    // save work schedule
                    workScheduleService.save(workScheduleEntity);
                }
            }
        }
        weekSchedule.setWorkSchedules(workScheduleService.findByStartDateAndEndDate(String.valueOf(startDate), String.valueOf(endDate)));
        weekScheduleService.save(weekSchedule);

        // return OK status code and message
        return new ResponseAPI<>(200, "Successfully", WeekScheduleConverter.toDTO(weekSchedule));
    }


}
