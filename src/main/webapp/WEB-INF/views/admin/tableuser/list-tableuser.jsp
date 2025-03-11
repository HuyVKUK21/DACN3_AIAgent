<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/table-user/save"></c:url>

<c:url var="loadData" value="/api/tableuser/data"></c:url>
<c:url var="downExcel" value="/api/tableuser/download"></c:url>
<c:url var="upExcel" value="/api/tableuser/upload"></c:url>
<c:url var="delete" value="/api/tableuser/delete"></c:url>
<c:url var="updateStatus" value="/admin/table-user/update-status"></c:url>
<c:url var="search" value="/api/tableuser/search"></c:url>
<c:url var="filter" value="/api/tableuser/filter"></c:url>


<!-- Page header -->
<div class="page-header d-print-none">
	<div class="container-xl">
		<div class="row g-2 align-items-center">
			<div class="col">
				<h2 class="page-title">Quản lý bàn</h2>
			</div>
			<!-- Page title actions -->
			<div class="col-auto ms-auto d-print-none">
				<div class="btn-list">
					<span class="d-none d-sm-inline" id="btnDelete"> <a href="#"
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
					</span>


					<div class="text-end">
						<button class="btn btn-success align-text-top"
							data-bs-toggle="modal" data-bs-target="#modal-excel"
							data-bs-boundary="viewport">
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
							Nhập dữ liệu từ Excel
						</button>
					</div>
					<a href="#" class="btn btn-primary d-none d-sm-inline-block"
						data-bs-toggle="modal" data-bs-target="#modal-report"> <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
						<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z"
								fill="none" />
                            <path d="M12 5l0 14" />
                            <path d="M5 12l14 0" />
                        </svg> Thêm Dữ Liệu
					</a>
				</div>
			</div>

		</div>
	</div>
</div>

<div class="modal modal-blur fade" id="modal-excel" tabindex="-1"
	role="dialog" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">Thêm Dữ Liệu Với File Excel</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="card-body">
					<div class="row align-items-center">
						<div class="col-10">
							<h3 class="h1">Mẫu Excel</h3>
							<div class="markdown text-secondary">
								Mẫu dữ liệu chuẩn định dạng Excel tham khảo để nhập dữ liệu. <br>
								Vui lòng tải file mẫu Excel để nhập dữ liệu mới. Chúc bạn nhập
								dữ liệu thành công!
							</div>
							<div class="mt-3">
								<a href="${downExcel}" class="btn btn-primary" target="_blank"
									rel="noopener">Tải xuống</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-body">
				<div class="row">


					<div class="mb-3">
						<div class="form-label">Tải Lên File</div>
						<input type="file" name="uploadExcel" id="uploadExcel"
							class="form-control">
					</div>


				</div>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn btn-link link-secondary"
					data-bs-dismiss="modal"> Hủy </a> <a id="uploadButton" href="#"
					class="btn btn-primary ms-auto" data-bs-dismiss="modal"> <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
					<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
						height="24" viewBox="0 0 24 24" stroke-width="2"
						stroke="currentColor" fill="none" stroke-linecap="round"
						stroke-linejoin="round">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path d="M12 5l0 14" />
                    <path d="M5 12l14 0" />
                </svg> Tạo Mới
				</a>
			</div>
		</div>
	</div>
</div>

<script>
    $(document)
        .ready(
            function () {
                $('#uploadButton')
                    .on(
                        'click',
                        function () {
                            var formData = new FormData();
                            var fileInput = $('#uploadExcel')[0];

                            if (fileInput.files.length > 0) {
                                formData.append('uploadExcel',
                                    fileInput.files[0]);

                                $
                                    .ajax({
                                        url: '${upExcel}',
                                        type: 'POST',
                                        data: formData,
                                        processData: false,
                                        contentType: false, //(jQuery sẽ tự động thiết lập)
                                        success: function (
                                            response) {
                                            $('#message')
                                                .html(
                                                    '<div class="alert alert-success">Tải lên thành công: '
                                                    + response
                                                    + '</div>');
                                        },
                                        error: function (
                                            xhr,
                                            status,
                                            error) {
                                            $('#message')
                                                .html(
                                                    '<div class="alert alert-danger">Tải lên thất bại: '
                                                    + xhr.responseText
                                                    + '</div>');
                                        }
                                    });
                            } else {
                                $('#message')
                                    .html(
                                        '<div class="alert alert-warning">Vui lòng chọn một file để tải lên.</div>');
                            }
                        });
            });
</script>


<form:form modelAttribute="userTableDTO" action="${postURL}"
	method="POST">
	<div class="modal modal-blur fade" id="modal-report" tabindex="-1"
		role="dialog" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Thêm Vào Phòng/Bàn</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
						<label class="form-label">Tên Bàn</label>
						<form:input type="text" class="form-control" path="tableUserName"
							placeholder="Tên Bàn" />
					</div>

					<div class="row">
						<div class="col-lg-8">
							<div class="mb-3">
								<label class="form-label">Số Ghế</label>
								<form:input type="number" class="form-control" min="1"
									path="tableNumberOfChair" placeholder="Số Ghế" />
							</div>
						</div>
						<div class="col-lg-4">
							<div class="mb-3">
								<label class="form-label">Loại Bàn</label>
								<form:select path="tableUserGroup" class="form-select">
									<form:option value="Trong Nhà" label="Trong Nhà" />
									<form:option value="Ngoài Trời" label="Ngoài Trời" />
								</form:select>
							</div>
						</div>
					</div>
				</div>

				<div class="modal-body">
					<div class="row">
						<div class="col-lg-6">
							<div class="mb-3">
								<label class="form-label">Số Thứ Tự</label>
								<form:input type="text" class="form-control"
									path="tableUserIndex" />
							</div>
						</div>
						<div class="col-lg-6">
							<div class="mb-3">
								<label class="form-label">Trạng Thái</label>
								<form:select path="tableUserStatus" class="form-select">
									<form:option value="1" label="Đang Hoạt Động" />
									<form:option value="0" label="Không Hoạt Động" />
								</form:select>
							</div>
						</div>
						<div class="col-lg-12">
							<div>
								<label class="form-label">Ghi Chú</label>
								<form:textarea path="tableUserNote" class="form-control"
									rows="3"></form:textarea>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer">
					<a href="#" class="btn btn-link link-secondary"
						data-bs-dismiss="modal">Hủy</a>
					<button type="submit" class="btn btn-primary ms-auto">
						<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
                            <path stroke="none" d="M0 0h24v24H0z"
								fill="none" />
                            <path d="M12 5l0 14" />
                            <path d="M5 12l14 0" />
                        </svg>
						Tạo Mới
					</button>
				</div>
			</div>
		</div>
	</div>
</form:form>


<!-- Page body -->
<div class="page-body">
	<div class="container-xl">
		<div class="row row-deck row-cards">
			<div class="col-12">
				<div class="card">
					<div class="d-flex align-items-center justify-content-between">
						<h2 class="card-title m-3">Danh sách bàn</h2>

						<div class="d-flex col-sm-10 p-2 pt-3 justify-content-end">
							<div class="col-sm-2 m-1">
							<select class="form-select custom-select-width me-2"
								id="tableUserIndex">
								<option value="0">Số thứ tự	giảm dần</option>
								<option value="1">Số thứ tự tăng dần</option>
							</select>
							</div>
							
							<div class="col-sm-2 m-1">
								<select class="form-select custom-select-width me-2"
									id="tableGroup">
									<option value="Tất cả">Nhóm: Tất cả</option>
									<option value="Trong Nhà">Nhóm: Trong nhà</option>
									<option value="Ngoài Trời">Nhóm: Ngoài trời</option>
								</select>
							</div>

							<div class="col-sm-2 m-1">
								<select class="form-select custom-select-width me-2"
									id="tableNumberOfChair">
									<option value="0">Số ghế: Giảm dần</option>
									<option value="1">Số ghế: Tăng dần</option>
								</select>
							</div>

							<div class="col-sm-2 m-1">
								<select class="form-select custom-select-width me-2"
									id="tableUserName">
									<option value="0">Sắp xếp từ A - Z</option>
									<option value="1">Sắp xếp từ Z - A</option>
								</select>
							</div>
							<div class="col-sm-2 m-1">
								<input type="text" value="" class="form-control w-100"
									placeholder="Tìm kiếm bàn..." name="name" id="search"
									aria-label="Search in website">
							</div>

						</div>
					</div>

					<div class="table-responsive">
						<table id="data-table"
							class="table card-table table-vcenter text-nowrap datatable">
							<thead>
								<tr>
									<th class="w-1"><input
										class="form-check-input m-0 align-middle" type="checkbox"
										id="checkAll" aria-label="Select all invoices"></th>
									<th class="w-1">Mã bàn</th>
									<th>Tên Bàn</th>
									<th>Ghi Chú</th>
									<th>Nhóm</th>
									<th>Số Ghế</th>
									<th>Trạng Thái</th>
									<th>Số Thứ Tự</th>
									<th>Thao tác</th>
								</tr>
							</thead>
							<tbody>
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
</div>

<!-- Libs JS -->
<script
	src="<c:url value='/template/admin/dist/libs/list.js/dist/list.min.js?1692870487' />"
	defer></script>
<script>
    $(document)
        .ready(
            function () {
            	var pagInitialized = false;
            	var currentPage = 1;
            	var limit = 3;
            	var sort = 0;
            	var isSearching = false;
            	var nameSort = "";
            	var tableGroup = "";
            
            
            	
            	
            	var selectElements = document.querySelectorAll('#tableUserName, #tableNumberOfChair, #tableUserIndex');

          
            	selectElements.forEach(function(selectElement) {
            	    selectElement.addEventListener("change", function() {
            	    	sort = this.value;
            	        nameSort = this.id;
            	        loadData(nameSort, currentPage, limit, sort);
            	    });
            	});

           	 
            	var selectTableGroup = document.getElementById("tableGroup");
            	selectTableGroup.addEventListener("change", function() {
            	    tableGroup = this.value;
            	    if(tableGroup === "Tất cả") {
            	    	loadData(nameSort, currentPage, limit, sort);
            	    }
            	    else {
            	    	filterTableUserGroup(this.value, currentPage, limit);
            	    }
            	    
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
        	                	loadData(nameSort, page, limit, sort);
        	                }
        	            }
        	        }
        	    });

        	    pagInitialized = true;
        	}



                $("#btnDelete").click(function () {
                    var selectedIds = $('#data-table tbody input[type="checkbox"]:checked').map(function () {
                        return $(this).data('tableid');
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
                            deleteTableUsers(selectedIds)
                        } else if (result.isDenied) {
                            message_toastr("info", "Đã hủy bỏ!");
                        }
                    });
                });

                function deleteTableUsers(data) {
                    $.ajax({
                        url: '${delete}',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(data),
                        success: function (result) {
                        	loadData(nameSort, currentPage, limit, sort);
                            message_toastr("success", result, "Thông báo");
                        },
                        error: function (error) {
                            message_toastr("error", error, "Thông báo");
                        }
                    });
                }

                // Xử lý sự kiện "Chọn tất cả"
                $("#checkAll").click(function () {
                    $(".form-check-input").not("#checkAll").prop('checked', this.checked);
                });

                // Xử lý sự kiện thay đổi của các checkbox con
                $(document).on('change', '.form-check-input:not("#checkAll")', function () {

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

                $("#uploadButton").click(function(event) {
         	        event.preventDefault();
         	       	location.reload();        
         	       
         	    });
                
                
                function loadData(nameSort, page, limit, sort) {
                    $
                        .ajax({
                            url: '${loadData}',
                            method: 'get',
                            data: {
                            	nameSort: nameSort,
                                page: page,
                                limit: limit,
                                sort: sort
                            },
                            success: function (response,
                                               textStatus, jqXHR) {
                                // Kiểm tra mã trạng thái HTTP
                                if (jqXHR.status === 200) {
                                    // Xóa dữ liệu cũ
                                    $('#data-table tbody').empty();

                                    // Lấy danh sách dữ liệu
                                    var totalPages = response.data.totalPage;
                                    var currentPage = response.data.page;
                                    var limit = response.data.limit;

                                    var listResult = response.data.listResult;

                                    $
                                        .each(
                                            listResult,
                                            function (index,
                                                      item) {
                                                var row = $('<tr></tr>');

                                                row
                                                    .append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-tableId="' + item.userTableID + '" aria-label="Select invoice"></td>');
                                                row
                                                    .append('<td>'
                                                        + item.userTableID
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserName
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserNote
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserGroup
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableNumberOfChair
                                                        + '</td>');
                                                if (item.tableUserStatus == 1) {

                                                    row
                                                        .append('<td>'
                                                            + '<span class="update-status" data-item_id="' + item.userTableID + '" data-item_status="0">'
                                                            + '<label class="form-check form-switch">'
                                                            + '<input class="form-check" type="checkbox" checked>'
                                                            + '</label>'
                                                            + '</span>'
                                                            + '</td>');
                                                } else {

                                                    row
                                                        .append('<td>'
                                                            + '<span class="update-status" data-item_id="' + item.userTableID + '" data-item_status="1">'
                                                            + '<label class="form-check form-switch">'
                                                            + '<input class="form-check" type="checkbox">'
                                                            + '</label>'
                                                            + '</span>'
                                                            + '</td>');
                                                }
                                                row
                                                    .append('<td>'
                                                        + item.tableUserIndex
                                                        + '</td>');
                                                row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="edit?id='+ item.userTableID +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                                                $(
                                                    '#data-table tbody')
                                                    .append(
                                                        row);
                                            });
                                    loadPagination(response.data.totalPage, currentPage, limit);

                                } else {
                                    // Xử lý các mã trạng thái khác nếu cần
                                    alert('Dữ liệu không hợp lệ. Mã trạng thái: '
                                        + jqXHR.status);
                                }
                            },
                            error: function (jqXHR, textStatus,
                                             errorThrown) {
                                // Xử lý lỗi phản hồi HTTP
                                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: '
                                    + jqXHR.status
                                    + ', Lỗi: '
                                    + errorThrown);
                            },
                            complete: function (jqXHR, textStatus) {
                                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                                console
                                    .log('Yêu cầu hoàn tất với mã trạng thái: '
                                        + jqXHR.status);
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
                            	tableUserName: $('#search').val().trim(),
                                page: page,
                                limit: limit
                            },
                            success: function (response,
                                               textStatus, jqXHR) {
                                // Kiểm tra mã trạng thái HTTP
                                if (jqXHR.status === 200) {
                                    // Xóa dữ liệu cũ
                                    $('#data-table tbody').empty();

                                    // Lấy danh sách dữ liệu
                                    var totalPages = response.data.totalPage;
                                    var currentPage = response.data.page;
                                    var limit = response.data.limit;

                                    var listResult = response.data.listResult;

                                    $
                                        .each(
                                            listResult,
                                            function (index,
                                                      item) {
                                                var row = $('<tr></tr>');

                                                row
                                                    .append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-tableId="' + item.userTableID + '" aria-label="Select invoice"></td>');
                                                row
                                                    .append('<td>'
                                                        + item.userTableID
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserName
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserNote
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserGroup
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableNumberOfChair
                                                        + '</td>');
                                                if (item.tableUserStatus == 1) {

                                                    row
                                                        .append('<td>'
                                                            + '<span class="update-status" data-item_id="' + item.userTableID + '" data-item_status="0">'
                                                            + '<label class="form-check form-switch">'
                                                            + '<input class="form-check" type="checkbox" checked>'
                                                            + '</label>'
                                                            + '</span>'
                                                            + '</td>');
                                                } else {

                                                    row
                                                        .append('<td>'
                                                            + '<span class="update-status" data-item_id="' + item.userTableID + '" data-item_status="1">'
                                                            + '<label class="form-check form-switch">'
                                                            + '<input class="form-check" type="checkbox">'
                                                            + '</label>'
                                                            + '</span>'
                                                            + '</td>');
                                                }
                                                row
                                                    .append('<td>'
                                                        + item.tableUserIndex
                                                        + '</td>');
                                                row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="edit?id='+ item.userTableID +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                                                $(
                                                    '#data-table tbody')
                                                    .append(
                                                        row);
                                            });
                                    loadPagination(totalPages,
                                        currentPage, limit);

                                } else {
                                    // Xử lý các mã trạng thái khác nếu cần
                                    alert('Dữ liệu không hợp lệ. Mã trạng thái: '
                                        + jqXHR.status);
                                }
                            },
                            error: function (jqXHR, textStatus,
                                             errorThrown) {
                                // Xử lý lỗi phản hồi HTTP
                                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: '
                                    + jqXHR.status
                                    + ', Lỗi: '
                                    + errorThrown);
                            },
                            complete: function (jqXHR, textStatus) {
                                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                                console
                                    .log('Yêu cầu hoàn tất với mã trạng thái: '
                                        + jqXHR.status);
                            }
                        });
                }

                
               
                // Lọc
                   function filterTableUserGroup(tableUserGroup, page, limit) {
                    $
                        .ajax({
                            url: '${filter}',
                            method: 'get',
                            data: {
                            	tableUserGroup: tableUserGroup,
                                page: page,
                                limit: limit
                            },
                            success: function (response,
                                               textStatus, jqXHR) {
                                // Kiểm tra mã trạng thái HTTP
                                if (jqXHR.status === 200) {
                                    // Xóa dữ liệu cũ
                                    $('#data-table tbody').empty();

                                    // Lấy danh sách dữ liệu
                                    var totalPages = response.data.totalPage;
                                    var currentPage = response.data.page;
                                    var limit = response.data.limit;

                                    var listResult = response.data.listResult;

                                    $
                                        .each(
                                            listResult,
                                            function (index,
                                                      item) {
                                                var row = $('<tr></tr>');

                                                row
                                                    .append('<td><input class="form-check-input m-0 align-middle" type="checkbox" data-tableId="' + item.userTableID + '" aria-label="Select invoice"></td>');
                                                row
                                                    .append('<td>'
                                                        + item.userTableID
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserName
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserNote
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableUserGroup
                                                        + '</td>');
                                                row
                                                    .append('<td>'
                                                        + item.tableNumberOfChair
                                                        + '</td>');
                                                if (item.tableUserStatus == 1) {

                                                    row
                                                        .append('<td>'
                                                            + '<span class="update-status" data-item_id="' + item.userTableID + '" data-item_status="0">'
                                                            + '<label class="form-check form-switch">'
                                                            + '<input class="form-check" type="checkbox" checked>'
                                                            + '</label>'
                                                            + '</span>'
                                                            + '</td>');
                                                } else {

                                                    row
                                                        .append('<td>'
                                                            + '<span class="update-status" data-item_id="' + item.userTableID + '" data-item_status="1">'
                                                            + '<label class="form-check form-switch">'
                                                            + '<input class="form-check" type="checkbox">'
                                                            + '</label>'
                                                            + '</span>'
                                                            + '</td>');
                                                }
                                                row
                                                    .append('<td>'
                                                        + item.tableUserIndex
                                                        + '</td>');
                                                row.append('<td><span id="btnEdit" class="d-none d-sm-inline"> <a href="edit?id='+ item.userTableID +'" class="btn"> <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-note" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#2c3e50" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M13 20l7 -7" /><path d="M13 20v-6a1 1 0 0 1 1 -1h6v-7a2 2 0 0 0 -2 -2h-12a2 2 0 0 0 -2 2v12a2 2 0 0 0 2 2h7" /></svg> Sửa</a></span></td>');

                                                $(
                                                    '#data-table tbody')
                                                    .append(
                                                        row);
                                            });
                                    loadPagination(totalPages,
                                        currentPage, limit);

                                } else {
                                    // Xử lý các mã trạng thái khác nếu cần
                                    alert('Dữ liệu không hợp lệ. Mã trạng thái: '
                                        + jqXHR.status);
                                }
                            },
                            error: function (jqXHR, textStatus,
                                             errorThrown) {
                                // Xử lý lỗi phản hồi HTTP
                                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: '
                                    + jqXHR.status
                                    + ', Lỗi: '
                                    + errorThrown);
                            },
                            complete: function (jqXHR, textStatus) {
                                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                                console
                                    .log('Yêu cầu hoàn tất với mã trạng thái: '
                                        + jqXHR.status);
                            }
                        });
                }

                
                
                $(document).on('click', '.update-status', function () {
                    var userTableID = $(this).data('item_id');
                    var tableUserStatus = $(this).data('item_status');
                    var element = $(this);

                    $.ajax({
                        url: '${updateStatus}',
                        type: 'POST',
                        data: {
                            userTableID: userTableID,
                            tableUserStatus: tableUserStatus
                        },


                        success: function (response) {
                            if (tableUserStatus == 1) {
                                toastr.success("Chuyển Trạng Thái Thành Công!", "Thông báo");
                                element.data('item_status', 0);
                                element.find('.form-check').prop('checked', true);
                            } else {
                                toastr.success("Chuyển Trạng Thái Thành Công!", "Thông báo");
                                element.data('item_status', 1);
                                element.find('.form-check').prop('checked', false);
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("An error occurred: " + xhr.responseText);
                        }
                    });
                });

                
                $('#search').on('keypress', function(e) {
    	        	  if (e.which === 13) {
    	        		  e.preventDefault();
    	        		  var inputValue = $(this).val().trim();
    	                  isSearching = inputValue !== ""; // false

    	                  if (isSearching) {
    	                      search(1, limit); 
    	                  } else {
    	                	  loadData(nameSort, currentPage, limit, sort);
    	                  }
    	        	  }
    	           
    	        });
   
                loadData(nameSort, currentPage, limit, sort);
            });
</script>
