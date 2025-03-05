package com.fsoft.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fsoft.enums.ShiftType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Set;

@Setter
@Getter
@AllArgsConstructor
@Entity
@Table(name = "tbl_shift")

public class ShiftEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "shift_id")
    private Long id;
    @Column(name = "shift_type")
    @Enumerated(EnumType.STRING)
    private ShiftType shiftType;
    @Column(name = "shift_start_time")
    private String startTime;
    @Column(name = "shift_end_time")
    private String endTime;
    @Column(name = "shift_max_employee")
    private int maxEmployee;
    @Column(name = "shift_salary")
    private double salary;

    @OneToMany(mappedBy = "shift", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JsonIgnore
    private Set<WorkScheduleEntity> workScheduleEntities;

	public ShiftEntity() {	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public ShiftType getShiftType() {
		return shiftType;
	}

	public void setShiftType(ShiftType shiftType) {
		this.shiftType = shiftType;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public int getMaxEmployee() {
		return maxEmployee;
	}

	public void setMaxEmployee(int maxEmployee) {
		this.maxEmployee = maxEmployee;
	}

	public double getSalary() {
		return salary;
	}

	public void setSalary(double salary) {
		this.salary = salary;
	}

	public Set<WorkScheduleEntity> getWorkScheduleEntities() {
		return workScheduleEntities;
	}

	public void setWorkScheduleEntities(Set<WorkScheduleEntity> workScheduleEntities) {
		this.workScheduleEntities = workScheduleEntities;
	}
    
    

}
