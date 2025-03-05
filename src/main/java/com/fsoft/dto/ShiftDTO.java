package com.fsoft.dto;

import com.fsoft.enums.ShiftType;
import lombok.*;


public class ShiftDTO {
    private Long id;
    private ShiftType shiftType;
    private String startTime;
    private String endTime;
    private int maxEmployee;
    private double salary;
	public ShiftDTO() {
		super();
	}
	public ShiftDTO(Long id, ShiftType shiftType, String startTime, String endTime, int maxEmployee, double salary) {
		super();
		this.id = id;
		this.shiftType = shiftType;
		this.startTime = startTime;
		this.endTime = endTime;
		this.maxEmployee = maxEmployee;
		this.salary = salary;
	}
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
    
    
}
