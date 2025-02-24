package com.fsoft.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


public class WorkScheduleDTO {
    private Long id;
    private String date;
    private ShiftDTO shift;
    private AccountDTO account;
    private Boolean isActive;
    private Boolean isCheckIn;
    private Boolean isCheckOut;
	public WorkScheduleDTO() {
		super();
	}
	public WorkScheduleDTO(Long id, String date, ShiftDTO shift, AccountDTO account, Boolean isActive,
			Boolean isCheckIn, Boolean isCheckOut) {
		super();
		this.id = id;
		this.date = date;
		this.shift = shift;
		this.account = account;
		this.isActive = isActive;
		this.isCheckIn = isCheckIn;
		this.isCheckOut = isCheckOut;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public ShiftDTO getShift() {
		return shift;
	}
	public void setShift(ShiftDTO shift) {
		this.shift = shift;
	}
	public AccountDTO getAccount() {
		return account;
	}
	public void setAccount(AccountDTO account) {
		this.account = account;
	}
	public Boolean getIsActive() {
		return isActive;
	}
	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}
	public Boolean getIsCheckIn() {
		return isCheckIn;
	}
	public void setIsCheckIn(Boolean isCheckIn) {
		this.isCheckIn = isCheckIn;
	}
	public Boolean getIsCheckOut() {
		return isCheckOut;
	}
	public void setIsCheckOut(Boolean isCheckOut) {
		this.isCheckOut = isCheckOut;
	}
    
    
}
