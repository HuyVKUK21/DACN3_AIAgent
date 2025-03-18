package com.fsoft.repository;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fsoft.entity.TableUserEntity;

public interface TableUserRepository
		extends JpaRepository<TableUserEntity, Integer>, JpaSpecificationExecutor<TableUserEntity> {
	// Custom query methods can be defined here if needed
	@Query("SELECT DISTINCT t.tableUserGroup FROM TableUserEntity t")
	List<String> findDistinctTableUserGroups();

	TableUserEntity findByUserTableID(Integer userTableID);

	List<TableUserEntity> findByTableUserStatus(int status);

	// Sửa phương thức này:
	@Query("SELECT COUNT(t) FROM TableUserEntity t WHERE t.tableUserStatus = 1")
	int countByTableUserStatus();

	List<TableUserEntity> findByTableUserNameContaining(String tableUserName, Pageable pageable);

	int countByTableUserNameLike(@Param("tableUserName") String tableUserName);

	List<TableUserEntity> findByTableUserGroupContaining(String tableUserGroup, Pageable pageable);

	int countByTableUserGroupLike(@Param("tableUserGroup") String tableUserGroup);

}
