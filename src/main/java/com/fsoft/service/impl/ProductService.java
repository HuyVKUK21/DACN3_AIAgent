package com.fsoft.service.impl;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import com.fsoft.converter.CategoryConverter;
import com.fsoft.converter.ProductConverter;
import com.fsoft.dto.ProductBestSellerDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.entity.CategoryEntity;
import com.fsoft.entity.ProductEntity;
import com.fsoft.repository.ProductRepository;
import com.fsoft.service.ICategoryService;
import com.fsoft.service.IProductService;

@Service
public class ProductService implements IProductService {

	private static final Logger logger = Logger.getLogger(TableUserService.class);

	ProductConverter productConverter;
	ProductRepository productRepository;
	ICategoryService iCategoryService;
	CategoryConverter categoryConverter;

	@Autowired
	public ProductService(ProductConverter productConverter, ProductRepository productRepository,
			ICategoryService iCategoryService, CategoryConverter categoryConverter) {
		this.productConverter = productConverter;
		this.productRepository = productRepository;
		this.iCategoryService = iCategoryService;
		this.categoryConverter = categoryConverter;
	}

	@Override
	public void saveProduct(ProductDTO productDTO) {
		// TODO Auto-generated method stub
		CategoryEntity categoryEntity = categoryConverter
				.toEntity(iCategoryService.findByID(productDTO.getCategoryId()));
		ProductEntity productEntity = productConverter.toEntity(productDTO);
		productEntity.setCategory(categoryEntity);
		productRepository.save(productEntity);
	}

	@Override
	public Integer getTotalItem() {
		// TODO Auto-generated method stub
		return (int) productRepository.count();
	}

	@Override
	public List<ProductDTO> findAll(Pageable pageable) {
		List<ProductDTO> productDTOs = new ArrayList<>();
		List<ProductEntity> productEntities = productRepository.findAll(pageable).getContent();
		for (ProductEntity productEntity : productEntities) {
			productDTOs.add(productConverter.toDto(productEntity));
		}
		return productDTOs;
	}

	@Override
	public List<ProductDTO> findAllByCategoryIdsAndKeysearch(List<Integer> idcategory, String keysearch,
			Pageable pageable) {
		Page<ProductEntity> productPage;
		if (keysearch == null || keysearch.isEmpty()) {
			productPage = productRepository.findByCategory_CategoryIdIn(idcategory, pageable);
		} else {
			productPage = productRepository
					.findByCategory_CategoryIdInAndProductNameContainingIgnoreCaseOrProductDescContainingIgnoreCase(
							idcategory, keysearch, keysearch, pageable);
		}
		List<ProductEntity> productList = productPage.getContent();
		return productConverter.toListDTO(productList);

	}

	@Override
	public Integer getTotalItem(List<Integer> idcategory, String keysearch) {
		if (keysearch == null || keysearch.isEmpty()) {
			return (int) productRepository.countByCategory_CategoryIdIn(idcategory);
		} else {
			return (int) productRepository
					.countByCategory_CategoryIdInAndProductNameContainingIgnoreCaseOrProductDescContainingIgnoreCase(
							idcategory, keysearch, keysearch);
		}
	}

	@Override
	@Transactional
	public void deleteProduct(int[] ids) {
		for (int id : ids) {
			try {
				deleteProduct(id);
			} catch (Exception e) {
				logger.error("Error deleting product with ID " + id + ": " + e.getMessage());
			}
		}
	}

	@Override
	public String deleteProduct(int productId) throws Exception {
		ProductEntity product = productRepository.findOne(productId);

		try {
			productRepository.delete(product);
			logger.info("Product deleted successfully: " + product);
		} catch (Exception e) {
			logger.error("Error deleting product: " + e.getMessage());
			throw new RuntimeException("Error deleting product: " + e.getMessage(), e);
		}
		return "success";
	}

	@Override
	public void updateStatus(int productId, int productStatus) {
		// TODO Auto-generated method stub
		ProductEntity entity = productRepository.findOne(productId);
		entity.setProductStatus(productStatus);
		productRepository.save(entity);

	}

	@Override
	public ProductEntity findById(int productId) {
		// TODO Auto-generated method stub
		return productRepository.findOne(productId);
	}

	@Override
	public void updateProduct(ProductDTO productDTO) {
		CategoryEntity categoryEntity = categoryConverter
				.toEntity(iCategoryService.findByID(productDTO.getCategoryId()));

		ProductEntity productEntity = productConverter.toEntity(productDTO);
		productEntity.setCategory(categoryEntity);

		// Kiểm tra nếu có ID, thực hiện cập nhật
		if (productDTO.getProductId() > 0) {
			// Tìm đối tượng sản phẩm hiện tại
			Optional<ProductEntity> existingProduct = Optional
					.ofNullable(productRepository.findOne(productDTO.getProductId()));
			if (existingProduct.isPresent()) {
				ProductEntity existingProductEntity = existingProduct.get();

				existingProductEntity.setProductName(productDTO.getProductName());
				existingProductEntity.setProductDesc(productDTO.getProductDesc());
				existingProductEntity.setProductPrice(productDTO.getProductPrice());
				existingProductEntity.setProductImage(productDTO.getProductImage());
				existingProductEntity.setCategory(categoryEntity);
				existingProductEntity.setProductStatus(productDTO.getProductStatus());

				productRepository.save(existingProductEntity);
			} else {
				throw new EntityNotFoundException("Product not found with id: " + productDTO.getProductId());
			}
		} else {
			productEntity.setCreatedBy(productDTO.getCreatedBy());
			productRepository.save(productEntity);
		}

	}



	@Override
	public List<ProductDTO> findAllDesc(Pageable pageable) {
		Sort sort = new Sort(Sort.Direction.DESC, "productName");
		Pageable sortedByName = new PageRequest(pageable.getPageNumber(), pageable.getPageSize(), sort);
		return productConverter.toListDTO(productRepository.findAll(sortedByName).getContent());
	}

	@Override
	public int countProductByStatus(int status) {
		// TODO Auto-generated method stub
		return productRepository.countProductByStatus(status);
	}

	@Override
	public List<ProductDTO> findProductByStatus(int status, Pageable pageable) {
		// TODO Auto-generated method stub
		return productConverter.toListDTO(productRepository.findProductsByStatus(status, pageable));
	}

	@Override
	public int countProductByCategoryId(int categoryId) {
		// TODO Auto-generated method stub
		return productRepository.countProductByCategory_CategoryId(categoryId);
	}

	@Override
	public List<ProductDTO> findProductByCategoryId(int categoryId, Pageable pageable) {
		// TODO Auto-generated method stub
		return productConverter.toListDTO(productRepository.findProductsByCategoryId(categoryId, pageable));
	}

	@Override
	public Integer countByProductNameLike(String productName) {
		// TODO Auto-generated method stub
		return productRepository.countByProductNameLike("%" + productName + "%");
	}

	@Override
	public List<ProductDTO> findByProductNameContaining(String productName, Pageable pageable) {
		// TODO Auto-generated method stub
		return productConverter.toListDTO(productRepository.findByProductNameContaining(productName, pageable));
	}

	@Override
	public List<ProductBestSellerDTO> findByProductNameContain(String startDateStr, String endDateStr,
			String productName, Pageable pageable) {
		// TODO Auto-generated method stub
				DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);

				LocalDate startDate = LocalDate.parse(startDateStr, dateFormatter);
				LocalDate endDate = LocalDate.parse(endDateStr, dateFormatter);

				LocalDateTime startDateTime = startDate.atStartOfDay();
				LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

				Date startDateDate = Date.from(startDateTime.atZone(ZoneId.systemDefault()).toInstant());
				Date endDateDate = Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant());

				return productRepository.findByProductNameContain(startDateDate, endDateDate, productName, pageable);
	}

	@Override
	public int countByProductNameLike(String startDateStr, String endDateStr, String productName) {
		// TODO Auto-generated method stub
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);

		LocalDate startDate = LocalDate.parse(startDateStr, dateFormatter);
		LocalDate endDate = LocalDate.parse(endDateStr, dateFormatter);

		LocalDateTime startDateTime = startDate.atStartOfDay();
		LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

		Date startDateDate = Date.from(startDateTime.atZone(ZoneId.systemDefault()).toInstant());
		Date endDateDate = Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant());
		return productRepository.countByProductNameLike(startDateDate, endDateDate, productName);
	}
	
	@Override
	public List<ProductBestSellerDTO> dataProductBestSeller(String startDateStr, String endDateStr, Pageable pageable) {

		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);

		LocalDate startDate = LocalDate.parse(startDateStr, dateFormatter);
		LocalDate endDate = LocalDate.parse(endDateStr, dateFormatter);

		LocalDateTime startDateTime = startDate.atStartOfDay();
		LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

		Date startDateDate = Date.from(startDateTime.atZone(ZoneId.systemDefault()).toInstant());
		Date endDateDate = Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant());

		return productRepository.findBestSellers(startDateDate, endDateDate, pageable);
	}
	
	@Override
	public int countByProductBestSeller(String startDateStr, String endDateStr) {
		DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);

		LocalDate startDate = LocalDate.parse(startDateStr, dateFormatter);
		LocalDate endDate = LocalDate.parse(endDateStr, dateFormatter);

		LocalDateTime startDateTime = startDate.atStartOfDay();
		LocalDateTime endDateTime = endDate.atTime(23, 59, 59);

		Date startDateDate = Date.from(startDateTime.atZone(ZoneId.systemDefault()).toInstant());
		Date endDateDate = Date.from(endDateTime.atZone(ZoneId.systemDefault()).toInstant());

		return productRepository.countByProductBestSeller(startDateDate, endDateDate);
	}

}
