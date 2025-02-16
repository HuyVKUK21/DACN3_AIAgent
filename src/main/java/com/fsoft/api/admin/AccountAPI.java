package com.fsoft.api.admin;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fsoft.converter.AccountConverter;
import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.BaseDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.entity.AccountEntity;
import com.fsoft.repository.AccountRepository;
import com.fsoft.response.ResponseAPI;
import com.fsoft.service.IAccountService;

//HTTP method:
//4 method : POST - đưa dữ liệu lên
//			PUT - cập nhật dữ liệu
//			DELETE - xóa dữ liệu
//			GET - Lấy dữ liệu
//mail rule : url phải là danh từ

//Muốn gọi API trong HTML dùng Ajax

@RestController
@RequestMapping("/api/admin")
public class AccountAPI {

	private static final Logger logger = Logger.getLogger(AccountAPI.class);

	@Autowired
	private IAccountService iAccountService;


	@GetMapping("/test")
	public ResponseEntity<ResponseAPI<BaseDTO<AccountDTO>>> getData() {
		try {

			BaseDTO<AccountDTO> baseDTO = new BaseDTO<>();

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {
			// Xử lý lỗi chung
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@GetMapping("/data")
	public ResponseEntity<ResponseAPI<BaseDTO<AccountDTO>>> getListData(
			@RequestParam(name = "sort", defaultValue = "0") int sort,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit) {
		try {

			BaseDTO<AccountDTO> baseDTO = new BaseDTO<>();

			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(iAccountService.getTotalItem());
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			if(sort == 0) {
				baseDTO.setListResult(iAccountService.findAll(pageable));
			}
			else {
				baseDTO.setListResult(iAccountService.findAllDesc(pageable));
			}
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {

			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@PostMapping("/delete")
	public ResponseEntity<?> deleteUser(@RequestBody long[] ids) {
		logger.info(ids.length);
	
		try {
			iAccountService.deleteAdmins(ids);
			return ResponseEntity.ok("Xóa thành công.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Đã xảy ra lỗi khi xóa.");
		}
	}

	@GetMapping("/search")
	public ResponseEntity<ResponseAPI<BaseDTO<AccountDTO>>> getSearchData(@RequestParam String name,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "3") int limit) {

		try {

			BaseDTO<AccountDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(iAccountService.countByUsernameLike(name));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);

			baseDTO.setListResult(iAccountService.findByUsernameContaining(name,pageable));

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}
	
	@GetMapping("/filter")
	public ResponseEntity<ResponseAPI<BaseDTO<AccountDTO>>> getFilterData(@RequestParam Long roleId,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "3") int limit) {

		try {
			BaseDTO<AccountDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(iAccountService.countUsersByRoleId(roleId));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			
			Pageable pageable = new PageRequest(page - 1, limit);

			baseDTO.setListResult(iAccountService.findUsersByRoleId(roleId, pageable));
			
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}
}
