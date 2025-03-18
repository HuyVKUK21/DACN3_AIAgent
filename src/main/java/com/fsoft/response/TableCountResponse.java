package com.fsoft.response;

public class TableCountResponse {
    private int tableUsed; // Số bàn đang sử dụng
    private int totalTables; // Tổng số bàn
    
	public TableCountResponse(int tableUsed, int totalTables) {
		super();
		this.tableUsed = tableUsed;
		this.totalTables = totalTables;
	}

	public TableCountResponse() {
		super();
	}

	public int getTableUsed() {
		return tableUsed;
	}

	public void setTableUsed(int tableUsed) {
		this.tableUsed = tableUsed;
	}

	public int getTotalTables() {
		return totalTables;
	}

	public void setTotalTables(int totalTables) {
		this.totalTables = totalTables;
	}
    
	
    
}