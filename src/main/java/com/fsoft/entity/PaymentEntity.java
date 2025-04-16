package com.fsoft.entity;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "tbl_payment")
public class PaymentEntity extends BaseEnity{
    
	@Id /* Định nghĩa khóa chính và not null */
	@GeneratedValue(strategy = GenerationType.IDENTITY) /* Bật tính năng tự tăng giá trị */
	@Column (name= "payment_id", columnDefinition = "int(10)")
    private int paymentId;
	
	@Column (name= "payment_name", columnDefinition = "varchar(256)")
    private String paymentName;
	
	@Column (name= "payment_method", columnDefinition = "int(10)")
    private int paymentMethod;
	
	@Column (name= "payment_status", columnDefinition = "int(10)")
    private int paymentStatus;
	
	@OneToMany(mappedBy = "payment")
	@JsonIgnore
	private List<OrderEntity> orderEntities = new ArrayList<>();

    // Constructors
    public PaymentEntity() {}

  
    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(int paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }


	public String getPaymentName() {
		return paymentName;
	}


	public void setPaymentName(String paymentName) {
		this.paymentName = paymentName;
	}

    
    
}