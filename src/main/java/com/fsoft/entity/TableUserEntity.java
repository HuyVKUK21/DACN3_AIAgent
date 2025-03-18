package com.fsoft.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "tbl_table_user")
public class TableUserEntity extends BaseEnity{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "table_user_id")
    private int userTableID;

    @Column(name = "table_user_name", columnDefinition = "varchar(256)", nullable = false)
    private String tableUserName;

    @Column(name = "table_user_status", columnDefinition = "int(1)", nullable = false)
    private int tableUserStatus;
    
    @Column(name = "table_user_group", columnDefinition = "varchar(256)", nullable = false)
    private String tableUserGroup;
    
    @Column(name = "table_user_of_chair", columnDefinition = "int(10)", nullable = true)
    private String tableNumberOfChair;
    
    @Column(name = "table_user_index", columnDefinition = "int(10)", nullable = false)
    private int tableUserIndex;
    
    @Column(name = "table_user_note", columnDefinition = "text", nullable = true)
    private String tableUserNote;
    
	@OneToMany(mappedBy = "tableUser")
	@JsonIgnore
	private List<TableOrderEntity> tableOrderEntities = new ArrayList<>();
	
	@OneToMany(mappedBy = "tableUser")
	@JsonIgnore
	private List<OrderEntity> orderEntities = new ArrayList<>();
	
    
    // Constructors
    public TableUserEntity() {}

	public int getUserTableID() {
		return userTableID;
	}

	public void setUserTableID(int userTableID) {
		this.userTableID = userTableID;
	}

	public String getTableUserName() {
		return tableUserName;
	}

	public void setTableUserName(String tableUserName) {
		this.tableUserName = tableUserName;
	}

	public int getTableUserStatus() {
		return tableUserStatus;
	}

	public void setTableUserStatus(int tableUserStatus) {
		this.tableUserStatus = tableUserStatus;
	}

	public String getTableUserGroup() {
		return tableUserGroup;
	}

	public void setTableUserGroup(String tableUserGroup) {
		this.tableUserGroup = tableUserGroup;
	}

	public String getTableNumberOfChair() {
		return tableNumberOfChair;
	}

	public void setTableNumberOfChair(String tableNumberOfChair) {
		this.tableNumberOfChair = tableNumberOfChair;
	}

	public int getTableUserIndex() {
		return tableUserIndex;
	}

	public void setTableUserIndex(int tableUserIndex) {
		this.tableUserIndex = tableUserIndex;
	}

	public String getTableUserNote() {
		return tableUserNote;
	}

	public void setTableUserNote(String tableUserNote) {
		this.tableUserNote = tableUserNote;
	}

	public List<TableOrderEntity> getTableOrderEntities() {
		return tableOrderEntities;
	}

	public void setTableOrderEntities(List<TableOrderEntity> tableOrderEntities) {
		this.tableOrderEntities = tableOrderEntities;
	}

	public List<OrderEntity> getOrderEntities() {
		return orderEntities;
	}

	public void setOrderEntities(List<OrderEntity> orderEntities) {
		this.orderEntities = orderEntities;
	}


    

    
    
}
