package com.fsoft.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import com.fsoft.utils.Log;

@Entity
@Table(name = "tbl_logger")
public class LoggerEntity extends BaseEnity{
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "logger_id", nullable = false)
	private Integer id;
	@Column(name = "logger_action", columnDefinition = "varchar(255)")
	private String action;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
}
