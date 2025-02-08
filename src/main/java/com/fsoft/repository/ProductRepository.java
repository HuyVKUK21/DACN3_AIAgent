package com.fsoft.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.fsoft.dto.ProductBestSellerDTO;
import com.fsoft.entity.ProductEntity;

@Repository
public interface ProductRepository extends JpaRepository<ProductEntity, Integer> {

	Page<ProductEntity> findByCategory_CategoryIdIn(List<Integer> idcategory, Pageable pageable);

	Page<ProductEntity> findByCategory_CategoryIdInAndProductNameContainingIgnoreCaseOrProductDescContainingIgnoreCase(
			List<Integer> idcategory, String keysearchName, String keysearchDesc, Pageable pageable);

	// Count products by category IDs
	long countByCategory_CategoryIdIn(List<Integer> idcategory);

	// Count products by category IDs and keysearch
	long countByCategory_CategoryIdInAndProductNameContainingIgnoreCaseOrProductDescContainingIgnoreCase(
			List<Integer> idcategory, String keysearchName, String keysearchDesc);

	@Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.category.categoryId = :categoryId")
	int countProductByCategory_CategoryId(@Param("categoryId") int categoryId);

	@Query("SELECT p FROM ProductEntity p WHERE p.category.categoryId = :categoryId")
	List<ProductEntity> findProductsByCategoryId(@Param("categoryId") int categoryId, Pageable pageable);

	List<ProductEntity> findByProductNameContaining(String productName, Pageable pageable);

	int countByProductNameLike(@Param("productName") String productName);
	
	@Query("SELECT COUNT(p) FROM ProductEntity p WHERE p.productStatus = :status")
	int countProductByStatus(@Param("status") int status);

	@Query("SELECT p FROM ProductEntity p WHERE p.productStatus = :status")
	List<ProductEntity> findProductsByStatus(@Param("status") int status, Pageable pageable);

	

	@Query("SELECT new com.fsoft.dto.ProductBestSellerDTO(p.productId, p.productName, p.productImage, p.productPrice, p.productDesc, SUM(od.productQuantity)) "
			+ "FROM ProductEntity p " + "JOIN p.orderDetailsEntities od "
			+ "WHERE od.createdDate BETWEEN :startDate AND :endDate "
			+ "GROUP BY p.productId, p.productName, p.productImage, p.productPrice, p.productDesc "
			+ "ORDER BY SUM(od.productQuantity) DESC")
	List<ProductBestSellerDTO> findBestSellers(@Param("startDate") Date startDate, @Param("endDate") Date endDate, Pageable pageable);
	
	
	@Query("SELECT new com.fsoft.dto.ProductBestSellerDTO(p.productId, p.productName, p.productImage, p.productPrice, p.productDesc, SUM(od.productQuantity)) " +
		       "FROM ProductEntity p " +
		       "JOIN p.orderDetailsEntities od " +
		       "WHERE od.createdDate BETWEEN :startDate AND :endDate " +
		       "AND p.productName LIKE CONCAT('%', :productName, '%') " +
		       "GROUP BY p.productId, p.productName, p.productImage, p.productPrice, p.productDesc " +
		       "ORDER BY SUM(od.productQuantity) DESC")
	List<ProductBestSellerDTO> findByProductNameContain(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("productName") String productName, Pageable pageable);
	
	
	@Query("SELECT COUNT(DISTINCT p.productId) " +
		       "FROM com.fsoft.entity.ProductEntity p " +
		       "JOIN p.orderDetailsEntities od " +
		       "WHERE od.createdDate BETWEEN :startDate AND :endDate " +
		       "AND p.productName LIKE CONCAT('%', :productName, '%')")
	int countByProductNameLike(@Param("startDate") Date startDate, @Param("endDate") Date endDate, @Param("productName") String productName);

	@Query("SELECT COUNT(DISTINCT p.productId) "
			+ "FROM ProductEntity p " + "JOIN p.orderDetailsEntities od "
			+ "WHERE od.createdDate BETWEEN :startDate AND :endDate ")
	int countByProductBestSeller(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

}
