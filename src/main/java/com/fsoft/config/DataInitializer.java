package com.fsoft.config;

import java.util.Arrays;

import javax.persistence.EntityManager;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import com.fsoft.entity.AccountEntity;
import com.fsoft.entity.Role;
import com.fsoft.entity.ShiftEntity;
import com.fsoft.enums.ShiftType;
import com.fsoft.repository.AccountRepository;
import com.fsoft.repository.RoleRepository;
import com.fsoft.repository.ShiftRepository;
import com.fsoft.service.IAccountService;
import com.fsoft.service.impl.AccountService;
import com.fsoft.utils.Log;

@Component
public class DataInitializer implements InitializingBean {

	@Autowired
	private IAccountService accountService;
	@Autowired
	ShiftRepository shiftRepository;

	@Transactional
	@Override
	public void afterPropertiesSet() throws Exception {
		
		// TODO Auto-generated method stub
		accountService.createDefautRole();
		accountService.createDefautAdmin();
		if (shiftRepository.count() == 0) {
			ShiftEntity shiftEntityMorning = new ShiftEntity();
			shiftEntityMorning.setId(1L);
			shiftEntityMorning.setShiftType(ShiftType.MORNING);
			shiftEntityMorning.setStartTime("08:00");
			shiftEntityMorning.setEndTime("13:00");
			shiftEntityMorning.setSalary(100000);
			shiftEntityMorning.setMaxEmployee(3);
			shiftRepository.save(shiftEntityMorning);

			ShiftEntity shiftEntityAfternoon = new ShiftEntity();
			shiftEntityAfternoon.setId(2L);
			shiftEntityAfternoon.setShiftType(ShiftType.AFTERNOON);
			shiftEntityAfternoon.setStartTime("13:00");
			shiftEntityAfternoon.setEndTime("18:00");
			shiftEntityAfternoon.setSalary(100000);
			shiftEntityAfternoon.setMaxEmployee(3);
			shiftRepository.save(shiftEntityAfternoon);

			ShiftEntity shiftEntityEvening = new ShiftEntity();
			shiftEntityEvening.setShiftType(ShiftType.EVENING);
			shiftEntityEvening.setStartTime("18:00");
			shiftEntityEvening.setEndTime("23:00");
			shiftEntityEvening.setSalary(100000);
			shiftEntityEvening.setMaxEmployee(3);
			shiftRepository.save(shiftEntityEvening);

		}
		
	}

}
