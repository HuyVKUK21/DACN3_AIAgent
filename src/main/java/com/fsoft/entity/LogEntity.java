package com.fsoft.entity;

import com.fsoft.enums.LogType;
import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "tbl_log")
public class LogEntity extends BaseEnity{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;
    private String time;
    private String date;
    @Enumerated(EnumType.STRING)
    private LogType action;
    private Boolean status;
    @ManyToOne
    @JoinColumn(name = "account_id")
    private AccountEntity account;
    
    
    
    
	public LogEntity() {
		super();
	}
	public LogEntity(Long id, String time, String date, LogType action, Boolean status, AccountEntity account) {
		super();
		this.id = id;
		this.time = time;
		this.date = date;
		this.action = action;
		this.status = status;
		this.account = account;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
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
	public AccountEntity getAccount() {
		return account;
	}
	public void setAccount(AccountEntity account) {
		this.account = account;
	}

    
    
    

}
