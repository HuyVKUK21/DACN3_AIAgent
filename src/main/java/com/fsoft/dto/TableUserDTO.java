package com.fsoft.dto;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class TableUserDTO extends BaseDTO<TableUserDTO>{
    private int userTableID;
    private String tableUserName;
    private String tableUserGroup;
    private String tableNumberOfChair;
    private int tableUserStatus;
    private int tableUserIndex;
    private String tableUserNote;

    // Constructors
    public TableUserDTO() {}

	public TableUserDTO(int userTableID, String tableUserName, String tableUserGroup, String tableNumberOfChair,
			int tableUserStatus, int tableUserIndex, String tableUserNote) {
		super();
		this.userTableID = userTableID;
		this.tableUserName = tableUserName;
		this.tableUserGroup = tableUserGroup;
		this.tableNumberOfChair = tableNumberOfChair;
		this.tableUserStatus = tableUserStatus;
		this.tableUserIndex = tableUserIndex;
		this.tableUserNote = tableUserNote;
	}

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

	public int getTableUserStatus() {
		return tableUserStatus;
	}

	public void setTableUserStatus(int tableUserStatus) {
		this.tableUserStatus = tableUserStatus;
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


	
	
    
    
    
    

    
}
