<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="deleteEmployeeAPI" value="/api/employee/delete"></c:url>
<c:url var="loadEmpData" value="/admin/employee/load-table-employee"></c:url>
<c:url var="loadPaginationData" value="/api/employee/data"></c:url>


<div class="page-header d-print-none">
	<div class="container-xl">
		<div class="row g-2 align-items-center">
			<div class="col">
				<h2 class="page-title">Employee Management</h2>
			</div>
			<!-- Page title actions -->
			<div class="col-auto ms-auto d-print-none">
				<div class="btn-list">
					<span id="btnDelete" class="d-none d-sm-inline"> <a href="#"
						class="btn"> <svg xmlns="http://www.w3.org/2000/svg"
								width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round"
								class="icon icon-tabler icons-tabler-outline icon-tabler-skull">
								<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
								<path
									d="M12 4c4.418 0 8 3.358 8 7.5c0 1.901 -.755 3.637 -2 4.96l0 2.54a1 1 0 0 1 -1 1h-10a1 1 0 0 1 -1 -1v-2.54c-1.245 -1.322 -2 -3.058 -2 -4.96c0 -4.142 3.582 -7.5 8 -7.5z"></path>
								<path d="M10 17v3"></path>
								<path d="M14 17v3"></path>
								<path d="M9 11m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0"></path>
								<path d="M15 11m-1 0a1 1 0 1 0 2 0a1 1 0 1 0 -2 0"></path></svg>
							Delete
					</a>
					</span> <a href="#" class="btn btn-primary d-none d-sm-inline-block">
						<!-- Download SVG icon from http://tabler-icons.io/i/plus --> <svg
							xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
							<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
							<path d="M12 5l0 14"></path>
							<path d="M5 12l14 0"></path></svg> Add Employee
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
<div class="page-body">
	<div class="container-xl">
		<div class="card">
			<div class="card-body">
				<div id="table-default" class="table-responsive">
					<table class="table">
						<thead>
							<tr>
								<th class="w-1"><input id="checkAll" type="checkbox"
									class="form-check-input m-0 align-middle"
									aria-label="Select all invoices"></th>
								<th><button class="table-sort" data-sort="sort-name">Name</button></th>
								<th><button class="table-sort" data-sort="sort-gender">Gender</button></th>
								<th><button class="table-sort" data-sort="sort-dob">Date
										of birth</button></th>
								<th><button class="table-sort" data-sort="sort-email">Email</button></th>
								<th><button class="table-sort" data-sort="sort-phone">Phone</button></th>
								<th><button class="table-sort" data-sort="sort-email">Address</button></th>
							</tr>
						</thead>
						<tbody id="employeeTableBody">
							<c:if test="${not empty employees}">
								<c:forEach items="${employees.listResult}" var="employee">
									<tr>
										<td><input type="checkbox" class="form-check-input m-0"
											aria-label="Select invoice" data-employeeId="${employee.employeeId}"></td>
										
										<td>${employee.employeeName}</td>
										<td>${employee.employeeGender}</td>
										<td>${employee.employeeDateOfBirth}</td>
										<td>${employee.employeeEmail}</td>
										<td>${employee.employeePhone}</td>
										<td>${employee.employeeAddress}</td>
										
									</tr>
								</c:forEach>
							</c:if>
						</tbody>
					</table>
					<div class="card-footer d-flex align-items-center">
						<p class="m-0 text-secondary">
							Showing <span>1</span> to <span>8</span> of <span>16</span>
							entries
						</p>

						<nav class="pagination m-0 ms-auto" aria-label="Page navigation">
							<ul class="pagination" id="pagination"></ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
		var pagInitialized = false;
    	var currentPage = 1; // Khởi tạo currentPage
    	var limit = 3;
    	var isSearching = false;
		
		//bắt sự kiện click button delete
		$("#btnDelete").click(function(){
			var selectedIds = $(".form-check-input:checked").map(function () {
				return $(this).data('employeeid');
		     }).get();
			
			console.log(selectedIds);
			
			if (selectedIds.length === 0) {
   	    	 message_toastr("info", "Vui lòng checkbox vào trường cần xóa!", "Thông báo");
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
		        	  deleteEmployees(selectedIds);		
		          } else if (result.isDenied) {
		            message_toastr("info", "Đã hủy bỏ!");
		          }
		     });
		});
		
		function deleteEmployees(data) {
	        $.ajax({
	            url: '${deleteEmployeeAPI}',
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(data),
	            success: function (result) {
	            	loadData(currentPage, limit); // Sử dụng currentPage
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
    	$(document).on('change', '.form-check-input:not("#checkAll")', function() {
    		
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
    	
    	function loadEmployeeTable() {
            $.ajax({
                url: '${loadEmpData}',
                method: 'GET',
                success: function(data) {
                    $('#employeeTableBody').html(data);
                },
                error: function(error) {
                    console.error("Error loading employee table:", error);
                }
            });
        }
    	

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
    	                } else {
    	                    loadData(page, limit);
    	                }
    	            }
    	        }
    	    });

    	    pagInitialized = true;
    	}
    	
    	function loadData(page, limit) {
    	    $.ajax({
    	        url: '${loadPaginationData}', 
    	        method: 'GET',
    	        data: {
    	            page: page,
    	            limit: limit
    	        },
    	        success: function(response, textStatus, jqXHR) {
    	            if (jqXHR.status === 200) {
    	                $('#employeeTableBody').empty(); // Clear the current table content

    	                var listResult = response.data.listResult;

    	                // Iterate through each employee in the listResult
    	                $.each(listResult, function(index, item) {
    	                    var row = $('<tr></tr>');
    	                    row.append('<td><input type="checkbox" class="form-check-input m-0" data-employeeId="' + item.employeeId + '" aria-label="Select employee"></td>');
    	                    row.append('<td>' + item.employeeName + '</td>');
    	                    row.append('<td>' + item.employeeGender + '</td>');
    	                    row.append('<td>' + new Date(item.employeeDateOfBirth).toLocaleDateString() + '</td>'); // Convert timestamp to date
    	                    row.append('<td>' + item.employeeEmail + '</td>');
    	                    row.append('<td>' + item.employeePhone + '</td>');
    	                    row.append('<td>' + item.employeeAddress + '</td>');

    	                    $('#employeeTableBody').append(row); // Add the row to the table
    	                });

    	                loadPagination(response.data.totalPage, page, limit);
    	            } else {
    	                alert('Invalid data. Status code: ' + jqXHR.status);
    	            }
    	        },
    	        error: function(jqXHR, textStatus, errorThrown) {
    	            alert('Error occurred while fetching data. Status code: ' + jqXHR.status + ', Error: ' + errorThrown);
    	        }
    	    });
    	}

        loadData(currentPage, limit);

    	
});
</script>
