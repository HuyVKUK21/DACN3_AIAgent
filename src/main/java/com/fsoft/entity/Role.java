package com.fsoft.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;


@Entity(name = "tbl_roles")
public class Role {
	@Id 
	@GeneratedValue(strategy = GenerationType.IDENTITY) 
	private Long id;
	private String name;
	@ManyToMany(mappedBy = "roles")
	@JsonIgnore
	private List<AccountEntity> users = new ArrayList<>();
	
	public Role() {}

	public Role(Long id, String name, List<AccountEntity> users) {
		this.id = id;
		this.name = name;
		this.users = users;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<AccountEntity> getUsers() {
		return users;
	}

	public void setUsers(List<AccountEntity> users) {
		this.users = users;
	}

	
	
	
	
	
	
	
	
}
