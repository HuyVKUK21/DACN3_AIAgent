<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:url var="loadData" value="/api/admin/data"></c:url>
<c:url var="assignRoles" value="/admin/account-admin/assign-roles"></c:url>
<c:url var="deleteAdmin" value="/admin/account-admin/delete"></c:url>
<c:url var="deleteAdminAPI" value="/api/admin/delete"></c:url>
<c:url var="searchAdminAPI" value="/api/admin/search"></c:url>
<c:url var="filterAdminAPI" value="/api/admin/filter"></c:url>

<!-- Page header -->
<div class="page-header d-print-none">
	<div class="container-xl">
		<div class="row g-2 align-items-center">
			<div class="col">
				<h2 class="page-title">Danh sách tài khoản</h2>
			</div>
			<!-- Page title actions -->
			<div class="col-auto ms-auto d-print-none">
				<div class="btn-list">
					<form action="${searchAdminAPI }" method="get" autocomplete="off"
						novalidate="">
						<div class="input-icon">
							<span class="input-icon-addon"> <!-- Download SVG icon from http://tabler-icons.io/i/search -->
								<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
									height="24" viewBox="0 0 24 24" stroke-width="2"
									stroke="currentColor" fill="none" stroke-linecap="round"
									stroke-linejoin="round">
									<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
									<path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0"></path>
									<path d="M21 21l-6 -6"></path></svg>
							</span> <input type="text" value="" class="form-control"
								placeholder="Tìm kiếm tài khoản..." name="name" id="search"
								aria-label="Search in website">
						</div>
					</form>
					<span id="btnDelete" class="d-none d-sm-inline"> <a href="#"
						class="btn"> <svg xmlns="http://www.w3.org/2000/svg"
								width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round"
								class="icon icon-tabler icons-tabler-outline icon-tabler-trash">
								<path stroke="none" d="M0 0h24v24H0z" fill="none" />
								<path d="M4 7l16 0" />
								<path d="M10 11l0 6" />
								<path d="M14 11l0 6" />
								<path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" />
								<path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" /></svg> Xóa
					</a>
					</span> <a href="add" class="btn btn-primary d-none d-sm-inline-block">
						<!-- Download SVG icon from http://tabler-icons.io/i/plus --> <svg
							xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
							<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
							<path d="M12 5l0 14"></path>
							<path d="M5 12l14 0"></path></svg> Thêm tài khoản
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
			<div class="d-flex justify-content-between">
				<div class="col-sm-2 p-2 pt-3">
					<!-- Thẻ select ở vị trí start -->
					<select class="form-select custom-select-width" id="mySelect">
						<option value="0">Bộ lọc tìm kiếm</option>
						<option value="1">Quản trị</option>
						<option value="2">Quản lý</option>
						<option value="3">Nhân viên</option>
					</select>
				</div>

				<div class="col-sm-2 p-2 pt-3 ml-auto">
					<!-- Thẻ select ở vị trí end -->
					<select class="form-select custom-select-width" id="mySelectEnd">
						<option value="0">Sắp xếp từ A - Z</option>
						<option value="1">Sắp xếp từ Z - A</option>
					</select>
				</div>
			</div>


			<div id="table-default" class="table-responsive">

				<table class="table">

					<thead>
						<tr>
							<th class="w-1"><input id="checkAll" type="checkbox"
								class="form-check-input m-0 align-middle"
								aria-label="Select all invoices"></th>
							<th><button class="table-sort" data-sort="sort-id">MÃ
									TÀI KHOẢN</button></th>
							<th><button class="table-sort" data-sort="sort-name">TÊN
									NGƯỜI DÙNG</button></th>
							<th><button class="table-sort" data-sort="sort-account">TÊN
									TÀI KHOẢN</button></th>
							<th><button class="table-sort" data-sort="sort-email">EMAIL</button></th>
							<th>QUẢN TRỊ</th>
							<th>QUẢN LÝ</th>
							<th>NHÂN VIÊN</th>
						</tr>
					</thead>
					<tbody id="load_table_admin" class="table-tbody">
					</tbody>
				</table>
				<div class="card-footer d-flex align-items-center">


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
    	var isFiltering = false;
    	
    	   var selectElement = document.getElementById("mySelect");
    	   var selectElementSort = document.getElementById("mySelectEnd");
    		
    	 
    	   selectElement.addEventListener("change", function() {
    	   
    	       var selectedValue = selectElement.value;
    	       if (selectedValue === "0") {
    	      	 loadData(currentPage, limit, sort);
    	       }
    	      
    	       filterData(currentPage, limit, selectedValue);
    	   });
    	   
    	   selectElementSort.addEventListener("change", function() {
        	   
    	       var selectedSortValue = selectElementSort.value;
    	       
    	       console.log(selectedSortValue);
    	       sort = selectedSortValue;
    	       loadData(currentPage, limit, sort);
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
    	                else if(isFiltering) {
    	                	 filterData(page, limit, $('#mySelect').val());
    	                }
    	                else {
    	                    loadData(page, limit, sort);
    	                }
    	            }
    	        }
    	    });

    	    pagInitialized = true;
    	}
    	 $("#btnDelete").click(function(){
    		var ids = $('tbody input[type=checkbox]:checked').map(function () {
		        return $(this).val();
		     }).get();
    
    	    if (ids.length === 0) {
    	    	 message_toastr("info", "Vui lòng checkbox vào trường cân xóa!", "Thông báo");
                return;
            }
    	    
	        Swal.fire({
		          title: "Bạn có muốn xóa không?",
		          showDenyButton: true,
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
    	 
      
		 function deleteAdmins(data) {
		        $.ajax({
		            url: '${deleteAdminAPI}',
		            type: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(data),
		            success: function (result) {
		            	loadData(currentPage, limit, sort);
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
    	                $('#load_table_admin').empty();

    	                var totalPages = response.data.totalPage;
    	                currentPage = response.data.page;
    	                limit = response.data.limit;

    	                var listResult = response.data.listResult;

    	                $.each(listResult, function(index, item) {
    	                    var row = $('<tr></tr>');
    	                    row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" value = \'' + item.id + '\' aria-label="Select admin"></td>');
    	                    row.append('<td class="sort-id" name = "id">' + item.id + '</td>');
    	                    row.append('<td class="sort-name">' + item.fullname + '</td>');
    	                    row.append('<td class="sort-account"> ' + item.username + '</td>');
    	                    row.append('<td class="sort-email"> ' + item.email + '</td>');
    	                    $.each([1, 2, 3], function(roleIndex, roleValue) {
    	                        var isChecked = item.roles.some(role => role.id === roleValue);
    	                        var bgColorClass = isChecked ? 'bg-indigo' : 'bg-white';
    	                        row.append(
    	                            '<td><div class="col-auto">' +
    	                                '<label class="form-colorinput">' +
    	                                    '<input name="roles_' + item.id + '" data-admin_id="' + item.id + '" type="radio" value="' + roleValue + '" class="check-input-role form-colorinput-input" ' + (isChecked ? 'checked' : '') + ' />' +
    	                                    '<span class="form-colorinput-color ' + bgColorClass + ' rounded-circle"></span>' +
    	                                '</label>' +
    	                            '</div></td>'
    	                        );
    	                    });

    	                    $('#load_table_admin').append(row);
    	                });

    	                loadPagination(response.data.totalPage, currentPage, limit);
    	                
    	                const list = new List('table-default', {
    	                  	sortClass: 'table-sort',
    	                  	listClass: 'table-tbody',
    	                  	valueNames: [ 'sort-id', 'sort-name', 'sort-account', 'sort-email']
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
       



        $(document).on('click', '.check-input-role', function() {
            var admin_id = $(this).data('admin_id');
            var new_role = $(this).val();

   
            $('input[name="roles1"][data-admin_id="' + admin_id + '"]').each(function() {
                var roleValue = $(this).val();
                if (roleValue === new_role) {
                    $(this).prop('checked', true);
                    $(this).siblings('.form-colorinput-color').removeClass('bg-white').addClass('bg-indigo');
                } else {
                    $(this).prop('checked', false);
                    $(this).siblings('.form-colorinput-color').removeClass('bg-indigo').addClass('bg-white');
                }
            });


            $.ajax({
                url: '${assignRoles}',
                method: 'GET',
                data: {
                    admin_id: admin_id,
                    index_roles: new_role
                },
                success: function(data) {
                	if (isSearching) {
  	                    search(currentPage, limit);
  	                } 
                	else if(isFiltering) {
                		filterData(currentPage, limit, $('#mySelect').val());
                	}
                	else {
  	                    loadData(currentPage, limit, sort);
  	                }
                    if (data === "ROLE_ADMIN") {
                        toastr.success("Cấp Quyền Quản Trị Thành Công!", "Thông báo");
                    } else if (data === "ROLE_MANAGER") {
                        toastr.success("Cấp Quyền Quản Lý Thành Công!", "Thông báo");
                    } else if (data === "ROLE_EMPLOYEE") {
                        toastr.success("Cấp Quyền Nhân Viên Thành Công!", "Thông báo");
                    } else if (data === "permission_error") {
                        toastr.warning("Quản Trị Viên Không Thể Tự Cấp Lại Quyền Cho Chính Mình!", "Oh Noooooo!");
                    } else {
                        toastr.error(data, "Oh Noooooo!");
                    }
                },
                error: function(e) {
                    toastr.error("Có lỗi xảy ra: " + e, "Oh Noooooo!");
                }
            });
        });



        $(document).on('click', '.btn-delete-admin-roles', function() {
            var admin_id = $(this).data('admin_id');
            Swal.fire({
                title: "Are you sure?",
                text: "You won't be able to revert this!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes, delete it!"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '${deleteAdmin}',
                        method: 'get',
                        data: {
                            admin_id: admin_id,
                        },
                        success: function(data) {
                        	if (isSearching) {
          	                    search(currentPage, limit);
          	                }
                        	else if(isFiltering) {
                        		filterData(page, limit, $('#mySelect').val());
        	                }
                        	else {
          	                    loadData(currentPage, limit, sort);
          	                }
                            if (data == "error_delete_admin") {
                                message_toastr("warning",
                                    "Quản Trị Viên Không Thể Tự Xóa Chính Mình!",
                                    "Oh Noooooo!");
                            } else if (data == "true") {
                                message_toastr("success", "Đã Xóa Thành Công!", "Thông báo");
                            }
                        },
                        error: function() {
                            alert("Bug Huhu :<<");
                        }
                    });
                }
            });
        });
        
        // Tìm kiếm tài khoản
   function search(page, limit) {
    $.ajax({
        url: '${searchAdminAPI}', 
        method: 'get',
        data: {
            name: $('#search').val().trim(),
            page: page,
            limit: limit
        },
        success: function(response, textStatus, jqXHR) {
            if (jqXHR.status === 200) {
                $('#load_table_admin').empty();

                var totalPages = response.data.totalPage;
                currentPage = response.data.page;
                limit = response.data.limit;

                var listResult = response.data.listResult;

                $.each(listResult, function(index, item) {
                    var row = $('<tr></tr>');
                    row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" aria-label="Select admin"></td>');
                    row.append('<td class="sort-id">' + item.id + '</td>');
                    row.append('<td class="sort-name">' + item.fullname + '</td>');
                    row.append('<td class="sort-account"> ' + item.username + '</td>');
                    row.append('<td class="sort-email"> ' + item.email + '</td>');
                    $.each([1, 2, 3], function(roleIndex, roleValue) {
                        var isChecked = item.roles.some(role => role.id === roleValue);
                        var bgColorClass = isChecked ? 'bg-indigo' : 'bg-white';
                        row.append(
                            '<td><div class="col-auto">' +
                                '<label class="form-colorinput">' +
                                    '<input name="roles_' + item.id + '" data-admin_id="' + item.id + '" type="radio" value="' + roleValue + '" class="check-input-role form-colorinput-input" ' + (isChecked ? 'checked' : '') + ' />' +
                                    '<span class="form-colorinput-color ' + bgColorClass + ' rounded-circle"></span>' +
                                '</label>' +
                            '</div></td>'
                        );
                    });

                    $('#load_table_admin').append(row);
                });

                const list = new List('table-default', {
                  	sortClass: 'table-sort',
                  	listClass: 'table-tbody',
                  	valueNames: [ 'sort-id', 'sort-name', 'sort-account', 'sort-email']
                  });
                
                
                loadPagination(totalPages, currentPage, limit);
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
        

	 
   function filterData(page, limit, selectedValue) {
  	    $.ajax({
  	        url: '${filterAdminAPI}', 
  	        method: 'get',
  	        data: {
  	            roleId: selectedValue,
  	            page: page,
  	            limit: limit
  	        },
  	        success: function(response, textStatus, jqXHR) {
  	            if (jqXHR.status === 200) {
  	                $('#load_table_admin').empty();

  	                var totalPages = response.data.totalPage;
  	                currentPage = response.data.page;
  	                limit = response.data.limit;

  	                var listResult = response.data.listResult;

  	                $.each(listResult, function(index, item) {
  	                    var row = $('<tr></tr>');
  	                    row.append('<td><input class="form-check-input m-0 align-middle" type="checkbox" aria-label="Select admin"></td>');
  	                    row.append('<td class="sort-id">' + item.id + '</td>');
  	                    row.append('<td class="sort-name">' + item.fullname + '</td>');
  	                    row.append('<td class="sort-account"> ' + item.username + '</td>');
  	                    row.append('<td class="sort-email"> ' + item.email + '</td>');
  	                    $.each([1, 2, 3], function(roleIndex, roleValue) {
  	                        var isChecked = item.roles.some(role => role.id === roleValue);
  	                        var bgColorClass = isChecked ? 'bg-indigo' : 'bg-white';
  	                        row.append(
  	                            '<td><div class="col-auto">' +
  	                                '<label class="form-colorinput">' +
  	                                    '<input name="roles_' + item.id + '" data-admin_id="' + item.id + '" type="radio" value="' + roleValue + '" class="check-input-role form-colorinput-input" ' + (isChecked ? 'checked' : '') + ' />' +
  	                                    '<span class="form-colorinput-color ' + bgColorClass + ' rounded-circle"></span>' +
  	                                '</label>' +
  	                            '</div></td>'
  	                        );
  	                    });

  	                    $('#load_table_admin').append(row);
  	                });

  	                loadPagination(totalPages, currentPage, limit);
  	                
  	              const list = new List('table-default', {
  	              	sortClass: 'table-sort',
  	              	listClass: 'table-tbody',
  	              	valueNames: [ 'sort-id', 'sort-name', 'sort-account', 'sort-email']
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
                  } 
                
                  else {
                      loadData(1, limit, sort);
                  }
        	  }
           
        });
        
        $("#mySelect").change(function() {
            var selectedValue = $(this).val();
            isFiltering = selectedValue !== "0";
            currentPage = 1; 
            if (isFiltering) {
                filterData(currentPage, limit, selectedValue);
            } else {
                loadData(currentPage, limit, sort);
            }
        });
        loadData(currentPage, limit, sort);
    });


    
    
</script>

