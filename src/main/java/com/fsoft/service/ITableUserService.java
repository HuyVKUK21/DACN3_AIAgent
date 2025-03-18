package com.fsoft.service;

import java.io.InputStream;
import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Service;

import com.fsoft.dto.TableOrderDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.TableUserEntity;
import com.fsoft.response.TableCountResponse;
import com.fsoft.response.TableOrderResponse;

@Service
public interface ITableUserService {

	void saveDataExcel(InputStream inputStream);

	List<TableUserDTO> findListTableUser();

	Integer getTotalItem();

	List<String> getListTableUserGroup();

	void updateStatus(int userTableID, int tableUserStatus);

	List<TableUserDTO> findAll(Pageable pageable, String tableUserGroup, int tableUserStatus);

	Integer getTotalItem(String tableUserGroup, int tableUserStatus);

	TableUserDTO insert(TableUserDTO tableUserDTO);

	List<TableUserDTO> getList(Pageable pageable);

	List<TableOrderDTO> handleTableOrder(TableOrderResponse tableOrderResponse);

	void deleteTableUsers(int[] ids);

	String deleteTableUser(int id) throws Exception;

	TableUserEntity findTableUserEntityByID(int userTableID);

	List<TableUserDTO> getListTableActive();

	TableCountResponse getCountTable();

	List<TableUserDTO> findByTableUserNameContaining(String tableUserName, Pageable pageable);

	int countByTableUserNameLike(@Param("tableUserName") String tableUserName);

	List<TableUserDTO> findByTableUserGroupContaining(String tableUserGroup, Pageable pageable);

	int countByTableUserGroupLike(@Param("tableUserGroup") String tableUserGroup);

	List<TableUserDTO> ascendingSort(Pageable pageable, String nameSort);

	List<TableUserDTO> descendingSort(Pageable pageable, String nameSort);

	TableUserDTO update(TableUserDTO tableUserDTO);

	List<TableUserDTO> findAll(Pageable pageable);

	List<TableUserDTO> findAll();

	TableUserDTO findByID(int userTableID);

}
