package com.fsoft.api.admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.fsoft.controller.admin.TableUserController;
import com.fsoft.dto.BaseDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.dto.TableUserDTO;
import com.fsoft.response.ResponseAPI;
import com.fsoft.response.TableCountResponse;
import com.fsoft.service.ITableUserService;

@RestController
@RequestMapping("/api/tableuser")
public class TableUserAPI {

	@Autowired
	ITableUserService tableUserService;

	private static final Logger logger = Logger.getLogger(TableUserAPI.class);

	@GetMapping("/download")
	public ResponseEntity<Resource> downloadFile() throws IOException {
		Resource resource = new ClassPathResource("static/test.xlsx");
		if (!resource.exists()) {
			return ResponseEntity.notFound().build();
		}
		HttpHeaders headers = new HttpHeaders();
		headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=test.xlsx");
		return new ResponseEntity<>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/upload")
	public ResponseEntity<String> uploadFile(@RequestParam("uploadExcel") MultipartFile file) {
		try {
			if (file != null && !file.isEmpty()) {
				String fileName = file.getOriginalFilename();
				logger.info("File name: " + fileName);
				logger.info("File size: " + file.getSize() + " bytes");
				tableUserService.saveDataExcel(file.getInputStream());

				return new ResponseEntity<>("File uploaded successfully: " + fileName, HttpStatus.OK);
			} else {
				return new ResponseEntity<>("No file selected", HttpStatus.BAD_REQUEST);
			}
		} catch (Exception e) {
			logger.error("Error uploading file: ", e);
			return new ResponseEntity<>("File upload failed: " + e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/data")
	public ResponseEntity<ResponseAPI<BaseDTO<TableUserDTO>>> getData(
			@RequestParam(name = "nameSort", defaultValue = "tableUserName") String nameSort,
			@RequestParam(name = "sort", defaultValue = "0") int sort,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit) {
		try {

			BaseDTO<TableUserDTO> baseDTO = new BaseDTO<>();

			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(tableUserService.getTotalItem());
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);

			if(sort == 0) {
				baseDTO.setListResult(tableUserService.descendingSort(pageable, nameSort));
			}
			else {
				baseDTO.setListResult(tableUserService.ascendingSort(pageable, nameSort));
			}
		

			// Trả về ResponseEntity với mã trạng thái OK (200) và dữ liệu
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {
			// Xử lý lỗi chung
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@PostMapping("/delete")
	public ResponseEntity<?> deleteUser(@RequestBody int[] ids) {
		logger.info(ids.length);
		try {
			tableUserService.deleteTableUsers(ids);
			return ResponseEntity.ok("Xóa thành công.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Đã xảy ra lỗi khi xóa.");
		}
	}

	@GetMapping("/count")
	public ResponseEntity<ResponseAPI<TableCountResponse>> getCountTable() {
		try {
			TableCountResponse tableCount = tableUserService.getCountTable();
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công!", tableCount));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@GetMapping("/search")
	public ResponseEntity<ResponseAPI<BaseDTO<TableUserDTO>>> getSearchData(@RequestParam String tableUserName,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "3") int limit) {

		try {
			BaseDTO<TableUserDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(tableUserService.countByTableUserNameLike(tableUserName));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			
			baseDTO.setListResult(tableUserService.findByTableUserNameContaining(tableUserName, pageable));

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}
	
	
	@GetMapping("/filter")
	public ResponseEntity<ResponseAPI<BaseDTO<TableUserDTO>>> getFilterTableUserGroup(@RequestParam String tableUserGroup,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "3") int limit) {

		try {
			BaseDTO<TableUserDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(tableUserService.countByTableUserGroupLike(tableUserGroup));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			
			baseDTO.setListResult(tableUserService.findByTableUserGroupContaining(tableUserGroup, pageable));

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

}
