package com.fsoft.repository;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fsoft.entity.ProductEntity;
import com.fsoft.entity.TableOrderEntity;


public interface TableOrderRepository extends JpaRepository<TableOrderEntity, Integer> {
	TableOrderEntity findByProduct_ProductId(int productId);
	TableOrderEntity findByProduct_ProductIdAndTableUser_UserTableID(int productId, int userTableID);
	List<TableOrderEntity> findByTableUser_UserTableID(int userTableID);
    void deleteByTableUser_UserTableID(int userTableID);
    @Query("SELECT SUM(o.orderQuantity) FROM TableOrderEntity o WHERE o.tableUser.userTableID = :userTableID")
    Integer sumOrderQuantityByUserTableID(@Param("userTableID") int userTableID);
    
    @Query("SELECT SUM(o.product.productPrice * o.orderQuantity) " +
            "FROM TableOrderEntity o " +
            "WHERE o.tableUser.userTableID = :userTableID")
    BigDecimal  sumTotalPriceByUserTableID(@Param("userTableID") int userTableID);
    
    @Query("SELECT SUM(t.orderQuantity) FROM TableOrderEntity t") // Sửa tên thuộc tính ở đây
    Integer findTotalQuantity();
}
