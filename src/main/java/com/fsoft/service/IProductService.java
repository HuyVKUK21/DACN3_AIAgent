package com.fsoft.service;

import java.util.List;

import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.query.Param;

import com.fsoft.dto.ProductBestSellerDTO;
import com.fsoft.dto.ProductDTO;
import com.fsoft.entity.ProductEntity;

public interface IProductService {

	void saveProduct(ProductDTO productDTO);

	Integer getTotalItem();

	List<ProductDTO> findAll(Pageable pageable);

	List<ProductDTO> findAllByCategoryIdsAndKeysearch(List<Integer> idcategory, String keysearch, Pageable pageable);

	Integer getTotalItem(List<Integer> idcategory, String keysearch);

	void deleteProduct(int[] ids);

	String deleteProduct(int id) throws Exception;

	void updateStatus(int productId, int productStatus);

	ProductEntity findById(int productId);

	void updateProduct(ProductDTO productDTO);

	List<ProductDTO> findAllDesc(Pageable pageable);


	int countProductByStatus(int status);

	List<ProductDTO> findProductByStatus(int status, Pageable pageable);

	int countProductByCategoryId(int categoryId);

	List<ProductDTO> findProductByCategoryId(int categoryId, Pageable pageable);

	Integer countByProductNameLike(@Param("productName") String productName);

	List<ProductDTO> findByProductNameContaining(String productName, Pageable pageable);

	List<ProductBestSellerDTO> dataProductBestSeller(String startDate, String endDate, Pageable pageable);

	List<ProductBestSellerDTO> findByProductNameContain(String startDateStr, String endDateStr, String productName,
			Pageable pageable);

	int countByProductNameLike(String startDateStr, String endDateStr, String productName);

	int countByProductBestSeller(String startDateStr, String endDateStr);
}
