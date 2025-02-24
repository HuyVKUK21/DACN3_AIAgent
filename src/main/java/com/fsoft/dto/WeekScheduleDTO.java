package com.fsoft.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

public class WeekScheduleDTO {
    private Long id;
    private String startDate;
    private String endDate;
    private List<WorkScheduleDTO> workSchedules;
    
    public WeekScheduleDTO() {
		super();
	}
	
    
	public WeekScheduleDTO(Long id, String startDate, String endDate, List<WorkScheduleDTO> workSchedules) {
		super();
		this.id = id;
		this.startDate = startDate;
		this.endDate = endDate;
		this.workSchedules = workSchedules;
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


	public List<WorkScheduleDTO> getWorkSchedules() {
		return workSchedules;
	}


	public void setWorkSchedules(List<WorkScheduleDTO> workSchedules) {
		this.workSchedules = workSchedules;
	}



	
	
    
    
}
