package com.fsoft.api.user;

import com.fsoft.response.ResponseAPI;
import com.fsoft.service.IWorkScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/dashboard")
public class DashboardAPI {

    @Autowired
    private IWorkScheduleService workScheduleService;

    @GetMapping("/get-salary")
    public ResponseAPI<?> getSalary(@RequestParam Long accountId, @RequestParam String startDate, @RequestParam String endDate) {
        Double salary = workScheduleService.getSalaryEmployeeByDate(accountId, startDate, endDate);
        return new ResponseAPI<>(200, "Success", salary);
    }


    @GetMapping("/get-attendance")
    public ResponseAPI<?> getAttendance(@RequestParam Long accountId, @RequestParam String startDate, @RequestParam String endDate) {
        int attendance = workScheduleService.getAttendanceEmployeeByDate(accountId, startDate, endDate);
        return new ResponseAPI<>(200, "Success", attendance);
    }

}
