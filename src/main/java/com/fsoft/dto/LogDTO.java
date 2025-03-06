package com.fsoft.dto;

import com.fsoft.entity.AccountEntity;
import com.fsoft.enums.LogType;
import jdk.jfr.Timespan;
import lombok.*;

import java.io.Serializable;
import java.util.Date;

/**
 * DTO for {@link com.fsoft.entity.LogEntity}
 */

public class LogDTO implements Serializable {
    private Long id;
    private AccountEntity account;
    private LogType action;
    private Boolean status;
    private Date createdDate;
    
    
	public LogDTO() {
		super();
	}

	
	

	public LogDTO(Long id, AccountEntity account, LogType action, Boolean status, Date createdDate) {
		super();
		this.id = id;
		this.account = account;
		this.action = action;
		this.status = status;
		this.createdDate = createdDate;
	}




	public Long getId() {
		return id;
	}




	public void setId(Long id) {
		this.id = id;
	}




	public AccountEntity getAccount() {
		return account;
	}




	public void setAccount(AccountEntity account) {
		this.account = account;
	}




	public LogType getAction() {
		return action;
	}




	public void setAction(LogType action) {
		this.action = action;
	}




	public Boolean getStatus() {
		return status;
	}




	public void setStatus(Boolean status) {
		this.status = status;
	}




	public Date getCreatedDate() {
		return createdDate;
	}




	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}




	@Override
	public String toString() {
		return "LogDTO [id=" + id + ", account=" + account + ", action=" + action + ", status=" + status
				+ ", createdDate=" + createdDate + "]";
	}
    
    
}