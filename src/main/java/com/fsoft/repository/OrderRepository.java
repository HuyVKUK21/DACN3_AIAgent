package com.fsoft.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.fsoft.entity.OrderEntity;
import com.fsoft.response.DailyRevenue;
import com.fsoft.response.RevenueStatistics;

public interface OrderRepository extends JpaRepository<OrderEntity, Integer> {
	// Additional custom queries can be defined here if needed
	List<OrderEntity> findByCreatedDateBetweenAndOrderStatus(Date startOfDay, Date endOfDay, int orderStatus);

	@Query("SELECT SUM(o.totalQuantity) FROM OrderEntity o")
	long sumTotalQuantity();

	@Query("SELECT COALESCE(SUM(o.totalQuantity), 0) FROM OrderEntity o WHERE o.createdDate BETWEEN :startOfDay AND :endOfDay")
	long sumTotalQuantityByCreatedDateBetween(@Param("startOfDay") Date startOfDay, @Param("endOfDay") Date endOfDay);

	Page<OrderEntity> findByOrderCodeContainingIgnoreCase(String orderCode, Pageable pageable);

	// Hàm lấy doanh thu 7 ngày gần nhất
	@Query("SELECT new com.fsoft.response.DailyRevenue(DATE(o.createdDate), SUM(o.totalPrice)) " + "FROM OrderEntity o "
			+ "WHERE o.createdDate >= :startOfDay " + "GROUP BY DATE(o.createdDate)")
	List<DailyRevenue> findDailyRevenueLast7Days(@Param("startOfDay") Date startOfDay);

	// Hàm lấy doanh thu 30 ngày gần nhất
	@Query("SELECT new com.fsoft.response.DailyRevenue(DATE(o.createdDate), SUM(o.totalPrice)) " + "FROM OrderEntity o "
			+ "WHERE o.createdDate >= :startOfDay " + "GROUP BY DATE(o.createdDate)")
	List<DailyRevenue> findDailyRevenueLast30Days(@Param("startOfDay") Date startOfDay);

	// Hàm lấy doanh thu cho tất cả các ngày
	@Query("SELECT new com.fsoft.response.DailyRevenue(DATE(o.createdDate), SUM(o.totalPrice)) " + "FROM OrderEntity o "
			+ "GROUP BY DATE(o.createdDate)")
	List<DailyRevenue> findDailyRevenue(); // Trả về List<DailyRevenue>

	@Query("SELECT new com.fsoft.response.RevenueStatistics(DATE(o.createdDate), SUM(o.totalPrice)) "
			+ "FROM OrderEntity o " + "WHERE o.createdDate >= :startDate AND o.createdDate < :endDate "
			+ "GROUP BY DATE(o.createdDate) " + "ORDER BY o.createdDate") // Thêm ORDER BY
	List<RevenueStatistics> findRevenueStatistics(@Param("startDate") Date startDate, @Param("endDate") Date endDate);
}
