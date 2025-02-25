package com.fsoft.api.admin;

import java.util.Arrays;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fsoft.dto.BaseDTO;
import com.fsoft.dto.ProductBestSellerDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.response.ResponseAPI;
import com.fsoft.service.IProductService;

@RestController
@RequestMapping("/api/product")
public class ProductAPI {

	@Autowired
	private IProductService productService;

	private static final Logger logger = Logger.getLogger(ProductAPI.class);

	@GetMapping("/data")
	public ResponseEntity<ResponseAPI<BaseDTO<ProductDTO>>> getData(
			@RequestParam(name = "sort", defaultValue = "0") int sort,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit) {
		try {
			BaseDTO<ProductDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(productService.getTotalItem());
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			baseDTO.setListResult(productService.findAll(pageable));

			if (sort == 0) {
				baseDTO.setListResult(productService.findAll(pageable));
			} else {
				baseDTO.setListResult(productService.findAllDesc(pageable));
			}
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@PostMapping("/delete")
	public ResponseEntity<?> deleteUser(@RequestBody int[] ids) {
		logger.info("Deleting products with IDs: " + Arrays.toString(ids));
		try {
			productService.deleteProduct(ids);
			return ResponseEntity.ok("Xóa thành công.");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Đã xảy ra lỗi khi xóa.");
		}
	}



	@GetMapping("/filter")
	public ResponseEntity<ResponseAPI<BaseDTO<ProductDTO>>> filterDataByCategory(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit, @RequestParam int categoryId) {
		try {
			BaseDTO<ProductDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(productService.countProductByCategoryId(categoryId));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			baseDTO.setListResult(productService.findProductByCategoryId(categoryId, pageable));
			System.out.println(productService.countProductByCategoryId(categoryId));
			System.out.println(productService.findProductByCategoryId(categoryId, pageable));
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@GetMapping("/filterByStatus")
	public ResponseEntity<ResponseAPI<BaseDTO<ProductDTO>>> filterDataByStatus(
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit, @RequestParam int status) {
		try {
			BaseDTO<ProductDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(productService.countProductByStatus(status));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			baseDTO.setListResult(productService.findProductByStatus(status, pageable));
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@GetMapping("/search")
	public ResponseEntity<ResponseAPI<BaseDTO<ProductDTO>>> getSearchData(@RequestParam String productName,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "3") int limit) {

		try {
			BaseDTO<ProductDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(productService.countByProductNameLike(productName));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);

			baseDTO.setListResult(productService.findByProductNameContaining(productName, pageable));

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}

	@GetMapping("/dataProductBestSeller")
	public ResponseEntity<ResponseAPI<BaseDTO<ProductBestSellerDTO>>> getProductData(
			@RequestParam(name = "startDate", defaultValue = "1") String startDate,
			@RequestParam(name = "endDate", defaultValue = "1") String endDate,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit) {
		try {
			BaseDTO<ProductBestSellerDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(productService.countByProductBestSeller(startDate, endDate));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);
			baseDTO.setListResult(productService.dataProductBestSeller(startDate, endDate, pageable));
			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));
		} catch (Exception e) {
			System.out.println(e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}
	
	@GetMapping("/searchBestSeller")
	public ResponseEntity<ResponseAPI<BaseDTO<ProductBestSellerDTO>>> getSearchDataBestSeller(@RequestParam String productName,
			@RequestParam(name = "startDate", defaultValue = "1") String startDate,
			@RequestParam(name = "endDate", defaultValue = "1") String endDate,
			@RequestParam(name = "page", defaultValue = "1") int page,
			@RequestParam(name = "limit", defaultValue = "5") int limit) {

		try {

			BaseDTO<ProductBestSellerDTO> baseDTO = new BaseDTO<>();
			baseDTO.setPage(page);
			baseDTO.setLimit(limit);
			baseDTO.setTotalItem(productService.countByProductNameLike(startDate, endDate, productName));
			baseDTO.setTotalPage((int) Math.ceil((double) baseDTO.getTotalItem() / baseDTO.getLimit()));
			Pageable pageable = new PageRequest(page - 1, limit);

			baseDTO.setListResult(productService.findByProductNameContain(startDate, endDate, productName,pageable));

			return ResponseEntity.ok(new ResponseAPI<>(HttpStatus.OK.value(), "Thành Công !", baseDTO));

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ResponseAPI<>(HttpStatus.INTERNAL_SERVER_ERROR.value(), "Lỗi máy chủ", null));
		}
	}


}
