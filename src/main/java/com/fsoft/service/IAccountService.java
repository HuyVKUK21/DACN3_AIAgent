package com.fsoft.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.AccountEntity;

@Service
public interface IAccountService {
	void saveUser(AccountDTO adminDTO) throws Exception;
	AccountEntity findByUserName(String userName);
	AccountEntity findByEmail(String email);
	List<AccountDTO> getListUser();
	String loadTableListUser();
	String updateRoleUser(Long idUser, Long idRole) throws Exception;
	AccountDTO findByID(Long id);
	String deleteAdmin(Long id) throws Exception;
	void deleteAdmins(long[] ids);
	Integer getTotalItem();
	List<AccountDTO> findAll(Pageable pageable);
	List<AccountDTO> findAllDesc(Pageable pageable);
	List<AccountDTO> findByUsernameContaining(String username, Pageable pageable);
	int countByUsernameLike(@Param("username") String username);
	AccountDTO findByUserNameDTO(String sessionUser);
	void createDefautAdmin();
	void createDefautRole();
	List<AccountDTO> findAllByRoleEmployee();
	AccountEntity findByIdAndRoles_name(Long id, String role);
	List<AccountDTO> findUsersByRoleId(Long roleId,  Pageable pageable);
	int countUsersByRoleId(Long roleId);
}
