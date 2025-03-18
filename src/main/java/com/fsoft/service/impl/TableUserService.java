package com.fsoft.service.impl;

import java.io.InputStream;
import java.util.List;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.domain.Specifications;
import org.springframework.stereotype.Service;

import com.fsoft.converter.TableOrderConverter;
import com.fsoft.converter.TableUserConverter;
import com.fsoft.dto.TableOrderDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.ProductEntity;
import com.fsoft.entity.TableOrderEntity;
import com.fsoft.entity.TableUserEntity;
import com.fsoft.repository.ProductRepository;
import com.fsoft.repository.TableOrderRepository;
import com.fsoft.repository.TableUserRepository;
import com.fsoft.response.TableCountResponse;
import com.fsoft.response.TableOrderResponse;
import com.fsoft.service.ITableUserService;

@Service
public class TableUserService implements ITableUserService {

	private static final Logger logger = Logger.getLogger(TableUserService.class);

	@Autowired
	TableUserConverter tableUserConverter;
	@Autowired
	TableOrderConverter tableOrderConverter;

	@Autowired
	TableUserRepository tableUserRepository;

	@Autowired
	TableOrderRepository tableOrderRepository;

	@Autowired
	ProductRepository productRepository;

	@Autowired
	private TableUserRepository repo;

	@Override
	public void saveDataExcel(InputStream inputStream) {
		try {
			List<TableUserDTO> tableUserDTOs = tableUserConverter.parseExcelFile(inputStream);
			logger.info("Parsed data: " + tableUserDTOs);
			List<TableUserEntity> userEntities = tableUserConverter.toListEntity(tableUserDTOs);
			tableUserRepository.save(userEntities);
		} catch (Exception e) {
			logger.error("Error parsing Excel file", e);
		}
	}

	@Override
	public List<TableUserDTO> findListTableUser() {
		// TODO Auto-generated method stub
		List<TableUserEntity> userEntities = tableUserRepository.findAll();
		return tableUserConverter.toListDTO(userEntities);
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) tableUserRepository.count();
	}

	@Override
	public List<TableUserDTO> findAll(Pageable pageable) {
		Sort sort = new Sort(Sort.Direction.ASC, "tableUserName");
		Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
		return tableUserConverter.toListDTO(tableUserRepository.findAll(sortedByName).getContent());
	}

	@Override
	public List<String> getListTableUserGroup() {
		// TODO Auto-generated method stub
		return tableUserRepository.findDistinctTableUserGroups();
	}

	@Override
	public List<TableUserDTO> getList(Pageable pageable) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateStatus(int userTableID, int tableUserStatus) {
		// TODO Auto-generated method stub
		TableUserEntity entity = tableUserRepository.findOne(userTableID);
		entity.setTableUserStatus(tableUserStatus);
		tableUserRepository.save(entity);
	}

	public Specification<TableUserEntity> hasTableUserGroup(String tableUserGroup) {
		return (root, query, criteriaBuilder) -> {
			if ("All".equals(tableUserGroup)) {
				return criteriaBuilder.conjunction();
			} else {
				return criteriaBuilder.equal(root.get("tableUserGroup"), tableUserGroup);
			}
		};
	}

	public Specification<TableUserEntity> hasTableUserStatus(int tableUserStatus) {
		return (root, query, criteriaBuilder) -> {
			if (tableUserStatus == 2) {
				return criteriaBuilder.conjunction();
			} else {
				return criteriaBuilder.equal(root.get("tableUserStatus"), tableUserStatus);
			}
		};
	}

	@Override
	public List<TableUserDTO> findAll(Pageable pageable, String tableUserGroup, int tableUserStatus) {
		Specification<TableUserEntity> spec = Specifications.where(hasTableUserGroup(tableUserGroup))
				.and(hasTableUserStatus(tableUserStatus));

		return tableUserConverter.toListDTO(tableUserRepository.findAll(spec, pageable).getContent());
	}

	@Override
	public Integer getTotalItem(String tableUserGroup, int tableUserStatus) {
		// TODO Auto-generated method stub
		Specification<TableUserEntity> spec = Specifications.where(hasTableUserGroup(tableUserGroup))
				.and(hasTableUserStatus(tableUserStatus));
		return (int) tableUserRepository.count(spec);
	}

	@Override
	public TableUserDTO insert(TableUserDTO tableUserDTO) {
		TableUserEntity tableUserEntity = tableUserConverter.toEntity(tableUserDTO);
		tableUserEntity = repo.save(tableUserEntity);
		tableUserDTO = tableUserConverter.toDto(tableUserEntity);
		return tableUserDTO;

	}

	@Override
	public List<TableOrderDTO> handleTableOrder(TableOrderResponse tableOrderResponse) {
		// TODO Auto-generated method stub
		TableOrderEntity tableOrderEntity = tableOrderRepository.findByProduct_ProductIdAndTableUser_UserTableID(
				tableOrderResponse.getProductId(), tableOrderResponse.getUserTableID());
		if (tableOrderEntity != null) {
			tableOrderEntity.setOrderQuantity(tableOrderEntity.getOrderQuantity() + 1);
		} else {
			tableOrderEntity = new TableOrderEntity();
			ProductEntity productEntity = productRepository.findOne(tableOrderResponse.getProductId());
			TableUserEntity tableUserEntity = tableUserRepository.findOne(tableOrderResponse.getUserTableID());
			tableOrderEntity.setOrderQuantity(tableOrderResponse.getOrderQuantity());
			tableOrderEntity.setProduct(productEntity);
			tableOrderEntity.setTableUser(tableUserEntity);

		}
		tableOrderRepository.save(tableOrderEntity);
		logger.info(tableOrderEntity);

		List<TableOrderDTO> tableOrderDTOs = tableOrderConverter
				.toListDTO(tableOrderRepository.findByTableUser_UserTableID(tableOrderResponse.getUserTableID()));
		return tableOrderDTOs;

	}

	public void deleteTableUsers(int[] ids) {
		for (int id : ids) {
			try {
				deleteTableUser(id);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	@Override
	public String deleteTableUser(int id) throws Exception {
		TableUserEntity tableUser = tableUserRepository.findByUserTableID(id);

		try {
			tableUserRepository.delete(tableUser);
			logger.info("User deleted successfully: " + tableUser);
		} catch (Exception e) {
			logger.error("Error delete: " + e.getMessage());
			throw new RuntimeException("Error deleting user: " + e.getMessage(), e);
		}
		return "success";
	}

	@Override
	public TableUserEntity findTableUserEntityByID(int userTableID) {
		// TODO Auto-generated method stub
		return tableUserRepository.findOne(userTableID);
	}

	@Override
	public List<TableUserDTO> getListTableActive() {
		// TODO Auto-generated method stub
		return tableUserConverter.toListDTO(tableUserRepository.findByTableUserStatus(1));
	}

	@Override
	public TableCountResponse getCountTable() {
		int tableUsed = tableUserRepository.countByTableUserStatus();
		int totalTables = (int) tableUserRepository.count(); // Đếm tổng số bàn
		return new TableCountResponse(tableUsed, totalTables);
	}

	@Override
	public List<TableUserDTO> findByTableUserNameContaining(String tableUserName, Pageable pageable) {
		// TODO Auto-generated method stub
		return tableUserConverter.toListDTO(tableUserRepository.findByTableUserNameContaining(tableUserName, pageable));
	}

	@Override
	public int countByTableUserNameLike(String tableUserName) {
		return tableUserRepository.countByTableUserNameLike("%" + tableUserName + "%");
	}

	@Override
	public List<TableUserDTO> ascendingSort(Pageable pageable, String nameSort) {
		Sort sort = new Sort(Sort.Direction.ASC, nameSort);
		Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
		return tableUserConverter.toListDTO(tableUserRepository.findAll(sortedByName).getContent());
	}

	@Override
	public List<TableUserDTO> descendingSort(Pageable pageable, String nameSort) {
		Sort sort = new Sort(Sort.Direction.DESC, nameSort);
		Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
		return tableUserConverter.toListDTO(tableUserRepository.findAll(sortedByName).getContent());
	}

	@Override
	public List<TableUserDTO> findByTableUserGroupContaining(String tableUserGroup, Pageable pageable) {
		// TODO Auto-generated method stub
		return tableUserConverter
				.toListDTO(tableUserRepository.findByTableUserGroupContaining(tableUserGroup, pageable));
	}

	@Override
	public int countByTableUserGroupLike(String tableUserGroup) {
		// TODO Auto-generated method stub
		return tableUserRepository.countByTableUserGroupLike("%" + tableUserGroup + "%");
	}

	@Override
	public TableUserDTO update(TableUserDTO tableUserDTO) {
		TableUserEntity tableUserEntity = tableUserConverter.toEntity(tableUserDTO);

		if (tableUserEntity.getUserTableID() != 0) {
			Optional<TableUserEntity> existingTableUser = Optional
					.ofNullable(tableUserRepository.findByUserTableID(tableUserEntity.getUserTableID()));

			if (existingTableUser.isPresent()) {
				TableUserEntity updatedTableUser = existingTableUser.get();
				updatedTableUser.setTableUserName(tableUserEntity.getTableUserName());
				updatedTableUser.setTableUserGroup(tableUserEntity.getTableUserGroup());
				updatedTableUser.setTableUserIndex(tableUserEntity.getTableUserIndex());
				updatedTableUser.setTableUserStatus(tableUserEntity.getTableUserStatus());
				updatedTableUser.setTableUserNote(tableUserEntity.getTableUserNote());
				updatedTableUser.setTableNumberOfChair(tableUserEntity.getTableNumberOfChair());

				// Lưu bản ghi đã cập nhật
				tableUserEntity = tableUserRepository.save(updatedTableUser);
			} else {
				throw new EntityNotFoundException("TableUser with id " + tableUserDTO.getUserTableID() + " not found");
			}
		} else {
			throw new IllegalArgumentException("TableUser ID cannot be null");
		}

		return tableUserConverter.toDto(tableUserEntity);
	}

	@Override
	public List<TableUserDTO> findAll() {
		// TODO Auto-generated method stub
		return tableUserConverter.toListDTO(tableUserRepository.findAll());
	}

	@Override
	public TableUserDTO findByID(int userTableID) {
		// TODO Auto-generated method stub
		TableUserDTO tableUserDTO = new TableUserDTO();
		TableUserEntity userTableEntity = tableUserRepository.findOne(userTableID);
		tableUserDTO = tableUserConverter.toDto(userTableEntity);
		return tableUserDTO;
	}

}
