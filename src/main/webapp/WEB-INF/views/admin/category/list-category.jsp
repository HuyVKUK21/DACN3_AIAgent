<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:url var="loadData" value="/api/category/data"></c:url>
<c:url var="urlImg" value="/template/web/img/category/"></c:url>
<c:url var="list" value="/admin/category/list-category"></c:url>
<c:url var="deleteCategory" value="/api/category/delete"></c:url>
<c:url var="searchCategoryAPI" value="/api/category/search"></c:url>
<c:url var="updateStatusAPI" value="/api/category/update"></c:url>

<!-- Page header -->
<div class="page-header d-print-none">
	<div class="container-xl">
		<div class="row g-2 align-items-center">
			<div class="col">
				<h2 class="page-title">Danh sách danh mục</h2>
			</div>
			<!-- Page title actions -->
			<div class="col-auto ms-auto d-print-none">
				<div class="btn-list">
					<span> <input type="text" value="" class="form-control"
								placeholder="Tìm kiếm danh mục..." name="name" id="search"
								aria-label="Search in website"></span>
					<span id="btnDelete" class="d-none d-sm-inline"> <a href="#"
						class="btn"> <svg xmlns="http://www.w3.org/2000/svg"
								width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round"
								class="icon icon-tabler icons-tabler-outline icon-tabler-skull">
								<path stroke="none" d="M0 0h24v24H0z" fill="none" />
								<path
									d="M12 4c4.418 0 8 3.358 8 7.5c0 1.901 -.755 3.637 -2 4.96l0 2.54a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-2.54c-1.245 -1.322 -2 -3.058 -2 -4.96c0 -4.142 3.582 -7.5 8 -7.5z" />
								<path d="M10 17v3" />
								<path d="M14 17v3" />
								<path d="M9 11m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" />
								<path d="M15 11m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0" /></svg> Xóa
					</a>
					</span> <a href="add-category"
						class="btn btn-primary d-none d-sm-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
						<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
							<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
							<path d="M12 5l0 14"></path>
							<path d="M5 12l14 0"></path></svg> Thêm Danh mục
					</a> <a href="#" class="btn btn-primary d-sm-none btn-icon"> <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
						<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
							<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
							<path d="M12 5l0 14"></path>
							<path d="M5 12l14 0"></path></svg>
					</a>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Page body -->
<div class="page-body">
	<div class="container-xl">
		<div class="card">
			<div class="card-body">

				<div class="card-body border-bottom py-3">
				<div class="col-sm-2 p-2 pt-3 ml-auto">
					<!-- Thẻ select ở vị trí end -->
					<select class="form-select custom-select-width" id="mySelectEnd">
						<option value="0">Sắp xếp từ A - Z</option>
						<option value="1">Sắp xếp từ Z - A</option>
					</select>
				</div>
	
					<div id="table-default" class="table-responsive">
						<table
							class="table card-table table-vcenter text-nowrap datatable">
							<thead>
								<tr>
									<th class="w-1"><input
										class="form-check-input m-0 align-middle" type="checkbox"
										aria-label="Select all invoices"></th>
									<th class="w-1">ID</th>

									<th><button class="table-sort" data-sort="sort-id">TÊN
											DANH MỤC</button></th>
									<th><button class="table-sort" data-sort="sort-name">ẢNH
											DANH MỤC</button></th>
									<th><button class="table-sort" data-sort="sort-email">MÔ
											TẢ</button></th>
									<th>HIỄN THỊ</th>
									<th>THAO TÁC</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="load_table_category" class="table-tbody">

							</tbody>
						</table>
					</div>
					<div class="card-footer d-flex align-items-center">
						<nav class="pagination m-0 ms-auto" aria-label="Page navigation">
							<ul class="pagination" id="pagination"></ul>
						</nav>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- Libs JS -->
	<script
		src="<c:url value='/template/admin/dist/libs/list.js/dist/list.min.js?1692870487' />"
		defer></script>



	<script type="text/javascript">
    $(document).ready(function() {
      	var pagInitialized = false;
    	var currentPage = 1;
    	var limit = 3;
    	var sort = 0;
    	var isSearching = false;
    	var urlImg = '${urlImg}';
    	 var selectElementSort = document.getElementById("mySelectEnd");
      
    	 selectElementSort.addEventListener("change", function() {
      	   
  	       var selectedSortValue = selectElementSort.value;
  	       
  	       console.log(selectedSortValue);
  	       sort = selectedSortValue;
  	       loadData(currentPage, limit, sort);
  	   });
    	 
    	 $("#btnDelete").click(function(){
    		 var ids = $('tbody input[type=checkbox]:checked').map(function () {
    			    return $(this).val();
    			}).get();

    	
    			ids = ids.filter(function(value) {
    			    return !isNaN(value) && Number.isInteger(parseFloat(value));
    			});

    			console.log(ids);
    	    if (ids.length === 0) {
    	    	 message_toastr("info", "Vui lòng checkbox vào trường cân xóa!", "Thông báo");
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
		        	  deleteAdmins(ids);		
		          } else if (result.isDenied) {
		            message_toastr("info", "Đã hủy bỏ!");
		          }
		        });
	        
    	   	
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
        	                } else {
        	                    loadData(page, limit, sort);
        	                }
        	            }
        	        }
        	    });

        	    pagInitialized = true;
        	}

    	 
		 function deleteAdmins(data) {
		        $.ajax({
		            url: '${deleteCategory}',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(data),
		            success: function (result) {
		            	loadData(page, limit, sort);
		            	 message_toastr("success", result, "Thông báo");
		            },
		            error: function (error) {
		            	message_toastr("error", error, "Thông báo");
		            }
		        });
		    }
    	
    	   // Xử lý sự kiện "Chọn tất cả"
		$("#checkAll").click(function(){
        	$(".form-check-input").not("#checkAll").prop('checked', this.checked);
    	});

    	// Xử lý sự kiện thay đổi của các checkbox con
    	$(document).on('change', '.form-check-input:not(#checkAll)', function() {
    		
        // Kiểm tra xem tất cả các checkbox con có được chọn hay không
        var allChecked = $('.form-check-input').not("#checkAll").length === $('.form-check-input').not("#checkAll:checked").length;
        
        // Cập nhật trạng thái của checkbox "Chọn tất cả"
        $("#checkAll").prop('checked', allChecked);
        
        // Nếu có bất kỳ checkbox con nào chưa được chọn, checkbox "Chọn tất cả" sẽ bị bỏ chọn
        if ($('.form-check-input').not("#checkAll:checked").length > 0) {
            $("#checkAll").prop('indeterminate', true); // Có thể dùng để biểu thị trạng thái bán chọn
        } else {
            $("#checkAll").prop('indeterminate', false);
            
        }
        
    });
    	
    	function loadData(page, limit, sort) {
    	    $.ajax({
    	        url: '${loadData}', 
    	        method: 'get',
    	        data: {
    	            page: page,
    	            limit: limit,
    	            sort: sort
    	        },
    	        success: function(response, textStatus, jqXHR) {
    	            if (jqXHR.status === 200) {
    	                $('#load_table_category').empty();
    	                
    	                var totalPages = response.data.totalPage;
    	                currentPage = response.data.page;
    	                limit = response.data.limit;

    	                var listResult = response.data.listResult;
						
    	                $.each(listResult, function(index, item) {
    	                    var row = $('<tr></tr>');
    	                    row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" value = \'' + item.categoryId + '\' aria-label="Select admin"></td>');
    	                    row.append('<td class="sort-id">' + item.categoryId + '</td>');      
    	                    row.append('<td class="sort-name">' + item.categoryName + '</td>');
    	                    row.append('<td><div class="col-6">   <div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.categoryImage + ')"></div></div></td>');
    	                    row.append('<td class="sort-email"> ' + item.categoryDesc + '</td>');
    	                
    	                    if (item.categoryStatus === 1) {
    	                        row.append(
    	                            '<td><span id = "buttonCheck" class="update-status" data-item_id="' + item.categoryId + '" data-item_status="0">' +
    	                            '<label class="form-check form-switch">' +
    	                            '<input class="form-check-input" type="checkbox" checked>' +
    	                            '</label>' +
    	                            '</span></td>'
    	                        );
    	                    }
    	                    else {
    	                    	 row.append(
    	    	                            '<td><span id = "buttonCheck"  class="update-status" data-item_id="' + item.categoryId + '" data-item_status="1">' +
    	    	                            '<label class="form-check form-switch">' +
    	    	                            '<input class="form-check-input" type="checkbox">' +
    	    	                            '</label>' +
    	    	                            '</span></td>'
    	    	                        );
    	                    }
    	                    
    	                    row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="edit?id='+ item.categoryId +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');
    	
							

    	            		 $('#load_table_category').append(row);
    	                });
    	           $(document).on('change', '.form-check-input', function() {
    	                 
    	                    var $span = $(this).closest('span.update-status');
    	                    
    	                    var itemId = $span.data('item_id');
    	                    var itemStatus = $(this).is(':checked') ? 1 : 0; 
    	                    
    	                    console.log(itemStatus);
    	                    $.ajax({
    	                        url: '${updateStatusAPI}', 
    	                        type: 'POST',
    	           
    	                        data: {
    	                        	categoryId: itemId,
    	                        	categoryStatus: itemStatus
    	                        	
    	                        },
    	                        success: function(response) {
    	                    	
    	                        },
    	                        error: function(xhr, status, error) {
    	                        	console.log(itemId);
    	                    		console.log(itemStatus);
    	                            console.error('Lỗi khi cập nhật:', status, error);
    	                        }
    	                    });
    	               
    	                });  
    	                

    	                loadPagination(response.data.totalPage, currentPage, limit);
    	                
    	                const list = new List('table-default', {
    	                  	sortClass: 'table-sort',
    	                  	listClass: 'table-tbody',
    	                  	valueNames: [ 'sort-id', 'sort-name', 'sort-email']
    	                  });
    	             
    	            } else {
    	                alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
    	            }
    	        },
    	        error: function(jqXHR, textStatus, errorThrown) {
    	            alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
    	        },
    	        complete: function(jqXHR, textStatus) {
    	            console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
    	        }
    	    });
    	}
       
  // Tìm kiếm danh mục
    	   function search(page, limit) {
    	    $.ajax({
    	        url: '${searchCategoryAPI}', 
    	        method: 'get',
    	        data: {
    	            categoryName: $('#search').val().trim(),
    	            page: page,
    	            limit: limit
    	        },
    	        success: function(response, textStatus, jqXHR) {
    	            if (jqXHR.status === 200) {
    	                $('#load_table_category').empty();

    	                var totalPages = response.data.totalPage;
    	                currentPage = response.data.page;
    	                limit = response.data.limit;

    	                var listResult = response.data.listResult;

    	                $.each(listResult, function(index, item) {
    	                    var row = $('<tr></tr>');
    	                    row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" value = \'' + item.categoryId + '\' aria-label="Select admin"></td>');
    	                    row.append('<td class="sort-id">' + item.categoryId + '</td>');      
    	                    row.append('<td class="sort-name">' + item.categoryName + '</td>');
    	                    row.append('<td><div class="col-6">   <div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.categoryImage + ')"></div></div></td>');
    	                    row.append('<td class="sort-email"> ' + item.categoryDesc + '</td>');
    	                
    	                    if (item.categoryStatus === 1) {
    	                        row.append(
    	                            '<td><span id="buttonCheck" class="update-status" data-item_id="' + item.categoryId + '" data-item_status="0">' +
    	                            '<label class="form-check form-switch">' +
    	                            '<input class="form-check-input" type="checkbox" checked>' +
    	                            '</label>' +
    	                            '</span></td>'
    	                        );
    	                    }
    	                    else {
    	                    	 row.append(
    	    	                            '<td><span class="update-status" data-item_id="' + item.categoryId + '" data-item_status="1">' +
    	    	                            '<label class="form-check form-switch">' +
    	    	                            '<input class="form-check-input" type="checkbox">' +
    	    	                            '</label>' +
    	    	                            '</span></td>'
    	    	                        );
    	                    }
    	                    
    	                    row.append('<td><span id="btnDelete" class="d-none d-sm-inline"> <a href="#" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');
    	


    	            		 $('#load_table_category').append(row);
    	                });

    	                loadPagination(totalPages, currentPage, limit);
    	                
    	                const list = new List('table-default', {
    	                  	sortClass: 'table-sort',
    	                  	listClass: 'table-tbody',
    	                  	valueNames: [ 'sort-id', 'sort-name', 'sort-email']
    	                  });
    	                
    	            } else {
    	                alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
    	            }
    	        },
    	        error: function(jqXHR, textStatus, errorThrown) {
    	            alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
    	        },
    	        complete: function(jqXHR, textStatus) {
    	            console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
    	        }
    	    });
    	}

    	        $('#search').on('keypress', function(e) {
    	        	  if (e.which === 13) {
    	        		  e.preventDefault();
    	        		  var inputValue = $(this).val().trim();
    	                  isSearching = inputValue !== ""; // false

    	                  if (isSearching) {
    	                      search(1, limit); 
    	                  } else {
    	                      loadData(1, limit, sort);
    	                  }
    	        	  }
    	           
    	        });
    	
    	        loadData(currentPage,limit, sort);
    });
</script>