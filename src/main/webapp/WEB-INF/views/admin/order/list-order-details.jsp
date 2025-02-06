<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="list" value="/admin/order/details-order"></c:url>
<c:url var="print" value="/admin/order/print-order?id=${orderDTO.orderId}"></c:url>

		 <!-- Page header -->
        <div class="page-header d-print-none">
            <div class="container-xl">
              <div class="row g-2 align-items-center">
                <div class="col">
                  <h2 class="page-title">
                    Chi Tiết Đơn Hàng
                  </h2>
                </div>
                			<!-- Page title actions -->
			<div class="col-auto ms-auto d-print-none">
				<div class="btn-list">
					
					<div class="text-end">
					<a href="${print}">
						<button class="btn btn-success align-text-top">
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
								viewBox="0 0 24 24" fill="none" stroke="currentColor"
								stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
								class="icon icon-tabler icons-tabler-outline icon-tabler-file-spreadsheet">
                                <path stroke="none" d="M0 0h24v24H0z"
									fill="none" />
                                <path d="M14 3v4a1 1 0 0 0 1 1h4" />
                                <path
									d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z" />
                                <path d="M8 11h8v7h-8z" />
                                <path d="M8 15h8" />
                                <path d="M11 11v7" />
                            </svg>
							Xuất Hóa Đơn
						</button>
					</a>

					</div>
				
				</div>
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
                    <h3 class="card-title">Sản Phẩm</h3>
                  </div>
                 
                  <div class="table-responsive">
                    <table class="table card-table table-vcenter text-nowrap datatable">
                      <thead>
                        <tr>
         
                          <th class="w-1">ID
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-sm icon-thick" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M6 15l6 -6l6 6" /></svg>
                          </th>
                          <th>ID Sản Phẩm</th>
                          <th>Tên Sản Phẩm</th>
                          <th>Số Lượng</th>
                          <th>Đơn Giá</th>
  <th>Tổng</th>
                        </tr>
                      </thead>
                      <tbody>
                      
                      	 
                      	<c:if test="${not empty detailsDTO}">
                  		<c:forEach var="item" items="${detailsDTO.listResult}">
                  
                        <tr>
                 
                          <td><span class="text-secondary">${item.orderDetailsId}</span></td>
                          <td>
                           	${item.productId}
                          </td>
                        
                          <td>
                            ${item.productName}
                          </td>

                          <td>${item.productQuantity}</td>
                           <td>${item.productPrice}đ</td>
                           <td>${item.productQuantity * item.productPrice}đ</td>
                        
                        </tr>
                        
                  </c:forEach>
                 </c:if>  
                    <tr>
                    <td colspan="5" class="strong text-end">Mã Đơn Hàng</td>
                    <td class="text-end">${orderDTO.orderId}</td>
                  </tr>
                                      <tr>
                    <td colspan="5" class="strong text-end">Bàn</td>
                    <td class="text-end">${orderDTO.tableUser.tableUserName}</td>
                  </tr>
                  <tr>
                    <td colspan="5" class="strong text-end">Số Lượng</td>
                    <td class="text-end">${orderDTO.totalQuantity}</td>
                  </tr>
                  <tr>
                    <td colspan="5" class="strong text-end">Tổng Tiền</td>
                    <td class="text-end">${orderDTO.totalPrice}đ</td>
                  </tr>
                   <tr>
                    <td colspan="5" class="strong text-end">Tình Trạng</td>
                    <td class="text-end">         <c:choose>
		<c:when test="${orderDTO.orderStatus == 1}">
            <span class="text-success">Hoàn Thành</span>
        </c:when>
          <c:otherwise>
            Chưa Xác Định
        </c:otherwise>
         </c:choose></td>
                  </tr>
                  
                      </tbody>
                    </table>
                  </div>
  <div class="card-footer d-flex align-items-center">
                    <p class="m-0 text-secondary">Showing <span>1</span> to <span>8</span> of <span>16</span> entries</p>
                    
                    <nav class="pagination m-0 ms-auto" aria-label="Page navigation">
              		 <ul class="pagination" id="pagination"></ul>
           		 	</nav>
                  </div>
                </div>
              </div>
           </div>
          </div>
        </div>
        
     <!-- Libs JS -->
    <script src="<c:url value='/template/admin/dist/libs/list.js/dist/list.min.js?1692870487' />" defer></script>
    
        <script type="text/javascript">
    $(document).ready(function() {
    
    var totalPages = ${detailsDTO.totalPage};
	var currentPage = ${detailsDTO.page};
	var limit = ${detailsDTO.limit};
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
        		  window.location.href = "${list}?id=${orderDTO.orderId}&page=" + page + "&limit=" + limit;
        		 
				}
           }
       })
   });
   
    });
    
    </script>
        


    