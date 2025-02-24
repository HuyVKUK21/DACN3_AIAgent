package com.fsoft.entity;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "tbl_week_schedule")
public class WeekSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String startDate;
    private String endDate;
    @OneToMany(mappedBy = "weekSchedule", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<WorkScheduleEntity> workSchedules;

    public WeekSchedule() {
    }

    public WeekSchedule(String startDate, String endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public List<WorkScheduleEntity> getWorkSchedules() {
        return workSchedules;
    }

    public void setWorkSchedules(List<WorkScheduleEntity> workSchedules) {
        this.workSchedules = workSchedules;
    }
}

