package com.fsoft.api.admin;

import javax.persistence.EntityNotFoundException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fsoft.dto.AccountDTO;
import com.fsoft.dto.BaseDTO;
import com.fsoft.dto.CategoryDTO;
import com.fsoft.entity.CategoryEntity;
import com.fsoft.response.ResponseAPI;
import com.fsoft.service.ICategoryService;

@RestController
@RequestMapping("api/category")
public class CategoryAPI {
	private static final Logger logger = Logger.getLogger(CategoryAPI.class);
	
	@Autowired
	private ICategoryService iCategoryService;
	
	@PostMapping("/delete")
	public ResponseEntity<?> deleteCategory(@RequestBody int[] id) {
		try {
			iCategoryService.deleteAdmins(id);
			return ResponseEntity.ok("Xóa thành công");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Đã xảy ra lỗi khi xóa dữ liệu");
		}
	}
	
	@GetMapping("/data")
	public ResponseEntity<ResponseAPI<BaseDTO<CategoryDTO>>> getListData(
			@RequestParam(name = "sort", defaultValue = "0") int sort,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit) {
		try {

			BaseDTO<CategoryDTO> baseDTO = new BaseDTO<>();

			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(iCategoryService.getTotalItem());
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			
			if(sort == 0) {
				baseDTO.setListResult(iCategoryService.findAll(pageable));
			}
			else {
				baseDTO.setListResult(iCategoryService.findAllDesc(pageable));
			}
			
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {

			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}
	
	@GetMapping("/search")
	public ResponseEntity<ResponseAPI<BaseDTO<CategoryDTO>>> getSearchData(@RequestParam String categoryName,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "3") int limit) {

		try {

			BaseDTO<CategoryDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(iCategoryService.countByCategoryNameLike(categoryName));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);

			baseDTO.setListResult(iCategoryService.findByCategoryNameContaining(categoryName,pageable));

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}
	
	@PostMapping("/update")
	public ResponseEntity<String> updateCategoryStatus(@RequestParam("categoryId") Integer category_id, @RequestParam("categoryStatus") Integer category_status) {
	    try {
	        String result = iCategoryService.updateCategoryStatus(category_id, category_status);
	        return new ResponseEntity<>(result, HttpStatus.OK);
	    } catch (EntityNotFoundException e) {
	        return new ResponseEntity<>(e.getMessage(), HttpStatus.NOT_FOUND);
	    } catch (Exception e) {
	        e.printStackTrace();  
	        return new ResponseEntity<>("An error occurred while updating the category status", HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}



}
