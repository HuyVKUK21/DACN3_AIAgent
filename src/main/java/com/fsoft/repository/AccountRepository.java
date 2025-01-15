package com.fsoft.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fsoft.entity.AccountEntity;

public interface AccountRepository extends JpaRepository<AccountEntity, Long>{
	AccountEntity findByUsername(String userName);
	AccountEntity findByEmail(String email);
	AccountEntity findFirstByUsername(String username);
	AccountEntity findById(Long idUser);
	List<AccountEntity> findAll();
	List<AccountEntity> findByUsernameContaining(String username, Pageable pageable);
	int countByUsernameLike(String username);


	/*
	* FIND ALL ACCOUNT BY ROLE EMPLOYEE
	* */
	List<AccountEntity> findAllByRoles_Name(String roleName);

	/*
	* FIND ACCOUNT BY ID AND ROLE
	* */
	AccountEntity findAccountEntityByIdAndRoles_Name(Long id, String roles_name);
	
	@Query("SELECT a FROM tbl_users a JOIN a.roles r WHERE r.id = :roleId")
	List<AccountEntity> findUsersByRoleId(@Param("roleId") Long roleId, Pageable pageable);
	
    @Query("SELECT COUNT(a) FROM tbl_users a JOIN a.roles r WHERE r.id = :roleId")
    int countUsersByRoleId(@Param("roleId") Long roleId);
}
