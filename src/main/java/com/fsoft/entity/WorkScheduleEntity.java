package com.fsoft.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Entity
@Table(name = "tbl_work_schedule")
public class WorkScheduleEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "work_date")
    @Temporal(TemporalType.DATE)
    private Date date;

    @Column(name = "work_is_active")
    private Boolean isActive;

    @Column(name = "work_is_checkin")
    private Boolean isCheckin;

    @Column(name = "work_is_checkout")
    private Boolean isCheckout;

    @ManyToOne
    @JoinColumn(name = "shift_id")
    private ShiftEntity shift;

    @ManyToOne
    @JoinColumn(name = "account_id")
    private AccountEntity account;

    @ManyToOne
    @JoinColumn(name = "week_schedule_id")
    @JsonIgnore
    private WeekSchedule weekSchedule;


    
    
   
    public WorkScheduleEntity() {
		super();
	}



	public WorkScheduleEntity(Long id, Date date, Boolean isActive, Boolean isCheckin, Boolean isCheckout,
			ShiftEntity shift, AccountEntity account, WeekSchedule weekSchedule) {
		super();
		this.id = id;
		this.date = date;
		this.isActive = isActive;
		this.isCheckin = isCheckin;
		this.isCheckout = isCheckout;
		this.shift = shift;
		this.account = account;
		this.weekSchedule = weekSchedule;
	}





	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public Date getDate() {
		return date;
	}



	public void setDate(Date date) {
		this.date = date;
	}



	public Boolean getIsActive() {
		return isActive;
	}



	public void setIsActive(Boolean isActive) {
		this.isActive = isActive;
	}



	public Boolean getIsCheckin() {
		return isCheckin;
	}



	public void setIsCheckin(Boolean isCheckin) {
		this.isCheckin = isCheckin;
	}



	public Boolean getIsCheckout() {
		return isCheckout;
	}



	public void setIsCheckout(Boolean isCheckout) {
		this.isCheckout = isCheckout;
	}



	public ShiftEntity getShift() {
		return shift;
	}



	public void setShift(ShiftEntity shift) {
		this.shift = shift;
	}



	public AccountEntity getAccount() {
		return account;
	}



	public void setAccount(AccountEntity account) {
		this.account = account;
	}



	public WeekSchedule getWeekSchedule() {
		return weekSchedule;
	}



	public void setWeekSchedule(WeekSchedule weekSchedule) {
		this.weekSchedule = weekSchedule;
	}



	public void setDate(String date) {
        Date date_work = new Date();
        try {
            date_work = new SimpleDateFormat("yyyy-MM-dd").parse(date);
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }
        this.date = date_work;
    }



	@Override
	public String toString() {
		return "WorkScheduleEntity [id=" + id + ", date=" + date + ", isActive=" + isActive + ", isCheckin=" + isCheckin
				+ ", isCheckout=" + isCheckout + ", shift=" + shift + ", account=" + account + ", weekSchedule="
				+ weekSchedule + "]";
	}
	
	

}
