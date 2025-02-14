<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="loadData" value="/api/product/data"></c:url>
<c:url var="list" value="/admin/product/list-product"></c:url>
<c:url var="delete" value="/api/product/delete"></c:url>
<c:url var="updateStatus" value="/admin/product/update-status"></c:url>
<c:url var="filterProduct" value="/api/product/filter"></c:url>
<c:url var="search" value="/api/product/search"></c:url>
<c:url var="filterProductByStatus" value="/api/product/filterByStatus"></c:url>
		 <!-- Page header -->
        <div class="page-header d-print-none">
            <div class="container-xl">
              <div class="row g-2 align-items-center">
                <div class="col">
                  <h2 class="page-title">
                    Dashboard
                  </h2>
                </div>
                <!-- Page title actions -->
                <div class="col-auto ms-auto d-print-none">
                  <div class="btn-list">
                  	<span> <input type="text" value="" class="form-control"
								placeholder="Tìm kiếm sản phẩm..." name="productName" id="search"
								aria-label="Search in website"></span>
                    <span id="btnDelete" class="d-none d-sm-inline">
                      <a href="#" class="btn">
                        <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-skull"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M12 4c4.418 0 8 3.358 8 7.5c0 1.901 -.755 3.637 -2 4.96l0 2.54a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-2.54c-1.245 -1.322 -2 -3.058 -2 -4.96c0 -4.142 3.582 -7.5 8 -7.5z" /><path d="M10 17v3" /><path d="M14 17v3" /><path d="M9 11m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" /><path d="M15 11m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" /></svg>
                        Xóa
                      </a>
                    </span>
                    <a href="add-product" class="btn btn-primary d-none d-sm-inline-block">
                      <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12 5l0 14"></path><path d="M5 12l14 0"></path></svg>
                      Thêm Sản Phẩm
                    </a>
                    <a href="#" class="btn btn-primary d-sm-none btn-icon">
                      <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
                      <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><path d="M12 5l0 14"></path><path d="M5 12l14 0"></path></svg>
                    </a>
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
            	<div class="row">
		    		<div class="col-sm-2 p-2 pt-3">
				        <select class="form-select custom-select-width" id="mySelectStart">
				            <option value="0">Sắp xếp từ A - Z</option>
				            <option value="1">Sắp xếp từ Z - A</option>
				        </select>
		    		</div>
		    		<div class="col-sm-2 p-2 pt-3">
				        <select class="form-select custom-select-width" id="mySelectEnd">
       						<option value="0">Tất cả</option>
				            <c:forEach var="item" items="${categorys}">
				                <option value="${item.categoryId}">${item.categoryName}</option>
				            </c:forEach>
				        </select>
		    		</div>
		    		<div class="col-sm-2 p-2 pt-3">
				        <select class="form-select custom-select-width" id="mySelectStatus">
       						<option value="2">Tất cả Trạng Thái</option>
          					<option value="0">Vô Hiệu</option>
          					<option value="1">Hoạt Động</option>
				        </select>
		    		</div>
				</div>
                  <div class="table-responsive">
                    <table id = "product-table" 
                    class="table card-table table-vcenter text-nowrap datatable">
                      <thead>
                        <tr>
                          <th class="w-1"><input class="form-check-input m-0 align-middle" type="checkbox"  id="checkAll"
                          aria-label="Select all invoices"></th>
                          <th class="w-1">ID <!-- Download SVG icon from http://tabler-icons.io/i/chevron-up -->
                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-sm icon-thick" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M6 15l6 -6l6 6" /></svg>
                          </th>
                          <th>Tên Sản Phẩm</th>
                          <th>Danh Mục</th>
                          <th>Ảnh Đại Diện</th>
                          <th>Giá</th>
                          <th>Mô Tả</th>
                          <th>Trạng Thái</th>
                          <th></th>
                        </tr>
                      </thead>
                      <tbody>
                      	<c:url var="urlImg" value="/template/web/img/product/"></c:url>	 
                      	<c:if test="${not empty productDTO}">
                  		<c:forEach var="item" items="${productDTO.listResult}">
                        <tr>
                          <td><input class="form-check-input m-0 align-middle" type="checkbox" data-productId="${item.productId}" aria-label="Select invoice"></td>
                          <td><span class="text-secondary">${item.productId}</span></td>
                          <td><a href="invoice.html" class="text-reset" tabindex="-1"> ${item.productName}</a></td>
                          <td>${item.category.categoryName}</td>
                          <td>
                            <div class="col-12">
                         		<div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(${urlImg}${item.productImage})"></div>
                             </div>
                          </td>
                          <td>${item.productPrice}</td>
                          <td>${item.productDesc}</td>
                          <td>
                          	<c:if test="${item.productStatus == 1}">
						    	<span class="badge bg-success me-1"></span> Hoạt Động</span>		
						  	</c:if>
						  	<c:if test="${item.productStatus == 0}">
						   		<span class="badge bg-error me-1"></span> Vô Hiệu
                           	</span>   
						</c:if>  
						 </td>  
                          <td class="text-end">
                            <span class="dropdown">
                              <button class="btn dropdown-toggle align-text-top" data-bs-boundary="viewport" data-bs-toggle="dropdown">Actions</button>
                              <div class="dropdown-menu dropdown-menu-end">
                                <a class="dropdown-item" href="update-product/${item.productId}">
                                  Cập Nhật
                                </a>
                                <a class="dropdown-item" href="#">
                                  Another action
                                </a>
                              </div>
                            </span>
                          </td>
                        </tr>
                        
                  </c:forEach>
                 </c:if>  
                  
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
    $(document).ready(function () {
        var currentPage = 1;
        var limit = 5;
        var sort = 0; // Giá trị mặc định để sắp xếp
        var categoryFilter = 0; // Giá trị mặc định cho bộ lọc danh mục
        var isSearching = false;
        var isFiltering = false;
        var pagInitialized = false; // Khởi tạo biến pagInitialized
        
        var selectElementSort = document.getElementById("mySelectStart");
        
        selectElementSort.addEventListener("change", function() {
            var selectedSortValue = selectElementSort.value;
            console.log("Sort value: " + selectedSortValue);
            sort = selectedSortValue;
            loadProductData(currentPage, limit, sort);
        });

        function loadPagination(totalPages, currentPage, limit) {
            if (pagInitialized) {
                $('#pagination').twbsPagination('destroy');
            }

            $('#pagination').twbsPagination({
                totalPages: totalPages,
                visiblePages: 5,
                startPage: currentPage,
                first: '<',
                prev: 'Trước',
                next: 'Tiếp',
                last: '>',
                onPageClick: function (event, page) {
                    if (page !== currentPage) {
                        if (isSearching) {
                            search(page, limit);
                        }
                        else if (isFiltering) {
                            filterData(page, limit, $('#mySelectEnd').val());
                        }
                        else {
                            loadProductData(page, limit, sort);
                        }
                    }
                }
            });

            pagInitialized = true; // Đánh dấu rằng phân trang đã được khởi tạo
        }

        function loadProductData(page, limit, sort) {
            $.ajax({
                url: '${loadData}',
                method: 'GET',
                data: {
                    page: page,
                    limit: limit,
                    sort: sort
                },
                success: function(response, textStatus, jqXHR) {
                    if (jqXHR.status === 200) {
                        $('#product-table tbody').empty(); // Xóa dữ liệu cũ

                        var totalPages = response.data.totalPage;
                        var currentPage = response.data.page;
                        var listResult = response.data.listResult;

                        var urlImg = '/CafeManager/template/web/img/product/';

                        $.each(listResult, function(index, item) {
                            var row = $('<tr></tr>');

                            row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-productId="' + item.productId + '" aria-label="Select product"></td>');
                            row.append('<td><span class="text-secondary">' + item.productId + '</span></td>');
                            row.append('<td><a href="update-product/' + item.productId + '" class="text-reset" tabindex="-1">' + item.productName + '</a></td>');
                            row.append('<td>' + item.category.categoryName + '</td>');
                            row.append('<td><div class="col-12"><div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.productImage + ')"></div></div></td>');
                            row.append('<td>' + item.productPrice + '</td>');
                            row.append('<td>' + item.productDesc + '</td>');

                            if (item.productStatus == 1) {
                                row.append('<td><span class="badge bg-success me-1"></span> Hoạt Động</td>');
                            } else {
                                row.append('<td><span class="badge bg-error me-1"></span> Vô Hiệu</td>');
                            }

                            row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="update-product/'+ item.productId +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                            $('#product-table').append(row);
                        });

                        // Cập nhật phân trang
                        loadPagination(totalPages, currentPage, limit);

                    } else {
                        alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
                }
            });
        }

        function filterData(page, limit, categoryId) {
            $.ajax({
                url: '${filterProduct}',
                method: 'GET',
                data: {
                    categoryId: categoryId,
                    page: page,
                    limit: limit
                },
                success: function(response, textStatus, jqXHR) {
                    if (jqXHR.status === 200) {
                        $('#product-table tbody').empty(); // Xóa dữ liệu cũ

                        var totalPages = response.data.totalPage;
                        var currentPage = response.data.page;
                        var listResult = response.data.listResult;

                        var urlImg = '/CafeManager/template/web/img/product/';

                        $.each(listResult, function(index, item) {
                            var row = $('<tr></tr>');

                            row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-productId="' + item.productId + '" aria-label="Select product"></td>');
                            row.append('<td><span class="text-secondary">' + item.productId + '</span></td>');
                            row.append('<td><a href="update-product/' + item.productId + '" class="text-reset" tabindex="-1">' + item.productName + '</a></td>');
                            row.append('<td>' + item.category.categoryName + '</td>');
                            row.append('<td><div class="col-12"><div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.productImage + ')"></div></div></td>');
                            row.append('<td>' + item.productPrice + '</td>');
                            row.append('<td>' + item.productDesc + '</td>');

                            if (item.productStatus === 1) {
                                row.append('<td><span class="badge bg-success me-1"></span> Hoạt Động</td>');
                            } else {
                                row.append('<td><span class="badge bg-error me-1"></span> Vô Hiệu</td>');
                            }

                            row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="update-product/'+ item.productId +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                            $('#product-table').append(row);
                        });

                        // Cập nhật phân trang
                        loadPagination(totalPages, currentPage, limit);
                    } else {
                        alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
                }
            });
        }

        $("#btnDelete").click(function () {
            var selectedProductIds = $('#product-table tbody input[type="checkbox"]:checked').map(function () {
                return $(this).data('productid');
            }).get();
            console.log(selectedProductIds);

            if (selectedProductIds.length === 0) {
                toastr.info("Vui lòng chọn sản phẩm cần xóa!", "Thông báo");
                return;
            }

            Swal.fire({
                title: "Bạn có muốn xóa không?",
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: "Xóa",
                denyButtonText: "Không xóa"
            }).then((result) => {
                if (result.isConfirmed) {
                    deleteProducts(selectedProductIds);
                } else if (result.isDenied) {
                    toastr.info("Đã hủy bỏ!", "Thông báo");
                }
            });
        });

        function deleteProducts(data) {
            $.ajax({
                url: '${delete}',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (result) {
                    loadProductData(currentPage, limit, sort);
                    toastr.success(result, "Thông báo");
                },
                error: function (error) {
                    toastr.error(error.responseText, "Thông báo");
                }
            });
        }
        
        
        
        // Tìm kiếm
        function search(page, limit) {
         $
             .ajax({
                 url: '${search}',
                 method: 'get',
                 data: {
                 	productName: $('#search').val().trim(),
                     page: page,
                     limit: limit
                 },
                 success: function(response, textStatus, jqXHR) {
                     if (jqXHR.status === 200) {
                         $('#product-table tbody').empty(); // Xóa dữ liệu cũ

                         var totalPages = response.data.totalPage;
                         var currentPage = response.data.page;
                         var listResult = response.data.listResult;

                         var urlImg = '/CafeManager/template/web/img/product/';

                         $.each(listResult, function(index, item) {
                             var row = $('<tr></tr>');

                             row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-productId="' + item.productId + '" aria-label="Select product"></td>');
                             row.append('<td><span class="text-secondary">' + item.productId + '</span></td>');
                             row.append('<td><a href="update-product/' + item.productId + '" class="text-reset" tabindex="-1">' + item.productName + '</a></td>');
                             row.append('<td>' + item.category.categoryName + '</td>');
                             row.append('<td><div class="col-12"><div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.productImage + ')"></div></div></td>');
                             row.append('<td>' + item.productPrice + '</td>');
                             row.append('<td>' + item.productDesc + '</td>');

                             if (item.productStatus === 1) {
                                 row.append('<td><span class="badge bg-success me-1"></span> Hoạt Động</td>');
                             } else {
                                 row.append('<td><span class="badge bg-error me-1"></span> Vô Hiệu</td>');
                             }

                             row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="update-product/'+ item.productId +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                             $('#product-table').append(row);
                         });

                         // Cập nhật phân trang
                         loadPagination(totalPages, currentPage, limit);
                     } else {
                         alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
                     }
                 },
                 error: function(jqXHR, textStatus, errorThrown) {
                     alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
                 }
             });
         }
        function filterDataByStatus(page, limit, status) {
            $.ajax({
                url: '${filterProductByStatus}',
                method: 'GET',
                data: {
                    status: status,
                    page: page,
                    limit: limit
                },
                success: function(response, textStatus, jqXHR) {
                    if (jqXHR.status === 200) {
                        $('#product-table tbody').empty(); // Xóa dữ liệu cũ

                        var totalPages = response.data.totalPage;
                        var currentPage = response.data.page;
                        var listResult = response.data.listResult;

                        var urlImg = '/CafeManager/template/web/img/product/';

                        $.each(listResult, function(index, item) {
                            var row = $('<tr></tr>');

                            row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-productId="' + item.productId + '" aria-label="Select product"></td>');
                            row.append('<td><span class="text-secondary">' + item.productId + '</span></td>');
                            row.append('<td><a href="update-product/' + item.productId + '" class="text-reset" tabindex="-1">' + item.productName + '</a></td>');
                            row.append('<td>' + item.category.categoryName + '</td>');
                            row.append('<td><div class="col-12"><div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.productImage + ')"></div></div></td>');
                            row.append('<td>' + item.productPrice + '</td>');
                            row.append('<td>' + item.productDesc + '</td>');

                            if (item.productStatus === 1) {
                                row.append('<td><span class="badge bg-success me-1"></span> Hoạt Động</td>');
                            } else {
                                row.append('<td><span class="badge bg-error me-1"></span> Vô Hiệu</td>');
                            }

                            row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="update-product/'+ item.productId +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                            $('#product-table').append(row);
                        });

                        // Cập nhật phân trang
                        loadPagination(totalPages, currentPage, limit);
                    } else {
                        alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
                }
            });
        }


        $("#checkAll").click(function () {
            $(".form-check-input").not("#checkAll").prop('checked', this.checked);
        });

        $(document).on('change', '.form-check-input:not("#checkAll")', function () {
            var allChecked = $('.form-check-input').not("#checkAll").length === $('.form-check-input').not("#checkAll:checked").length;
            $("#checkAll").prop('checked', allChecked);

            if ($('.form-check-input').not("#checkAll:checked").length > 0) {
                $("#checkAll").prop('indeterminate', true);
            } else {
                $("#checkAll").prop('indeterminate', false);
            }
        });

        $('#mySelectStart').change(function () {
            sort = $(this).val();
            loadProductData(currentPage, limit, sort);
        });

        $('#mySelectEnd').change(function () {
            var selectedValue = $(this).val();
            isFiltering = selectedValue !== "0";

            categoryFilter = selectedValue; // Cập nhật giá trị bộ lọc danh mục

            if (selectedValue === "0") {
                loadProductData(currentPage, limit, sort);
            } else {
                filterData(currentPage, limit, selectedValue);
            }
        });
        $('#mySelectStatus').change(function () {
            var selectedValue = $(this).val();
            isFiltering = selectedValue !== "2";

            categoryFilter = selectedValue; // Cập nhật giá trị bộ lọc danh mục

            if (selectedValue === "2") {
                loadProductData(currentPage, limit, sort);
            } else {
            	filterDataByStatus(currentPage, limit, selectedValue);
            }
        });
        
        $('#search').on('keypress', function(e) {
      	  if (e.which === 13) {
      		  e.preventDefault();
      		  var inputValue = $(this).val().trim();
                isSearching = inputValue !== ""; // false

                if (isSearching) {
                    search(1, limit); 
                } else {
              	  loadProductData(currentPage, limit, sort);
                }
      	  }
         
      });

        // Load dữ liệu sản phẩm lần đầu tiên
        loadProductData(currentPage, limit, sort);
    });
</script>