<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<c:url var="loadDataBestSeller"
	value="/api/product/dataProductBestSeller"></c:url>
<c:url var="search" value="/api/product/searchBestSeller"></c:url>
<c:url var="urlImg" value="/template/web/img/product/"></c:url>
<!-- Page header -->
<div class="page-header d-print-none">
	<div class="container-xl">
		<div class="row g-2 align-items-center">
			<div class="col">
				<!-- Page pre-title -->
				<div class="page-pretitle">Overview</div>
				<h2 class="page-title">Dashboard V1</h2>
			</div>
			<!-- Page title actions -->
			<div class="col-auto ms-auto d-print-none">
				<div class="btn-list">
					<span class="d-none d-sm-inline"> <a href="#" class="btn">
							New view </a>
					</span> <a href="#" class="btn btn-primary d-none d-sm-inline-block"
						data-bs-toggle="modal" data-bs-target="#modal-report"> <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
						<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
							<path stroke="none" d="M0 0h24v24H0z" fill="none" />
							<path d="M12 5l0 14" />
							<path d="M5 12l14 0" /></svg> Create new report
					</a> <a href="#" class="btn btn-primary d-sm-none btn-icon"
						data-bs-toggle="modal" data-bs-target="#modal-report"
						aria-label="Create new report"> <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
						<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
							height="24" viewBox="0 0 24 24" stroke-width="2"
							stroke="currentColor" fill="none" stroke-linecap="round"
							stroke-linejoin="round">
							<path stroke="none" d="M0 0h24v24H0z" fill="none" />
							<path d="M12 5l0 14" />
							<path d="M5 12l14 0" /></svg>
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
				<div class="row row-cards">
					<div class="col-sm-6 col-lg-3">
						<div class="card card-sm">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-auto">
										<span class="bg-primary text-white avatar"> <!-- Download SVG icon from http://tabler-icons.io/i/currency-dollar -->
											<svg xmlns="http://www.w3.org/2000/svg" class="icon"
												width="24" height="24" viewBox="0 0 24 24" stroke-width="2"
												stroke="currentColor" fill="none" stroke-linecap="round"
												stroke-linejoin="round">
												<path stroke="none" d="M0 0h24v24H0z" fill="none" />
												<path
													d="M16.7 8a3 3 0 0 0 -2.7 -2h-4a3 3 0 0 0 0 6h4a3 3 0 0 1 0 6h-4a3 3 0 0 1 -2.7 -2" />
												<path d="M12 3v3m0 12v3" /></svg>
										</span>
									</div>
									<div class="col">
										<div class="font-weight-medium" id="orderCount">0 Đơn
											Hàng Hôm Nay</div>
										<div class="text-secondary" id="totalPrice"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-lg-3">
						<div class="card card-sm">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-auto">
										<span class="bg-green text-white avatar"> <!-- Download SVG icon from http://tabler-icons.io/i/shopping-cart -->
											<svg xmlns="http://www.w3.org/2000/svg" class="icon"
												width="24" height="24" viewBox="0 0 24 24" stroke-width="2"
												stroke="currentColor" fill="none" stroke-linecap="round"
												stroke-linejoin="round">
												<path stroke="none" d="M0 0h24v24H0z" fill="none" />
												<path d="M6 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" />
												<path d="M17 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" />
												<path d="M17 17h-11v-14h-2" />
												<path d="M6 5l14 1l-1 7h-13" /></svg>
										</span>
									</div>
									<div class="col">
										<div class="font-weight-medium">Phòng Bàn</div>
										<div class="text-secondary" id="table-count"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-lg-3">
						<div class="card card-sm">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-auto">
										<span class="bg-twitter text-white avatar"> <!-- Download SVG icon from http://tabler-icons.io/i/brand-twitter -->
											<svg xmlns="http://www.w3.org/2000/svg" class="icon"
												width="24" height="24" viewBox="0 0 24 24" stroke-width="2"
												stroke="currentColor" fill="none" stroke-linecap="round"
												stroke-linejoin="round">
												<path stroke="none" d="M0 0h24v24H0z" fill="none" />
												<path
													d="M22 4.01c-1 .49 -1.98 .689 -3 .99c-1.121 -1.265 -2.783 -1.335 -4.38 -.737s-2.643 2.06 -2.62 3.737v1c-3.245 .083 -6.135 -1.395 -8 -4c0 0 -4.182 7.433 4 11c-1.872 1.247 -3.739 2.088 -6 2c3.308 1.803 6.913 2.423 10.034 1.517c3.58 -1.04 6.522 -3.723 7.651 -7.742a13.84 13.84 0 0 0 .497 -3.753c0 -.249 1.51 -2.772 1.818 -4.013z" /></svg>
										</span>
									</div>
									<div class="col">
										<div class="font-weight-medium">Sản Phẩm Đang Phục Vụ</div>
										<div class="text-secondary" id="serving-product-count">

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-lg-3">
						<div class="card card-sm">
							<div class="card-body">
								<div class="row align-items-center">
									<div class="col-auto">
										<span class="bg-facebook text-white avatar"> <!-- Download SVG icon from http://tabler-icons.io/i/brand-facebook -->
											<svg xmlns="http://www.w3.org/2000/svg" class="icon"
												width="24" height="24" viewBox="0 0 24 24" stroke-width="2"
												stroke="currentColor" fill="none" stroke-linecap="round"
												stroke-linejoin="round">
												<path stroke="none" d="M0 0h24v24H0z" fill="none" />
												<path
													d="M7 10v4h3v7h4v-7h3l1 -4h-4v-2a1 1 0 0 1 1 -1h3v-4h-3a5 5 0 0 0 -5 5v2h-3" /></svg>
										</span>
									</div>
									<div class="col">
										<div class="font-weight-medium" id="totalProductsSold">
											Tổng Sản Phẩm Đã Bán</div>
										<div class="text-secondary" id="productsSoldToday">Số
											Lượng Sản Phẩm Đã Bán Hôm Nay</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="col-12">
				<div class="card">
					<div
						class="card-header d-flex justify-content-between align-items-center">
						<h3 class="card-title mb-0">Danh sách sản phẩm bán chạy</h3>
						<input type="text" class="form-control w-25"
							placeholder="Tìm kiếm sản phẩm..." name="name" id="search"
							aria-label="Search in website">
					</div>
					<div class="container p-3">
						<div class="row">
							<!-- Phần chiếm 4 cột -->
							<div class="col-md-4">
								<p>Tìm kiếm tùy chọn</p>
								<div class="mb-3">
									<label for="startDate" class="mb-2">Ngày bắt đầu:</label> <input
										id="startDate" class="form-control" />
								</div>
								<div class="mb-3">
									<label for="endDate" class="mb-2">Ngày kết thúc:</label> <input
										id="endDate" class="form-control" />
								</div>
								<a href="#" id="searchFilter" class="btn btn-primary"
									data-bs-toggle="modal" data-bs-target="#modal-report"> <svg
										xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round"
										class="icon icon-tabler icon-tabler-search">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                    <path d="M10 10m-7 0a7 7 0 1 0 14 0a7 7 0 1 0 -14 0" />
                    <path d="M21 21l-6 -6" />
                </svg> Tìm kiếm
								</a>


								<p class="mt-4">Tìm kiếm theo Tuần / Tháng / Năm</p>
								<div class="col-sm-4 m-1">
									<select class="form-select custom-select-width me-2"
										id="tableUserIndex">
										<option value="0" selected>Tuần</option>
										<option value="1">Tháng</option>
										<option value="2">Năm</option>
									</select>
								</div>
							</div>



							<!-- Phần chiếm 8 cột (trống để thêm nội dung sau) -->
							<div class="col-md-8">
								<div class="table-responsive">
									<table
										class="table card-table table-vcenter text-nowrap datatable">
										<thead>
											<tr>
												<th class="w-1"><input
													class="form-check-input m-0 align-middle" type="checkbox"
													aria-label="Select all invoices"></th>
												<th class="w-1">ID <!-- Download SVG icon from http://tabler-icons.io/i/chevron-up -->
													<svg xmlns="http://www.w3.org/2000/svg"
														class="icon icon-sm icon-thick" width="24" height="24"
														viewBox="0 0 24 24" stroke-width="2" stroke="currentColor"
														fill="none" stroke-linecap="round" stroke-linejoin="round">
											<path stroke="none" d="M0 0h24v24H0z" fill="none" />
											<path d="M6 15l6 -6l6 6" /></svg>
												</th>

												<th><button class="table-sort" data-sort="sort-name">TÊN
														SẢN PHẨM</button></th>
												<th><button class="table-sort" data-sort="sort-account">ẢNH
														DANH MỤC</button></th>
												<th><button class="table-sort" data-sort="sort-name">GIÁ</button></th>
												<th><button class="table-sort" data-sort="sort-email">MÔ
														TẢ</button></th>
												<th>SỐ LƯỢNG</th>

											</tr>
										</thead>
										<tbody id="load_table_category" class="table-tbody">

										</tbody>
									</table>
								</div>
								<div class="card-footer d-flex align-items-center">
									<nav class="pagination m-0 ms-auto"
										aria-label="Page navigation">
										<ul class="pagination" id="pagination"></ul>
									</nav>
								</div>
							</div>
						</div>
					</div>

					<div class="card-footer d-flex align-items-center">

						<div class="card-footer d-flex align-items-center">
							<nav class="pagination m-0 ms-auto" aria-label="Page navigation">
								<ul class="pagination" id="pagination"></ul>
							</nav>
						</div>
					</div>
				</div>
			</div>

			
			<div class="col-lg-6">
				<div class="card">
					<div class="card-header border-0">
						<div class="card-title">Hoạt Động Hệ Thống</div>
					</div>
					<div class="position-relative">
	
						<div id="chart-development-activity"></div>
					</div>
					<div style="max-height: 260px; overflow-y: auto;" class="card-table table-responsive">
						<table class="table table-vcenter">
							<thead>
								<tr>
									<th>User</th>
									<th>Activity</th>
									<th>Date</th>
								</tr>
							</thead>
							<tbody>
							
							
				<c:if test="${not empty logs}">
                  		<c:forEach var="item" items="${logs}">
                  		
       								<tr>
									<td class="w-1"><span>${item.createdBy}</span>
									</td>
									<td class="td-truncate">
										<div class="text-truncate">${item.action}</div>
									</td>
									<td class="text-nowrap text-secondary">${item.createdDate}</td>
								</tr>
                        
                  </c:forEach>
                 </c:if>  
                  
							

																				
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div class="col-lg-6">
				<div class="card">
					<div class="card-body">
						<h3 class="card-title">Hoạt Động Đơn Hàng</h3>
						<div id="chart-mentions" class="chart-lg"></div>
					</div>
				</div>
			</div>




		</div>
	</div>
</div>

<script>
$(document).ready(async function() { 
	var pagInitialized = false;
	var currentPage = 1;
	var limit = 3;
	var isSearching = false;
	var urlImg = '${urlImg}';
	var startDate = "";
	var endDate = "";
	var inputValue = "";
	
	function getDateRange(period) {
	    let endDate = new Date(); 
	    let startDate = new Date(); 
	    switch (period) {
	        case '0': 
	            startDate.setDate(endDate.getDate() - 7); 
	            endDate = new Date(); 
	            break;
	        case '1': 
	            startDate.setDate(endDate.getDate() - 30); 
	            endDate = new Date(); 
	            break;
	        case '2': 
	            startDate.setDate(endDate.getDate() - 365); 
	            endDate = new Date(); 
	            break;
	    }

	   

	    return {
	        startDate: startDate.toISOString().split('T')[0],
	        endDate: endDate.toISOString().split('T')[0]
	    };
	}

    function handleSelectChange() {
        var period = $('#tableUserIndex').val(); 
        ({ startDate, endDate } = getDateRange(period)); 
        console.log(loadData);
        loadData(startDate, endDate, currentPage,limit);
    }

 
    $(document).ready(function() {
        handleSelectChange(); 
    });

  
    $('#tableUserIndex').on('change', handleSelectChange);

	
	document.getElementById('searchFilter').addEventListener('click', function(event) {
	    event.preventDefault();

	    startDate = document.getElementById('startDate').value;
	    endDate = document.getElementById('endDate').value;
	    loadData(startDate, endDate, currentPage,limit);
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
	                
	                	 search(inputValue ,startDate, endDate, page,limit); 
	                } else {
	                	loadData(startDate, endDate, page,limit);
	                }
	            }
	        }
	    });

	    pagInitialized = true;
	}


function loadData(startDate, endDate, page, limit, sort) {
    $.ajax({
        url: '${loadDataBestSeller}', 
        method: 'get',
        data: {
        	startDate: startDate,
        	endDate: endDate,
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
                    row.append('<td class="sort-id">' + item.productId + '</td>');      
                    row.append('<td class="sort-name">' + item.productName + '</td>');
                    row.append('<td><div class="col-6">   <div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.productImage + ')"></div></div></td>');
                    row.append('<td class="sort-email"> ' + item.productPrice + '</td>');
                    row.append('<td class="sort-name">' + item.productDesc + '</td>');
                    row.append('<td class="sort-name">' + item.totalQuantity + '</td>');
                
            		 $('#load_table_category').append(row);
                });
         

                loadPagination(response.data.totalPage, currentPage, limit);
             
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

   function search(productName, startDate, endDate, page, limit) {
    $.ajax({
        url: '${search}', 
        method: 'get',
        data: {
            productName: productName,
            startDate: startDate,
            endDate: endDate,
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
                      row.append('<td class="sort-id">' + item.productId + '</td>');      
                      row.append('<td class="sort-name">' + item.productName + '</td>');
                      row.append('<td><div class="col-6">   <div class="img-responsive img-responsive-1x1 rounded-2 border" style="background-image: url(' + urlImg + item.productImage + ')"></div></div></td>');
                      row.append('<td class="sort-email"> ' + item.productPrice + '</td>');
                      row.append('<td class="sort-name">' + item.productDesc + '</td>');
                      row.append('<td class="sort-name">' + item.totalQuantity + '</td>');
                  
              		 $('#load_table_category').append(row);
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

        $('#search').on('keypress', function(e) {
        	  if (e.which === 13) {
        		  e.preventDefault();
        		  inputValue = $(this).val().trim();
                  isSearching = inputValue !== ""; 

                  if (isSearching) {
                	 
                      search(inputValue ,startDate, endDate, currentPage,limit); 
                  } else {
                	  loadData(startDate, endDate, currentPage,limit);
                  }
        	  }
           
        });

     
        
        
        
  async function repeatTask() { 
    try {
      // Gọi bốn API song song
      const [tableCountResponse, totalQuantityResponse, statisticsTodayResponse, productSalesResponse] = await Promise.all([
        $.ajax({
          url: '/CafeManager/api/tableuser/count', 
          type: 'GET',
          dataType: 'json'
        }),
        fetch('/CafeManager/api/table-orders/totalQuantity').then(res => res.json()),
        fetch('/CafeManager/api/orders/statistics-today').then(res => res.json()),
        fetch('/CafeManager/api/orders/product-sales-statistics').then(res => res.json())
      ]);

      // Xử lý response của API table count
      if (tableCountResponse.code === 200) {
        $('#table-count').text(tableCountResponse.data.tableUsed + '/' + tableCountResponse.data.totalTables + ' Bàn Đang Sử Dụng');
      } else {
        console.error('Lỗi khi gọi API table count:', tableCountResponse);
      }

      // Xử lý response của API total quantity
      document.getElementById('serving-product-count').innerText = totalQuantityResponse.totalOrderQuantity + ' Sản Phẩm';

      // Xử lý response của API statistics today
      const orderCountToday = statisticsTodayResponse.orderCount;
      const totalPriceToday = statisticsTodayResponse.totalPrice;

      // Format totalPriceToday (ví dụ: thêm "VNĐ")
      const formattedTotalPriceToday = totalPriceToday.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });

      // Cập nhật nội dung HTML
      document.querySelector('#orderCount').textContent = orderCountToday + " Đơn Hàng Hôm Nay";
      document.querySelector('#totalPrice').textContent = formattedTotalPriceToday;

      // Xử lý response của API product-sales-statistics
      const totalProductsSold = productSalesResponse.totalProductsSold;
      const totalProductsSoldToday = productSalesResponse.totalProductsSoldToday;

      document.getElementById('totalProductsSold').textContent = totalProductsSold + " Sản Phẩm Đã Bán";
      document.getElementById('productsSoldToday').textContent = totalProductsSoldToday + " Sản Phẩm Đã Bán Hôm Nay"; 

    } catch (error) {
      console.error('Lỗi khi gọi API:', error);
    }
  }

  setInterval(repeatTask, 2000); // Gọi hàm repeatTask mỗi 2 giây
});
</script>




<script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('sparkline-activity'), {
      		chart: {
      			type: "radialBar",
      			fontFamily: 'inherit',
      			height: 40,
      			width: 40,
      			animations: {
      				enabled: false
      			},
      			sparkline: {
      				enabled: true
      			},
      		},
      		tooltip: {
      			enabled: false,
      		},
      		plotOptions: {
      			radialBar: {
      				hollow: {
      					margin: 0,
      					size: '75%'
      				},
      				track: {
      					margin: 0
      				},
      				dataLabels: {
      					show: false
      				}
      			}
      		},
      		colors: [tabler.getColor("blue")],
      		series: [35],
      	})).render();
      });
      // @formatter:on
    </script>
<script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-development-activity'), {
      		chart: {
      			type: "area",
      			fontFamily: 'inherit',
      			height: 192,
      			sparkline: {
      				enabled: true
      			},
      			animations: {
      				enabled: false
      			},
      		},
      		dataLabels: {
      			enabled: false,
      		},
      		fill: {
      			opacity: .16,
      			type: 'solid'
      		},
      		stroke: {
      			width: 2,
      			lineCap: "round",
      			curve: "smooth",
      		},
      		series: [{
      			name: "Hoạt Động",
      			data: [3, 5, 4, 6, 7, 5, 6, 8, 24, 7, 12, 5, 6, 3, 8, 17, 19, 15, 14, 25, 32, 22, 22, 11, 15, 12, 2]
      		}],
      		tooltip: {
      			theme: 'dark'
      		},
      		grid: {
      			strokeDashArray: 4,
      		},
      		xaxis: {
      			labels: {
      				padding: 0,
      			},
      			tooltip: {
      				enabled: false
      			},
      			axisBorder: {
      				show: false,
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      		    '2020-08-01', '2020-08-02', '2020-08-03', '2020-08-04', '2020-08-05', '2020-08-06', '2020-08-07', '2020-08-08', '2020-08-09', '2020-08-10',
      		    '2020-08-11', '2020-08-12', '2020-08-13', '2020-08-14', '2020-08-15', '2020-08-16', '2020-08-17', '2020-08-18', '2020-08-19', '2020-08-20',
      		    '2020-08-21', '2020-08-22', '2020-08-23', '2020-08-24', '2020-08-25', '2020-08-26', '2020-08-27'
      		],
      		colors: [tabler.getColor("primary")],
      		legend: {
      			show: false,
      		},
      		point: {
      			show: false
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    
      <script>
      // @formatter:off
      document.addEventListener("DOMContentLoaded", function () {
      	window.ApexCharts && (new ApexCharts(document.getElementById('chart-mentions'), {
      		chart: {
      			type: "bar",
      			fontFamily: 'inherit',
      			height: 240,
      			parentHeightOffset: 0,
      			toolbar: {
      				show: false,
      			},
      			animations: {
      				enabled: false
      			},
      			stacked: true,
      		},
      		plotOptions: {
      			bar: {
      				columnWidth: '50%',
      			}
      		},
      		dataLabels: {
      			enabled: false,
      		},
      		fill: {
      			opacity: 1,
      		},
      		series: [{
      			name: "Đơn Hàng",
      			data: [1, 0, 2, 0, 3, 1, 1, 0, 4, 5]
      		}],
      		tooltip: {
      			theme: 'dark'
      		},
      		grid: {
      			padding: {
      				top: -20,
      				right: 0,
      				left: -4,
      				bottom: -4
      			},
      			strokeDashArray: 4,
      			xaxis: {
      				lines: {
      					show: true
      				}
      			},
      		},
      		xaxis: {
      			labels: {
      				padding: 0,
      			},
      			tooltip: {
      				enabled: false
      			},
      			axisBorder: {
      				show: false,
      			},
      			type: 'datetime',
      		},
      		yaxis: {
      			labels: {
      				padding: 4
      			},
      		},
      		labels: [
      		    '2020-08-18', '2020-08-19', '2020-08-20',
      		    '2020-08-21', '2020-08-22', '2020-08-23', '2020-08-24', '2020-08-25', '2020-08-26', '2020-08-27'
      		],
      		colors: [tabler.getColor("primary"), tabler.getColor("primary", 0.8), tabler.getColor("green", 0.8)],
      		legend: {
      			show: false,
      		},
      	})).render();
      });
      // @formatter:on
    </script>
    
    
</body>
</html>