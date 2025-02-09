package com.fsoft.dto;

import java.util.List;

public class OrderStatusDTO {
    private String type;
    private String tableId;
    private String message;
    private boolean isPaid;
    private List<TableOrderDTO> tableOrders; 
    
    
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public boolean getIsPaid() {
        return isPaid;
    }

    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
    }

	public List<TableOrderDTO> getTableOrders() {
		return tableOrders;
	}

	public void setTableOrders(List<TableOrderDTO> tableOrders) {
		this.tableOrders = tableOrders;
	}

	public void setPaid(boolean isPaid) {
		this.isPaid = isPaid;
	}
    
    
} 