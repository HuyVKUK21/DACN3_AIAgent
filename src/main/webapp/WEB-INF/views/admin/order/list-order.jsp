<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="list" value="/admin/order/list-order"></c:url>

		 <!-- Page header -->
        <div class="page-header d-print-none">
            <div class="container-xl">
              <div class="row g-2 align-items-center">
                <div class="col">
                  <h2 class="page-title">
                    Quản Lý Đơn Đặt Sản Phẩm
                  </h2>
                </div>
              </div>
            </div>
          </div>
        <!-- Page body -->
        <div class="page-body">
          <div class="container-xl">
           <div class="row row-deck row-cards">
           		              <div class="col-12">
                <div class="card">
                  <div class="card-header">
                    <h3 class="card-title">Invoices</h3>
                  </div>
                  <div class="card-body border-bottom py-3">
                    <div class="d-flex">
                      <div class="text-secondary">
                        Hiễn thị
                        <div class="mx-2 d-inline-block">
                          <input type="text" class="form-control form-control-sm" value="${orderDTO.limit}" size="3" aria-label="Invoices count">
                        </div>
                        hóa đơn
                      </div>
                      <div class="ms-auto text-secondary">
                        Search:
                        <div class="ms-2 d-inline-block">
                          <input id="search" type="text" class="form-control form-control-sm" aria-label="Search invoice">
                          <script type="text/javascript">
                          $(document).ready(function() {
                        	    $('#search').on('change', function() {
                        	        var searchTerm = $(this).val();
                        	      
                        	        if (searchTerm) {
                        	            window.location.href = '${list}?page=${orderDTO.page}&limit=${orderDTO.limit}&search=' + searchTerm;
                        	        }

                        	       
                        	    });
                        	});
                          </script>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div id="table-default" class="table-responsive">
                    <table class="table card-table table-vcenter text-nowrap datatable">
                      <thead>
                        <tr>
                          <th class="w-1"><input class="form-check-input m-0 align-middle" type="checkbox" aria-label="Select all invoices"></th>
<th class="w-1">
    <button class="table-sort" data-sort="sort-id">ID</button>
</th>
<th>
    <button class="table-sort" data-sort="sort-2">Thời Gian</button>
</th>
<th>
    <button class="table-sort" data-sort="sort-3">Thanh Toán</button>
</th>
<th>
    <button class="table-sort" data-sort="sort-4">Trạng Thái</button>
</th>
<th>
    <button class="table-sort" data-sort="sort-5">Tổng Số Lượng</button>
</th>
<th>
    <button class="table-sort" data-sort="sort-6">Tổng Tiền</button>
</th>
<th>
    <button class="table-sort" data-sort="sort-7">Người Bán</button>
</th>
                          <th>Thao Tác</th>
                          <th></th>
                        </tr>
                      </thead>
                      <tbody class="table-tbody">
                      
                      	 
                      	<c:if test="${not empty orderDTO}">
                  		<c:forEach var="item" items="${orderDTO.listResult}">
                  
                        <tr>
                          <td><input class="form-check-input m-0 align-middle" type="checkbox" aria-label="Select invoice"></td>
                          <td class="sort-id"><span class="text-secondary">${item.orderId} - ${item.orderCode}</span></td>
                          <td class="sort-2">
                           	${item.createdDate}
                          </td>
                        
                          <td class="sort-3">
      <c:choose>
        <c:when test="${item.payment.paymentStatus == 1}">
            Thành công - ${item.payment.paymentName}
        </c:when>
        <c:otherwise>
            Chưa Xác Định - ${item.payment.paymentName}
        </c:otherwise>
    </c:choose>
                          </td>

                          <td class="sort-4">
         <c:choose>
		<c:when test="${item.orderStatus == 1}">
            <span class="text-success">Hoàn Thành</span>
        </c:when>
          <c:otherwise>
            Chưa Xác Định
        </c:otherwise>
         </c:choose>
        </td>
                          <td class="sort-5">${item.totalQuantity}</td>
                          <td class="sort-6">${item.totalPrice}đ</td>
                          <td class="sort-7">${item.createdBy}</td>
                         
                          <td class="text-end">
                            <span class="dropdown">
                              <button class="btn dropdown-toggle align-text-top" data-bs-boundary="viewport" data-bs-toggle="dropdown">Hành Động</button>
                              <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="<c:url value='/admin/order/details-order?id=${item.orderId}' />">
                                  Chi Tiết Đơn Hàng
                                </a>
                                <a class="dropdown-item" href="<c:url value="/admin/order/print-order?id=${item.orderId}"></c:url>">
                                  In Hóa Đơn
                                </a>
                              </div>
                            </span>
                          </td>
                           <td></td>
                        </tr>
                        
                  </c:forEach>
                 </c:if>  
                  
                      </tbody>
                    </table>
                  </div>
  				<div class="card-footer d-flex align-items-center">
                    <p class="m-0 text-secondary">Trang ${orderDTO.page} đến  ${orderDTO.totalPage}</p>
                    
                    <nav class="pagination m-0 ms-auto" aria-label="Page navigation">
              		 <ul class="pagination" id="pagination"></ul>
           		 	</nav>
                  </div>
                </div>
              </div>
           </div>
          </div>
        </div>
        
 
    <script src="<c:url value='/template/admin/dist/libs/list.js/dist/list.min.js?1692870487' />" defer></script>
    
        <script type="text/javascript">
        
   
       
        
        
    $(document).ready(function() {
    
    	
    var totalPages = ${orderDTO.totalPage};
	var currentPage = ${orderDTO.page};
	var limit = ${orderDTO.limit};
	var page = 1;
   $(function () {
       window.pagObj = $('#pagination').twbsPagination({
           totalPages: totalPages,
           visiblePages: 3,
           startPage: currentPage,
           first:'Đầu',
           prev:'Trước',
           next:'Tiếp',
           last:'Cuối',
           onPageClick: function (event, page) {
        	   page = page;
        	   if (currentPage != page) {			
        		  window.location.href = "${list}?page=" + page + "&limit=" + limit;
        		 
				}
           }
       })
   });
   
   
   const list = new List('table-default', {
    	sortClass: 'table-sort',
    	listClass: 'table-tbody',
    	valueNames: [ 'sort-id', 'sort-2', 'sort-3','sort-4', 'sort-5', 'sort-6', 'sort-7']
    });
   
   

    });
    
    </script>
        


    