<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:url var="loadGroupTableUser" value="/api/customer/table-user-group"></c:url>
<c:url var="loadDataTableUser" value="/api/customer/data-table-user"></c:url>
<c:url var="updateStatusTable" value="/api/customer/update-status-table"></c:url>
<c:url var="deleteTableUser" value="/api/customer/delete-table-user"></c:url>
<c:url var="loadCategory" value="/api/customer/load-category"></c:url>
<c:url var="loadProduct" value="/api/customer/data-product"></c:url>
<c:url var="urlImgProduct" value="/template/web/img/product/"></c:url>
<c:url var="urlImgCategory" value="/template/web/img/category/"></c:url>
<c:url var="putOrderTable" value="/api/customer/put-order-table"></c:url>
<c:url var="initDataTableOrder" value="/api/customer/init-data-table-order"></c:url>
<c:url var="initDataHeaderTableOrder"
	value="/api/customer/init-data-header-table-order"></c:url>
<c:url var="deleteItemOrder" value="/api/customer/delete-item-order"></c:url>
<c:url var="putQantityItemOrder"
	value="/api/customer/put-quantity-item-order"></c:url>
<c:url var="putOrder" value="/api/customer/put-order"></c:url>
<c:url var="checkOrderTable" value="/api/customer/check-order"></c:url>

<style>
.wrapper {
	height: 35px;
	min-width: 100px;
	display: flex;
	align-items: center;
	justify-content: center;
	background: #FFF;
	border-radius: 12px;
	border: var(- -tblr-border-width) var(- -tblr-border-style)
		var(- -tblr-border-color);;
}

.wrapper span {
	width: 100%;
	text-align: center;
	font-size: 15px;
	font-weight: 600;
	cursor: pointer;
	user-select: none;
}

.wrapper span.num {
	font-size: 15px;
	border-right: 2px solid rgba(0, 0, 0, 0.2);
	border-left: 2px solid rgba(0, 0, 0, 0.2);
	pointer-events: none;
}

.offcanvas-end {
	width: 120vw; /* Thay đổi kích thước theo nhu cầu của bạn */
	max-width: 600px; /* Đặt kích thước tối đa nếu cần */
}

.stepper {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 16px;
  width: 100%;
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.circle {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: #ccc;
  color: white;
  font-weight: bold;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  transition: background-color 0.3s;
}

.step.active .circle {
  background-color: #007bff;
}

.label {
  margin-top: 6px;
  font-size: 14px;
  font-weight: 500;
}

.line {
  width: 60px;
  height: 4px;
  background-color: #ccc;
  position: relative;
  overflow: hidden;
  border-radius: 2px;
}

/* ✅ EFFECT: line lặp lại (loading) */
.line.processing::before {
  content: "";
  position: absolute;
  height: 100%;
  width: 100%;
  background: #007bff;
  animation: repeatLine 1.2s ease-in-out infinite;
  transform-origin: left;
  display: block;
  opacity: 0.6;
}

@keyframes repeatLine {
  0% {
    transform: scaleX(0);
    opacity: 0.2;
    transform-origin: left;
  }
  50% {
    transform: scaleX(1);
    opacity: 1;
    transform-origin: left;
  }
  100% {
    transform: scaleX(0);
    opacity: 0.2;
    transform-origin: right;
  }
}



#chatbot-box {
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    animation: slideUp 0.3s ease;
}

@keyframes slideUp {
    from { transform: translateY(20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}
.user-message {
  background-color: #f1f1f1;
  color: #333 !important;
  padding: 6px 10px;
  border-radius: 8px;
  display: inline-block;
  max-width: 90%;
  word-break: break-word;
}

.bot-message {
  background-color: #e6f0ff;
  color: #0000cc !important;
  padding: 6px 10px;
  border-radius: 8px;
  display: inline-block;
  max-width: 90%;
  word-break: break-word;
}

.message-row {
  margin-bottom: 8px;
}

</style>

<c:if test="${paymentSuccess == true}">
	<style>
#buttonCheckOut, #paymentButton, .plus, .minus, .delete-item-order {
	display: none !important;
}

</style>
</c:if>

<div id="loading" class="page page-center">
	<div class="container container-slim py-4">
		<div class="text-center">
			<div class="mb-3">
				<a href="." class="navbar-brand navbar-brand-autodark"><img
					src="<c:url value='/template/admin/static/img/cover.png' />"
					height="36" alt=""></a>
			</div>
			<div id="textLoading" class="text-secondary mb-3">Đang chuẩn bị
				dữ liệu...</div>
			<div class="progress progress-sm">
				<div class="progress-bar progress-bar-indeterminate"></div>
			</div>
		</div>
	</div>
</div>
<div id="content" class="page" hidden>

<!-- Nút chatbot nổi góc dưới -->
<div id="chatbot-toggle" style="position: fixed; bottom: 20px; right: 20px; z-index: 9999;">
  <button class="btn btn-primary rounded-circle p-3 shadow-lg" onclick="toggleChatbotBox()">
    💬
  </button>
</div>

<!-- Hộp chat -->
<div id="chatbot-container"
     style="position: fixed; bottom: 80px; right: 20px; width: 320px; background-color: #fff;
            border-radius: 16px; box-shadow: 0 4px 24px rgba(0,0,0,0.2);
            display: none; z-index: 9999; overflow: hidden; border: 1px solid #ccc;">

  <div style="background-color: #007bff; color: white; padding: 12px; font-weight: bold;">
    🤖 Trợ lý AI Agent - Hỗ trợ Khách hàng
  </div>

  <div id="chatbox-messages"
       style="height: 240px; overflow-y: auto; padding: 10px; font-size: 14px; background-color: #f8f9fa;">
  </div>

  <div style="border-top: 1px solid #ddd; display: flex;">
    <input id="chatbox-input"
           type="text"
           class="form-control border-0"
           placeholder="Nhập tin nhắn..."
           style="flex: 1; padding: 10px; border-radius: 0; outline: none;" />
    <button class="btn btn-success rounded-0" onclick="sendChatMessage()">Gửi</button>
  </div>
</div>



	<div class="page-wrapper">
		<!-- Page body -->
		<div class="page-body">
			<div class="container-xl">
				<div class="row row-deck row-cards">

					<div class="col-md-12 col-lg-7">
						<div class="card">
							<div class="card-header">
								<ul class="nav nav-tabs card-header-tabs nav-fill"
									data-bs-toggle="tabs">

									<li class="nav-item"><c:choose>
											<c:when test="${paymentSuccess == true}">
												<a class="nav-link active disabled"> <svg
														xmlns="http://www.w3.org/2000/svg" class="icon me-2"
														width="24" height="24" viewBox="0 0 24 24"
														stroke-width="2" stroke="currentColor" fill="none"
														stroke-linecap="round" stroke-linejoin="round">
                <path stroke="none" d="M0 0h24v24H0z" fill="none" />
                <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" />
                <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" />
            </svg> Trạng thái món
												</a>
											</c:when>
											<c:otherwise>
												<a href="#tabs-profile-7" class="nav-link active"
													data-bs-toggle="tab">
													 <svg xmlns="http://www.w3.org/2000/svg" class="icon me-2" width="24"
                                                 height="24"
                                                 viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none"
                                                 stroke-linecap="round"
                                                 stroke-linejoin="round">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                                <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"/>
                                                <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"/>
                                            </svg>
													
													Danh sách món</a>
											</c:otherwise>
										</c:choose></li>
								</ul>
							</div>
							<div class="card-body">
								<div class="tab-content">

									<div class="tab-pane active show" id="tabs-profile-7">
										<c:if test="${paymentSuccess == true}">
											<div class="d-flex justify-content-center mt-4 mb-4">
												<div class="stepper w-500">
													<div class="step step-1 active">
														<div class="circle">1</div>
														<div class="label">Đang chuẩn bị món</div>
													</div>

											
													<div class="line processing" id="line-step-1-2"></div>

													<div class="step step-2">
														<div class="circle">2</div>
														<div class="label">Đã hoàn thành</div>
													</div>

													
												</div>
											</div>
										</c:if>



										<div style="min-height: 500px;">
											<c:if test="${paymentSuccess != true}">
												<div class="mb-3">
													<div id="loadCategory" class="form-selectgroup"></div>

													<div class="input-icon col-3 mt-3">
														<input type="text" id="searchProduct" name="search"
															class="form-control" placeholder="Search…">
													</div>
												</div>
											</c:if>


											<c:choose>
												<c:when test="${paymentSuccess == true}">

												</c:when>
												<c:otherwise>
													<div class="row" id="loadProduct"></div>
												</c:otherwise>
											</c:choose>

										</div>

										<c:choose>
											<c:when test="${paymentSuccess == true}">
												<div class="card-footer d-flex justify-content-center">
													<button type="button" class="btn btn-success px-4 py-2">
														✅ Tôi đã nhận được món</button>
												</div>
											</c:when>
											<c:otherwise>
												<div class="card-footer d-flex align-items-center">
													<p id="txtProduct" class="m-0 text-secondary">
														<!-- Nếu bạn muốn giữ phần text: Trang 1 đến ... -->
													</p>
													<nav class="pagination m-0 ms-auto"
														aria-label="Page navigation">
														<ul class="pagination" id="pagination-product"></ul>
													</nav>
												</div>
											</c:otherwise>
										</c:choose>



									</div>
								</div>
							</div>


						</div>
					</div>


					<%--            <div class="container-xl d-flex flex-column justify-content-center">
            <div class="empty">
              <div class="empty-img"><img src="<c:url value='/template/admin/static/img/undraw_printing_invoices_5r4r.svg' /> " height="128" alt="">
              </div>
              <p class="empty-title">No results found</p>
              <p class="empty-subtitle text-secondary">
                Try adjusting your search or filter to find what you're looking for.
              </p>
            </div>
          </div>  --%>

					<div class="col-md-6 col-lg-5">
						<div class="card">

							<div class="card-header">
								<ul class="nav nav-tabs card-header-tabs" id="tabList"
									data-bs-toggle="tabs">

								</ul>
							</div>
							<div class="card-body">
								<div class="tab-content" id="tabContent">
									<h2>Đơn hàng đã đặt</h2>
									<c:choose>
										<c:when test="${paymentSuccess}">
											<c:choose>
												<c:when test="${paymentSuccess == true}">
													<div class="alert alert-success mt-3">
														✅ <strong>Thanh toán thành công!</strong> Đơn hàng của bạn
														đang được xử lý.
													</div>
												</c:when>
												<c:when test="${paymentSuccess == false}">
													<div class="alert alert-danger mt-3">
														❌ <strong>Thanh toán thất bại.</strong> Vui lòng thử lại
														hoặc đổi phương thức thanh toán.
													</div>
												</c:when>
											</c:choose>


										</c:when>
										<c:when test="${paymentSuccess == false}">
											<div class="alert alert-danger mt-3">
												<strong>❌ Thanh toán thất bại:</strong> Đơn hàng chưa được
												xử lý.
											</div>
										</c:when>
									</c:choose>
								</div>
							</div>


							<div class="card-footer d-flex align-items-center mt-3">
								<div class="d-flex justify-content-between w-100 p-2">
									<!--  <button type="button" class="btn btn-info">Thông Báo</button> -->
									<button id="buttonCheckOut" type="button"
										class="btn btn-success">Thanh toán</button>
								</div>
							</div>



						</div>
					</div>

				</div>
			</div>
		</div>
	</div>


</div>

<div style="width: 100vw;" class="offcanvas offcanvas-end "
	tabindex="-1" id="offcanvasEnd" aria-labelledby="offcanvasEndLabel">

	<div class="offcanvas-header">
		<h2 class="offcanvas-title" id="offcanvasEndLabel">Hóa Đơn</h2>
		<button type="button" class="btn-close text-reset"
			data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>

	<div class="offcanvas-body">
		<div class="card card-lg">
			<div class="card-body">
				<div class="row">
					<div class="col-6">
						<p class="h3">Cửa Hàng</p>
						<address>
							SpringBeanCoffee<br>
						</address>
					</div>
					<div class="col-6 text-end">
						<p class="h3">Khách Hàng</p>
						<address>
							Vãng lai<br>
						</address>
					</div>
					<div class="col-12 my-5">
						<h3>Hóa Đơn Mua Hàng</h3>
					</div>
				</div>
				<table class="table table-transparent table-responsive">
					<thead>
						<tr>
							<th class="text-center" style="width: 1%"></th>
							<th>Sản Phẩm</th>
							<th class="text-center" style="width: 1%">Số Lượng</th>
							<th class="text-end" style="width: 1%">Đơn Giá</th>
							<th class="text-end" style="width: 1%">Tổng Giá</th>
						</tr>
					</thead>
					<tbody id="loadBill">

					</tbody>
				</table>

				<div class="col-12 my-5">
					<h3>Hình thức thanh toán</h3>
					<div class="mb-3">

						<div class="form-selectgroup d-flex justify-content-between">
				
							<label class="form-selectgroup-item"> <input
								type="radio" name="payment" value="2"
								class="form-selectgroup-input" checked> <span
								class="form-selectgroup-label"> <svg
										xmlns="http://www.w3.org/2000/svg" width="24" height="24"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round"
										class="icon icon-tabler icons-tabler-outline icon-tabler-credit-card-pay">
										<path stroke="none" d="M0 0h24v24H0z" fill="none" />
										<path
											d="M12 19h-6a3 3 0 0 1 -3 -3v-8a3 3 0 0 1 3 -3h12a3 3 0 0 1 3 3v4.5" />
										<path d="M3 10h18" />
										<path d="M16 19h6" />
										<path d="M19 16l3 3l-3 3" />
										<path d="M7.005 15h.005" />
										<path d="M11 15h2" /></svg> Thanh toán VNPay
							</span>
							</label>

						</div>

					</div>
				</div>

			</div>
		</div>
	</div>

	<div class="p-2 d-flex justify-content-end">
		<button type="button" class="btn btn-primary  me-2"
			data-bs-dismiss="offcanvas">Hủy</button>

		<button id="paymentButton" type="button" class="btn btn-success  me-2">Thanh
			toán</button>
	</div>

</div>

<script>

$(document).ready(function() {
	 connectWebSocket();
    // Lấy giá trị từ session attributes
    const vnpResponseCode = '${sessionScope.vnpay_response_code}';
    const vnpTransactionStatus = '${sessionScope.vnpay_transaction_status}';
    
    console.log("VNPay Response from session:", {
        responseCode: vnpResponseCode,
        transactionStatus: vnpTransactionStatus
    });

    // Kiểm tra cả ResponseCode và TransactionStatus
    if (vnpResponseCode === "00" && vnpTransactionStatus === "00") {
        console.log("VNPay payment successful");
        
        // Lấy tableId từ sessionStorage
        const pendingTableId = sessionStorage.getItem('pendingTableId');
        console.log("Table ID from session:", pendingTableId);

        if (pendingTableId) {
            // Gọi API putOrder
            $.ajax({
                url: '${putOrder}',
                method: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify({
                    userTableID: parseInt(pendingTableId),
                    paymentID: 2
                }),
                success: function(response) {
                    console.log("putOrder response:", response);
                    if (response.code === 200) {
                        // Thanh toán và lưu đơn hàng thành công
                        message_toastr("success", "Thanh toán thành công và đã lưu đơn hàng!");
                        
                        // Xóa thông tin trong session
                        sessionStorage.removeItem('pendingTableId');
                        
                        // Xóa session attributes của VNPay
                        <% 
                        session.removeAttribute("vnpay_response_code");
                        session.removeAttribute("vnpay_transaction_status");
                        %>
                        
                  
                    } else {
                        message_toastr("error", "Lỗi khi lưu đơn hàng: " + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error saving order:", {
                        status: xhr.status,
                        statusText: xhr.statusText,
                        responseText: xhr.responseText,
                        error: error
                    });
                    message_toastr("error", "Lỗi khi lưu đơn hàng: " + error);
                }
            });
        } else {
            console.error("No pending table ID found in session");
            message_toastr("error", "Không tìm thấy thông tin bàn cần thanh toán");
        }
    } else if (vnpResponseCode) { // Đã sửa điều kiện này
        // Thanh toán thất bại
        message_toastr("error", "Thanh toán thất bại! Mã lỗi: " + vnpResponseCode);
        sessionStorage.removeItem('pendingTableId');
        
        // Xóa session attributes của VNPay
        <% 
        session.removeAttribute("vnpay_response_code");
        session.removeAttribute("vnpay_transaction_status");
        %>
    }
});

    var currentIndexPageProduct = 1;
    var limitPageProduct = 6;
    var currentIndexPageTable = 1;
    var limitPageTable = 16;

    function message_toastr(type, content) {
        toastr.options = {
            "closeButton": true,
            "debug": true,
            "newestOnTop": false,
            "progressBar": true,
            "positionClass": "toast-top-right",
            "preventDuplicates": true,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
        toastr[type](content);
    }

    function message_toastr(type, content, title) {
        // Cấu hình các tùy chọn cho toastr
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "newestOnTop": false,
            "progressBar": false,
            "positionClass": "toast-top-right",
            "preventDuplicates": false,
            "onclick": null,
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "5000",
            "extendedTimeOut": "1000",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };

        // Gọi toastr với các tham số được truyền vào
        toastr[type](content, title);
    }

    function activateTab(tabId) {
        const $targetTab = $('#tabList').find(`a[href="#${tabId}"]`);
        if ($targetTab.length) {
            $targetTab.tab('show');
        }
    }
    
    function checkAndAddEmptyContent() {
        // Kiểm tra nếu cả #tabList và #tabContent đều không có nội dung HTML
     
        
        if (!$.trim($('#tabList').html()) && !$.trim($('#tabContent').html())) {
            // Thêm nội dung HTML vào #tabContent
           
            $('#tabContent').html(`
                <div class="container-xl d-flex flex-column justify-content-center">
                    <div class="empty">
                        <div class="empty-img">
                            <img src="<c:url value='/template/admin/static/img/undraw_printing_invoices_5r4r.svg' />" height="128" alt="">
                        </div>
                        <p class="empty-title">Chưa có bàn nào được chọn</p>
                        <p class="empty-subtitle text-secondary">
                            Quán ế quá...
                        </p>
                    </div>
                </div>
            `);
        }else {
            // Nếu có nội dung trong #tabList hoặc #tabContent, xóa phần thông báo rỗng
            $('#tabContent .container-xl').remove();
        }
    }

 	// chatbot
function toggleChatbotBox() {
    const chatbox = document.getElementById("chatbot-container");
    const input = document.getElementById("chatbox-input");

    // Toggle hiển thị
    const isHidden = chatbox.style.display === "none" || chatbox.style.display === "";
    chatbox.style.display = isHidden ? "block" : "none";

    if (isHidden) {
        setTimeout(() => {
            input.focus();
        }, 100);

        // Gắn lại sự kiện Enter mỗi khi mở
        input.onkeydown = function (event) {
            if (event.key === "Enter") {
                sendChatMessage();
            }
        };
    } else {
        input.blur();
    }
}
 	
	let chatSession = {
		    id: Math.random().toString(36).substring(7),
		    messages: []
		};

 	
	function sendChatMessage() {
	    const input = document.getElementById("chatbox-input");
	    const message = input.value.trim();
	    
	    if (message === "") return;
	    
	    // Hiển thị tin nhắn người dùng
	    appendMessage("Bạn", message, "user-message");
	    
	    // Lấy ID bàn hiện tại
	    const activeTabId = getActiveTabId();
	    if (!activeTabId) {
	        appendMessage("Bot", "Vui lòng chọn bàn trước khi đặt món!", "bot-message");
	        input.value = "";
	        return;
	    }

	    const tableId = activeTabId.split('-')[1];

	    // Gửi yêu cầu tới AI Agent
	    fetch("http://localhost:5005/chat", {
	        method: "POST",
	        headers: { "Content-Type": "application/json" },
	        body: JSON.stringify({ 
	            message: message,
	            session_id: chatSession.id,
	            table_id: tableId
	        })
	    })
	    .then(res => res.json())
	    .then(data => {
	        const botReply = data.response;
	        appendMessage("Bot", botReply, "bot-message");

	        // Nếu có action checkout, kích hoạt flow thanh toán
	        if (data.action === 'checkout') {
	            // Kiểm tra đơn hàng và lấy tổng tiền
	            $.ajax({
	                url: '${checkOrderTable}',
	                type: 'GET',
	                contentType: 'application/json',
	                data: {
	                    userTableID: tableId
	                },
	                success: function(checkResponse) {
	                    if (checkResponse.data && checkResponse.data.totalProductPrice) {
	                        const amount = checkResponse.data.totalProductPrice;
	                        
	                        // Lưu thông tin vào sessionStorage
	                        sessionStorage.setItem('pendingTableId', tableId);
	                        console.log("Saved to session - Table ID:", tableId);
	                        
	                        // Gọi API tạo URL VNPay và chuyển hướng
	                        $.ajax({
	                            url: '/CafeManager/vnpay/create-url',
	                            method: 'POST',
	                            contentType: 'application/json',
	                            data: JSON.stringify({
	                                amount: amount,
	                                orderInfo: 'Thanh toan hoa don ban ' + tableId,
	                                ipAddress: '${pageContext.request.remoteAddr}'
	                            }),
	                            success: function(url) {
	                                // Chuyển sang trang VNPay
	                                window.location.href = url;
	                            },
	                            error: function() {
	                                message_toastr("error", "Không thể tạo link thanh toán VNPay");
	                                sessionStorage.removeItem('pendingTableId');
	                            }
	                        });
	                    } else {
	                        message_toastr("error", "Không thể lấy thông tin tổng tiền đơn hàng");
	                    }
	                },
	                error: function(xhr, status, error) {
	                    message_toastr("error", "Lỗi khi kiểm tra đơn hàng: " + error);
	                }
	            });
	        }

	        // Nếu có thông tin đặt món
	        if (data.order) {
	            handleOrderFromBot(data.order, activeTabId);
	        }
	    })
	    .catch(err => {
	        appendMessage("Bot", "❌ Lỗi: " + err.message, "bot-message error");
	    });

	    input.value = "";
	    input.focus();
	}
	
	function handleOrderFromBot(orderData, activeTabId) {
	    const {productId, quantity} = orderData;
	    
	    // Gọi API thêm món
	    $.ajax({
	        url: '${putOrderTable}',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	            orderQuantity: quantity,
	            userTableID: activeTabId.split('-')[1],
	            productId: productId
	        }),
	        success: function(response) {
	            if (response.code === 200) {
	                // Cập nhật UI ngay lập tức
	                if (response.data) {
	                    appendContentTabActive(response.data, activeTabId);
	                    message_toastr("success", "Đã thêm món vào đơn hàng");
	                    
	                    // Gửi thông báo qua WebSocket
	                    notifyNewOrder(activeTabId.split('-')[1]);
	                }
	            } else {
	                message_toastr("error", "Không thể thêm món: " + response.message);
	            }
	        },
	        error: function(xhr, status, error) {
	            message_toastr("error", "Lỗi khi thêm món: " + error);
	        }
	    });
	}

	// Cập nhật hàm handleOrderStatusUpdate để xử lý realtime
	function handleOrderStatusUpdate(statusUpdate) {
    console.log('Received order status update:', statusUpdate);
    
    if (statusUpdate.tableId === '${idTable}') {
        if (statusUpdate.type === 'ORDER_COMPLETED') {
            // Cập nhật UI khi đơn hàng hoàn thành
            $('.step.step-2').addClass('active');
            $('#line-step-1-2').removeClass('processing');
            $('#line-step-1-2').css('background-color', '#007bff');
            
            // Hiển thị thông báo
            message_toastr("success", "Đơn hàng của bạn đã được hoàn thành!");
            
            // Cập nhật trạng thái nút
            $('.btn.btn-success.px-4.py-2')
                .text('✅ Đơn hàng đã hoàn thành')
                .prop('disabled', true)
                .css('opacity', '0.7');
                
            // Vô hiệu hóa các nút thao tác với đơn hàng
            $('.add-item, .delete-item-order, .plus, .minus').prop('disabled', true);
            
            // Ẩn nút thanh toán và các nút khác
            $('#buttonCheckOut, #paymentButton').hide();
        }
    }
}
	
	function appendMessage(sender, text, className) {
	    const messagesBox = document.getElementById("chatbox-messages");
	    const messageDiv = document.createElement("div");
	    messageDiv.className = "message-row";

	    const senderLabel = document.createElement("strong");
	    senderLabel.textContent = sender + ":";
	    if (sender === "Bot") {
	        senderLabel.style.color = "#007bff";
	    }

	    const messageText = document.createElement("span");
	    messageText.className = className;
	    messageText.textContent = text;

	    messageDiv.appendChild(senderLabel);
	    messageDiv.appendChild(document.createTextNode(" "));
	    messageDiv.appendChild(messageText);
	    messagesBox.appendChild(messageDiv);
	    messagesBox.scrollTop = messagesBox.scrollHeight;
	}

	
	function addItemToOrder(orderData, tabId) {
	    const {item, quantity, price, total} = orderData;
	    
	    $.ajax({
	        url: '${putOrderTable}',
	        type: 'POST',
	        contentType: 'application/json',
	        data: JSON.stringify({
	            orderQuantity: quantity,
	            userTableID: tabId.split('-')[1],
	            productId: item.productId
	        }),
	        success: function(response) {
	            if (response.code === 200) {
	                message_toastr("success", `Đã thêm ${quantity} ${item} vào đơn hàng`);
	                // Reload tab content
	                reloadOrderData(tabId.split('-')[1], tabId);
	            }
	        },
	        error: function(xhr, status, error) {
	            message_toastr("error", "Lỗi khi thêm món: " + error);
	        }
	    });
	}

document.addEventListener("DOMContentLoaded", function () {
    const messagesBox = document.getElementById("chatbox-messages");

    const welcomeDiv = document.createElement("div");
    welcomeDiv.className = "message-row";

    const botLabel = document.createElement("strong");
    botLabel.textContent = "Bot:";
    botLabel.style.color = "#007bff";

    const welcomeText = document.createElement("span");
    welcomeText.className = "bot-message";
    welcomeText.textContent = "Xin chào! Tôi là AI Agent – Hỗ trợ bạn chọn món và trả lời mọi thắc mắc.";

    welcomeDiv.appendChild(botLabel);
    welcomeDiv.appendChild(document.createTextNode(" "));
    welcomeDiv.appendChild(welcomeText);

    messagesBox.appendChild(welcomeDiv);
    messagesBox.scrollTop = messagesBox.scrollHeight;
});



// Hỗ trợ nhấn Enter để gửi tin
document.addEventListener("DOMContentLoaded", function () {
    const input = document.getElementById("chatbox-input");
    input.addEventListener("keydown", function (event) {
        if (event.key === "Enter") {
            sendChatMessage();
        }
    });
});




    function setupEventItemOrder() {
        $('.list-group.list-group-flush.list-group-hoverable').each(function () {
            var $tableOrder = $(this);
            var $delete = $tableOrder.find('.delete-item-order');

            $delete.on('click', function () {
                Swal.fire({
                    title: "Xóa Sản Phẩm ?",
                    text: "Bạn muốn xóa sản phẩm này ra khỏi bàn ?",
                    icon: "info",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Xác Nhận"
                }).then((result) => {
                    if (result.isConfirmed) {
                        var id = $(this).data('id');
                        deleteItemOrder(id);
                    }
                });


            });
        });

        $('.wrapper').each(function () {
            var $wrapper = $(this);
            var $minus = $wrapper.find('.minus');
            var $num = $wrapper.find('.num');
            var $plus = $wrapper.find('.plus');

            $minus.on('click', function () {
                var tableOrderId = $(this).data('id');
                var currentVal = parseInt($num.text(), 10);
                if (currentVal > 1) { // Ensure value doesn't go below 0
                    //$num.text(currentVal - 1);
                    putQantityItemOrder(tableOrderId, currentVal - 1, $num);
                }
            });

            $plus.on('click', function () {
                var tableOrderId = $(this).data('id');

                var currentVal = parseInt($num.text(), 10);

                putQantityItemOrder(tableOrderId, currentVal + 1, $num);
            });

        });
    }

    function loadPaginationTableUser(totalPages, currentPage, limit) {
        $('#pagination-tableuser').twbsPagination('destroy');
        $(function () {
            window.pagObj = $('#pagination-tableuser').twbsPagination({
                totalPages: totalPages,
                visiblePages: 3,
                startPage: currentPage,
                first: '<',
                prev: 'Trước',
                next: 'Tiếp',
                last: '>',
                onPageClick: function (event, page) {

                    if (currentIndexPageTable == page) {

                    } else {
                        loadDataTableUser(page, limit);
                        currentIndexPageTable = page;
                    }

                }
            })
        });
    }

    function loadGroupTableUser() {
        $.ajax({
            url: '${loadGroupTableUser}',
            method: 'get',
            success: function (response, textStatus, jqXHR) {
                // Kiểm tra mã trạng thái HTTP
                if (response.code === 200) {

                    var data = response.data;
                    var radioGroup = $('#loadGroupTableUser');

                    $.each(data, function (index, item) {
                        var label = '<label class="form-selectgroup-item">' +
                            '<input type="radio" name="groupTableUser" value="' + item + '" class="form-selectgroup-input">' +
                            '<span class="form-selectgroup-label">' + item + '</span>' +
                            '</label>';
                        radioGroup.append(label); // Append the new radio button
                    });

                } else {
                    // Xử lý các mã trạng thái khác nếu cần
                    alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + response.message);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Xử lý lỗi phản hồi HTTP
                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }


    function loadDataTableUser(page, limit) {

        var valueGroupTableUser = $('input[name="groupTableUser"]:checked').val();

        var valueGroupStatusTable = $('input[name="groupStatusTable"]:checked').val();

        /*  alert(valueGroupTableUser +' - '+ valueGroupStatusTable);  */

        $.ajax({
            url: '${loadDataTableUser}',
            method: 'get',
            data: {
                page: page,
                limit: limit,
                tableUserGroup: valueGroupTableUser,
                tableUserStatus: valueGroupStatusTable
            },
            success: function (response, textStatus, jqXHR) {
                // Kiểm tra mã trạng thái HTTP
                if (jqXHR.status === 200) {
                    // Xóa dữ liệu cũ
                    $('#tableListTableUser').empty();

                    // Lấy danh sách dữ liệu
                    var totalPages = response.data.totalPage;
                    var currentPage = response.data.page;
                    var limit = response.data.limit;

                    $('#txtPage').html('Trang ' + currentPage + ' đến ' + totalPages + ' trên tổng ' + response.data.totalItem + ' bàn');

                    var listResult = response.data.listResult;


                    $.each(listResult, function (index, item) {


                        var tableHtml = '<div class="col-6 col-sm-3 mt-3">' +
                            '<label class="form-selectgroup-item">' +
                            '<input type="checkbox" name="icons" value="' + item.userTableID + '" class="form-selectgroup-input checkbox-table-' + item.userTableID + '"' +
                            (item.tableUserStatus === 1 ? ' checked' : '') + '>' +
                            '<span class="form-selectgroup-label">' +
                            '<svg xmlns="http://www.w3.org/2000/svg" class="icon me-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">' +
                            '<path stroke="none" d="M0 0h24v24H0z" fill="none"></path>' +
                            '<path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"></path>' +
                            '</svg>' + item.tableUserName + '-' + item.tableUserGroup +
                            '</span>' +
                            '</label>' +
                            '</div>';

                        $('#tableListTableUser').append(tableHtml);


                    });
                    loadPaginationTableUser(totalPages, currentPage, limit);

                } else {
                    // Xử lý các mã trạng thái khác nếu cần
                    alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Xử lý lỗi phản hồi HTTP
                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }

    function updateStatusTable(id, value) {

        $.ajax({
            url: '${updateStatusTable}',
            method: 'get',
            data: {
                userTableID: id,
                tableUserStatus: value
            },
            success: function (response, textStatus, jqXHR) {
                // Kiểm tra mã trạng thái HTTP
                if (jqXHR.status === 200) {


                } else {
                    // Xử lý các mã trạng thái khác nếu cần
                    alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + jqXHR.status);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Xử lý lỗi phản hồi HTTP
                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }

    function loadCategory() {
        $.ajax({
            url: '${loadCategory}',
            method: 'get',
            success: function (response, textStatus, jqXHR) {
                // Kiểm tra mã trạng thái HTTP
                if (response.code === 200) {

                    var data = response.data;
                    var loadCategory = $('#loadCategory');

                    $.each(data, function (index, item) {

                        var loadData = '<label class="form-selectgroup-item">' +
                            '<input type="checkbox" name="category" value="' + item.categoryId + '" class="form-selectgroup-input">' +
                            '<span class="form-selectgroup-label">' + item.categoryName + '</span>' +
                            '</label>';
                        loadCategory.append(loadData);
                    });

                    $('input[name="category"]').prop('checked', true);

                } else {
                    // Xử lý các mã trạng thái khác nếu cần
                    alert('Dữ liệu không hợp lệ ở danh mục. Mã trạng thái: ' + response.message);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Xử lý lỗi phản hồi HTTP
                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }

    function setItemOrder(item, tabId) {
        $('#' + tabId + ' .list-group.list-group-flush.list-group-hoverable').append(
            '<div id="' + item.tableOrderId + '" class="list-group-item">' +
            '<div class="row align-items-center">' +
            '<div class="col-auto">' +
            '<span class="badge bg-green"></span>' +
            '</div>' +
            '<div class="col-auto">' +
            '<span class="avatar" style="background-image: url(' + '${urlImgProduct}' + item.product.productImage + ')"></span>' +
            '</div>' +
            '<div class="col text-truncate">' +
            '<div class="text-reset d-block">' + item.product.productName + '</div>' +
            '<div class="d-block text-secondary text-truncate mt-n1">' + item.product.productPrice + 'đ</div>' +
            '</div>' +
            '<div class="col-auto">' +
            '<div class="wrapper">' +
            '<span class="minus" data-id="' + item.tableOrderId + '">-</span>' +
            '<span class="num">' + item.orderQuantity + '</span>' +
            '<span class="plus" data-id="' + item.tableOrderId + '">+</span>' +
            '</div>' +
            '</div>' +
            '<div class="col-auto">' +
            '<a href="#" class="list-group-item-actions delete-item-order" data-id ="' + item.tableOrderId + '">' +
            '<svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="currentColor"  class="icon icon-tabler icons-tabler-filled icon-tabler-xbox-x"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M12 2c5.523 0 10 4.477 10 10s-4.477 10 -10 10s-10 -4.477 -10 -10s4.477 -10 10 -10m3.6 5.2a1 1 0 0 0 -1.4 .2l-2.2 2.933l-2.2 -2.933a1 1 0 1 0 -1.6 1.2l2.55 3.4l-2.55 3.4a1 1 0 1 0 1.6 1.2l2.2 -2.933l2.2 2.933a1 1 0 0 0 1.6 -1.2l-2.55 -3.4l2.55 -3.4a1 1 0 0 0 -.2 -1.4" /></svg>' +
            '</a>' +
            '</div>' +
            '</div>' +
            '</div>'
        )
    }

    function appendContentTabActive(data, activeTabId) {

        $('#' + activeTabId + ' .list-group.list-group-flush.list-group-hoverable').empty();

        data.forEach((item, index) => {
            setItemOrder(item, activeTabId);
        });

        setupEventItemOrder();

    }

    function deleteItemOrder(tableOrderId) {
        $.ajax({
            type: 'DELETE',
            url: '${deleteItemOrder}',
            data: JSON.stringify({
                tableOrderId: tableOrderId,
            }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function (response) {
                message_toastr("success", response.message)
                $("#" + tableOrderId).remove();
            },
            error: function (xhr, status, error) {
                console.error('Error: ' + error);
                alert('Error: ' + xhr.responseText);
            },
            complete: function (jqXHR, textStatus) {
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }


    function putQantityItemOrder(tableOrderId, currentVal, $num) {
        $.ajax({
            type: 'PUT', // Hoặc 'GET' tùy theo yêu cầu
            url: '${putQantityItemOrder}', // Đường dẫn đến server-side handler
            data: JSON.stringify({
                tableOrderId: tableOrderId,
                orderQuantity: currentVal,
            }), // Dữ liệu gửi đi, có thể là JSON hoặc URL-encoded
            contentType: 'application/json; charset=utf-8', // Loại dữ liệu gửi đi
            dataType: 'json', // Loại dữ liệu mà bạn mong đợi từ server (json, html, text, etc.)
            success: function (response) {
                // Xử lý phản hồi thành công từ server
                $num.text(currentVal);
                //alert('status: ' + response.message);
            },
            error: function (xhr, status, error) {
                // Xử lý lỗi nếu có
                console.error('Error: ' + error);
                alert('Error: ' + xhr.responseText);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }

    function initDataHeaderTableOrder() {

        $.ajax({
            url: '${initDataHeaderTableOrder}',
            type: 'GET',
            contentType: 'application/json',
            success: function (response) {


                response.data.forEach((item, index) => {
                    // Khởi Tạo Header TableOrder
                    const tabId = 'tab-' + item.userTableID;

                    $('#tabList').append(
                        '<li class="nav-item">' +
                        '<a href="#' + tabId + '" class="tab-open nav-link ' +
                        (index === 0 ? 'active' : '') +
                        '" data-bs-toggle="tab" aria-selected="' + (index === 0 ? 'true' : 'false') + '" role="tab" tabindex="-1">' +
                        item.tableUserName +
                        '<svg data-tab="' + tabId + '" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="-5 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-x close">' +
                        '<path stroke="none" d="M0 0h24v24H0z" fill="none" />' +
                        '<path d="M18 6l-12 12" />' +
                        '<path d="M6 6l12 12" />' +
                        '</svg>' +
                        '</a>' +
                        '</li>'
                    );

                    $('#tabContent').append(
                        '<div id="' + tabId + '" class="tab-room-table-content tab-pane ' +
                        (index === 0 ? 'active show' : '') + '">' +
                        '<div class="col-12">' +
                        '<div class="card">' +
                        '<div class="list-group list-group-flush list-group-hoverable">' +

                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>'
                    );


                });


            },
            error: function (xhr, status, error) {
                console.error('Error sending data:', status, error);
            }
        });
    }

    function initDataTableOrder() {

        $.ajax({
            url: '${initDataTableOrder}',
            type: 'GET',
            contentType: 'application/json',
            success: function (response) {

                //	  let uniqueTables = {};


                response.data.forEach((item, index) => {
                    const tableUser = item.tableUser;
                    const product = item.product;
                    const tabId = 'tab-' + tableUser.userTableID;
                    // Load Nội Dung Của Từng Table
                    setItemOrder(item, tabId);
                });


                setupEventItemOrder();

            },
            error: function (xhr, status, error) {
                console.error('Error sending data:', status, error);
            }
        });
    }

     function loadPaginationProduct(totalPages, currentPage, limit) {
        $('#pagination-product').twbsPagination('destroy');
        $(function () {
            window.pagObj = $('#pagination-product').twbsPagination({
                totalPages: totalPages,
                visiblePages: 3,
                startPage: currentPage,
                first: '<',
                prev: 'Trước',
                next: 'Tiếp',
                last: '>',
                onPageClick: function (event, page) {
                    if (currentIndexPageProduct == page) {
                    } else {
                        loadDataTableProduct(page, limit);
                        currentIndexPageProduct = page;
                    }

                }
            })
        });
    } 

    function loadDataTableProduct(page, limit) {

        var ids = $('input[name=category]:checked').map(function () {
            return $(this).val();
        }).get();

        var search = $("#searchProduct").val();


        $.ajax({
            url: '${loadProduct}',
            method: 'get',
            traditional: true,
            data: {
                page: page,
                limit: limit,
                idcategory: ids,
                search: search
            },
            success: function (response, textStatus, jqXHR) {
                // Kiểm tra mã trạng thái HTTP
                if (jqXHR.status === 200) {
                    // Xóa dữ liệu cũ
                    $('#loadProduct').empty();

                    // Lấy danh sách dữ liệu
                    var totalPages = response.data.totalPage;
                    var currentPage = response.data.page;
                    var limit = response.data.limit;

                    $('#txtProduct').html('Trang ' + currentPage + ' đến ' + totalPages + ' trên tổng ' + response.data.totalItem + ' sản phẩm');

                    var listResult = response.data.listResult;


                    $.each(listResult, function (index, item) {

                        var tableHtml = '<div class="col-6 col-sm-4">' +
                            '<div class="add-item card card-sm mt-3" ' +
                            '" data-id="' + item.productId +
                            '" data-name="' + item.productName +
                            '" data-price="' + item.productPrice +
                            '" data-img="' + '${urlImgProduct}' + item.productImage + '">' +
                            '<a href="#" class="d-block">' +
                            '<img src="' + '${urlImgProduct}' + item.productImage + '" class="card-img-top">' +
                            '</a>' +
                            '<div class="card-body">' +
                            '<div class="d-flex align-items-center">' +
                            '<span class="avatar me-3 rounded" style="background-image: url(' + '${urlImgCategory}' + item.category.categoryImage + ')"></span>' +
                            '<div>' +
                            '<div>' + item.productName + '</div>' +
                            '<div class="text-secondary">' + item.productPrice + 'đ</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>' +
                            '</div>';

                        $('#loadProduct').append(tableHtml);

                    });
                    loadPaginationProduct(totalPages, currentPage, limit);

                } else {
                    // Xử lý các mã trạng thái khác nếu cần
                    alert('Dữ liệu không hợp lệ ở sản phẩm . Mã trạng thái: ' + jqXHR.status);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Xử lý lỗi phản hồi HTTP
                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }

    function deleteTableOrder(userTableID) {

        $.ajax({
            url: '${deleteTableUser}',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                userTableID: userTableID
            }),
            success: function (response, textStatus, jqXHR) {
                // Kiểm tra mã trạng thái HTTP
                console.log(response.message);
                if (response.code === 200) {


                } else {
                    // Xử lý các mã trạng thái khác nếu cần
                    alert('Dữ liệu không hợp lệ. Mã trạng thái: ' + response.message);
                }
            },
            error: function (jqXHR, textStatus, errorThrown) {
                // Xử lý lỗi phản hồi HTTP
                alert('Có lỗi xảy ra khi lấy dữ liệu. Mã trạng thái: ' + jqXHR.status + ', Lỗi: ' + errorThrown);
            },
            complete: function (jqXHR, textStatus) {
                // Có thể thực hiện các hành động sau khi yêu cầu hoàn tất
                console.log('Yêu cầu hoàn tất với mã trạng thái: ' + jqXHR.status);
            }
        });
    }


    function getActiveTabId() {
        const $activeTab = $('.tab-room-table-content.active.show');
        if ($activeTab.length === 0) {
            return null;
        }
        return $activeTab.attr('id');
    }


    function deleteTable(tabTitle, tabId, value) {
        const $tabToRemove = $('#tabList').find('a[href="#' + tabId + '"]').closest('li');
        const $contentToRemove = $('#tabContent').find('#' + tabId);


        const indexToRemove = $tabToRemove.index();
        $tabToRemove.remove();
        $contentToRemove.remove();

        updateStatusTable(value, 0);
        deleteTableOrder(value);

        $('input[name="icons"][value="' + value + '"]').prop('checked', false);


        const $activeTab = $('#tabList').find('.tab-open.active.show'); // Lọc các tab đang active
        if ($activeTab.length === 0) {
            const $firstTab = $('#tabList').find('.tab-open').first();
            $firstTab.tab('show');
        }
    }

    function confirmDeleteTable(tabTitle, tabId, value) {

        Swal.fire({
            title: "Hủy " + tabTitle + " ?",
            text: "Các sản phẩm được đặt ở bàn cũng sẽ xóa theo!",
            icon: "info",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Xác Nhận"
        }).then((result) => {
            if (result.isConfirmed) {
                deleteTable(tabTitle, tabId, value);
                checkAndAddEmptyContent();
            }else{
            	 $('input[name="icons"][value="' + value + '"]').prop('checked', true);
            }
        });

    }

</script>

<script type="text/javascript">

<c:if test="${not empty idTable}">
const value = '${idTable}';
const tabId = 'tab-' + value;
const tabTitle = 'Bàn ' + value;

$('#tabList').append(
    '<li class="nav-item">' +
    '<a href="#' + tabId + '" class="tab-open nav-link active" data-bs-toggle="tab">' +
    tabTitle +
    '<svg data-tab="' + tabId + '" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="-5 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icon-tabler-x close">' +
    '<path d="M18 6L6 18"/><path d="M6 6l12 12"/></svg>' +
    '</a>' +
    '</li>'
);

$('#tabContent').append(
    '<div id="' + tabId + '" class="tab-room-table-content tab-pane active show">' +
    '<div class="col-12">' +
    '<div class="card">' +
    '<div class="list-group list-group-flush list-group-hoverable">' +
    '</div>' +
    '</div>' +
    '</div>' +
    '</div>'
);

updateStatusTable(value, 1); // Cập nhật trạng thái sang đang sử dụng
checkAndAddEmptyContent();

// Load lại món đã order nếu có
setTimeout(function () {
    initDataTableOrder();
}, 300);
</c:if>
	


    $(document).ready(function () {
<c:if test="${not empty idTable}">
    const tabId = 'tab-${idTable}';
    setTimeout(function () {
        activateTab(tabId);
    }, 500);
</c:if>



        loadCategory()



         setTimeout(function () {
            loadDataTableProduct(currentIndexPageProduct, limitPageProduct);
        }, 200); 
        
         
         setTimeout(function () {
             checkAndAddEmptyContent();

         }, 500); 
         
       
         
         
        $('#loadGroupTableUser').on('change', 'input[name="groupTableUser"]', function () {
            loadDataTableUser(1, limitPageTable);
        });

        $(document).on('change', 'input[name="groupStatusTable"]', function () {
            loadDataTableUser(1, limitPageTable);
        });

        // Khi checkbox "Tất Cả" được checked hoặc unchecked
        $('#selectAll').on('change', function () {
            var isChecked = $(this).is(':checked');
            $('input[name="category"]').prop('checked', isChecked);
            loadDataTableProduct(currentIndexPageProduct, limitPageProduct);
        });

        // Khi bất kỳ checkbox nào khác được checked hoặc unchecked
        $(document).on('change', 'input[name="category"]', function () {
            var allChecked = $('input[name="category"]').length === $('input[name="category"]:checked').length;
            $('#selectAll').prop('checked', allChecked);
            loadDataTableProduct(currentIndexPageProduct, limitPageProduct);

        });


        $("#searchProduct").change(function () {
            var query = $("#searchProduct").val();
            console.log("Search query: " + query);
            loadDataTableProduct(currentIndexPageProduct, limitPageProduct);
        });

        $("#loadProduct").on('click', '.add-item', function () {
            <c:if test="${paymentSuccess == true}">
                return; // Không cho thêm món nếu đã thanh toán
            </c:if>

            const name = $(this).data('name');
            const price = $(this).data('price');
            const img = $(this).data('img');
            const activeTabId = getActiveTabId();

            if (activeTabId) {
                const productId = $(this).data('id');
                const userTableID = activeTabId.split('-')[1];
                const orderQuantity = 1;

                // Kiểm tra dữ liệu trước khi gửi
                console.log('Dữ liệu trước khi gửi:', {
                    productId: productId,
                    userTableID: userTableID,
                    orderQuantity: orderQuantity
                });

                if (!productId || !userTableID || !orderQuantity) {
                    console.error('Dữ liệu không hợp lệ: productId, userTableID, hoặc orderQuantity không hợp lệ.');
                    return; // Dừng việc gọi API nếu dữ liệu không hợp lệ
                }

                // Thực hiện gọi AJAX khi dữ liệu hợp lệ
                $.ajax({
                    url: '${putOrderTable}', // Đường dẫn API
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({
                        orderQuantity: orderQuantity,
                        userTableID: userTableID,
                        productId: productId
                    }),
                    success: function (response) {
                        // Log dữ liệu trả về
                        console.log('Dữ liệu trả về từ server:', response);
                        if (response && response.data) {
                            const data = response.data;
                            appendContentTabActive(data, activeTabId); // Chỉ gọi khi dữ liệu hợp lệ
                        } else {
                            console.error('Dữ liệu trả về không hợp lệ:', response);
                            message_toastr('error', 'Có lỗi xảy ra khi thêm món.');
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error('Lỗi khi gửi dữ liệu:', status, error);
                    }
                });
            } else {
                message_toastr("info", "Vui Lòng Thêm Bàn Trước Khi Chọn Món !");
            }
            notifyNewOrder('${idTable}');
        });


        $(document).on('change', 'input[name="icons"]', function () {


            const value = $(this).val();
            const tabId = 'tab-' + value;
            const tabTitle = 'Bàn ' + value;


            if ($(this).is(':checked')) {

                message_toastr("success", "Đã Tạo " + tabTitle + " Thành Công")

                $('#tabList').append(
                    '<li class="nav-item">' +
                    '<a href="#' + tabId + '" class="tab-open nav-link ' + ($('#tabList').find('.tab-open').length === 0 ? 'active' : '') + '" data-bs-toggle="tab" aria-selected="false" role="tab" tabindex="-1">' +
                    tabTitle +
                    '<svg data-tab="' + tabId + '" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="-5 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="icon icon-tabler icons-tabler-outline icon-tabler-x close">' +
                    '<path stroke="none" d="M0 0h24v24H0z" fill="none" />' +
                    '<path d="M18 6l-12 12" />' +
                    '<path d="M6 6l12 12" />' +
                    '</svg>' +
                    '</a>' +
                    '</li>'
                );

                $('#tabContent').append(
                    '<div id="' + tabId + '" class="tab-room-table-content tab-pane ' + ($('#tabList').find('.tab-open').length - 1 === 0 ? 'active show' : '') + '">' +
                    '<div class="col-12">' +
                    '<div class="card">' +
                    '<div class="list-group list-group-flush list-group-hoverable">' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '</div>'
                );

                updateStatusTable(value, 1);
                checkAndAddEmptyContent();

            } else {
                confirmDeleteTable(tabTitle, tabId, value);
            }

        });

        // Xử lý sự kiện click cho các nút close
        $(document).on('click', '.close', function () {
            const tabId = $(this).data('tab');
            const value = tabId.split('-')[1];
            const tabTitle = 'Bàn ' + value;

            confirmDeleteTable(tabTitle, tabId, value);
        });

        var offcanvas = new bootstrap.Offcanvas($('#offcanvasEnd')[0]);

        $('#buttonCheckOut').on('click', function () {
            // Điều kiện cần kiểm tra
            var isConditionMet = false;

            const activeTabId = getActiveTabId();

            if (activeTabId != null) {
               
                const userTableID = activeTabId.split('-')[1];
                $.ajax({
                    url: '${checkOrderTable}',
                    type: 'GET',
                    contentType: 'application/json',
                    data: {
                        userTableID: userTableID
                    },
                    success: function (response) {
                        const data = response.data;
                        if(data == null){
                        	  message_toastr("info", "Bàn Chưa Chọn Món Nào !");
                        	  return;
                        }else{
                        	 $('#loadBill').empty();
                        	  $.each(data.tableOrder, function (index, item) {

                        		  var tableRow = '<tr>' +
                        	        '<td class="text-center">' + (index + 1) + '</td>' +
                        	        '<td>' +
                        	        '<p class="strong mb-1">' + item.product.productName + '</p>' +
                        	        '</td>' +
                        	        '<td class="text-center">' + item.orderQuantity + '</td>' +
                        	        '<td class="text-end">' + item.product.productPrice + 'đ</td>' +
                        	        '<td class="text-end">' + (item.orderQuantity * item.product.productPrice) + 'đ</td>' +
                        	        '</tr>';

                        	    $('#loadBill').append(tableRow);

                              });
                        	// Thêm dòng tổng số lượng
                        	  $('#loadBill').append(
                        	      '<tr>' +
                        	      '<td colspan="4" class="strong text-end">Tổng Số Lượng</td>' +
                        	      '<td class="text-end">' + data.totalQuantity + '</td>' +
                        	      '</tr>'
                        	  );

                        	  // Thêm dòng tổng tiền
                        	  $('#loadBill').append(
                        	      '<tr>' +
                        	      '<td colspan="4" class="font-weight-bold strong text-uppercase text-end">Tổng Tiền</td>' +
                        	      '<td class="font-weight-bold text-end">' + data.totalProductPrice + 'đ </td>' +
                        	      '</tr>'
                        	  );
                        	  offcanvas.show();
                        	
                        }
                       
                    },
                    error: function (xhr, status, error) {
                        console.error('Error sending data:', status, error);
                    }
                });
                
                
                
            } else {
                message_toastr("info", "Hãy Chọn Bàn Trước Khi Tính Tiền !")
            }

        });


     // Xử lý nút thanh toán
       $(document).on('click', '#paymentButton', function () {
    const activeTabId = getActiveTabId();
    if (activeTabId != null) {
        const userTableID = activeTabId.split('-')[1];
        
        // Kiểm tra đơn hàng và lấy tổng tiền
        $.ajax({
            url: '${checkOrderTable}',
            type: 'GET',
            contentType: 'application/json',
            data: {
                userTableID: userTableID
            },
            success: function(checkResponse) {
                if (checkResponse.data && checkResponse.data.totalProductPrice) {
                    const amount = checkResponse.data.totalProductPrice;
                    
                    // Lưu thông tin vào sessionStorage trước khi gọi VNPay
                    sessionStorage.setItem('pendingTableId', userTableID);
                    console.log("Saved to session - Table ID:", userTableID);
                    
                    // Gọi API tạo URL VNPay
                    $.ajax({
                        url: '/CafeManager/vnpay/create-url',
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            amount: amount,
                            orderInfo: 'Thanh toan hoa don ban ' + userTableID,
                            ipAddress: '${pageContext.request.remoteAddr}'
                        }),
                        success: function (url) {
                            // Chuyển sang trang VNPay
                            window.location.href = url;
                        },
                        error: function () {
                            message_toastr("error", "Không thể tạo link thanh toán VNPay");
                            sessionStorage.removeItem('pendingTableId');
                        }
                    });
                } else {
                    message_toastr("error", "Không thể lấy thông tin tổng tiền đơn hàng");
                }
            },
            error: function(xhr, status, error) {
                message_toastr("error", "Lỗi khi kiểm tra đơn hàng: " + error);
            }
        });
    } else {
        message_toastr("warning", "Chọn bàn trước khi thanh toán!");
    }
});
       
            var countdownTime = 1.5;
            var interval = 120;
            var totalTime = countdownTime * 1000;

            var intervalId = setInterval(function() {
                totalTime -= interval;
                var seconds = (totalTime / 1000).toFixed(2);

                $('#textLoading').text('Đang chuẩn bị dữ liệu... ' + seconds + 's');

                if (totalTime <= 0) {
                    clearInterval(intervalId);
                    $('#loading').attr('hidden', true);
                    $('#content').removeAttr('hidden');
                }
            }, interval);
     


    });

 // Add WebSocket connection setup
    let stompClient = null;

    function connectWebSocket() {
        try {
            const socket = new SockJS('${pageContext.request.contextPath}/ws');
            stompClient = Stomp.over(socket);
            
            stompClient.connect({}, function(frame) {
                console.log('Connected to WebSocket: ' + frame);
                
                // Đăng ký nhận thông báo trạng thái đơn hàng
                stompClient.subscribe('/topic/order-status', function(message) {
                    try {
                        const statusUpdate = JSON.parse(message.body);
                        handleOrderStatusUpdate(statusUpdate);
                    } catch (error) {
                        console.error('Error handling message:', error);
                    }
                });
                
            }, function(error) {
                console.error('WebSocket connection error:', error);
                setTimeout(connectWebSocket, 5000); // Thử kết nối lại sau 5 giây
            });
        } catch (error) {
            console.error('Error initializing WebSocket:', error);
        }
    }

    function handleOrderStatusUpdate(statusUpdate) {
        console.log('Received order status update:', statusUpdate);
        
        if (statusUpdate.tableId === '${idTable}') {
            if (statusUpdate.type === 'COMPLETED_ORDER') {
                // Cập nhật UI khi đơn hàng hoàn thành
                $('.step.step-2').addClass('active');
                $('#line-step-1-2').removeClass('processing');
                $('#line-step-1-2').css('background-color', '#007bff');
                
                // Hiển thị thông báo
                message_toastr("success", statusUpdate.message);
                
                // Cập nhật trạng thái nút
                $('.btn.btn-success.px-4.py-2')
                    .text('✅ Đơn hàng đã hoàn thành')
                    .prop('disabled', true)
                    .css('opacity', '0.7');
                    
                // Vô hiệu hóa các nút thao tác với đơn hàng
                $('.add-item, .delete-item-order, .plus, .minus').prop('disabled', true);
            }
        }
    }

    function notifyNewOrder(tableId) {
        $.ajax({
            url: '${pageContext.request.contextPath}/api/customer/new-order',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ 
                tableId: tableId,
                type: "NEW_ORDER"
            }),
            success: function(response) {
                if (response.code === 200) {
                    console.log("Đã gửi thông báo đơn hàng mới");
                } else {
                    console.error("Lỗi khi gửi thông báo:", response.message);
                }
            },
            error: function(xhr, status, error) {
                console.error("Lỗi khi gửi thông báo:", error);
            }
        });
    }
</script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>


</div>
</body>

</html>