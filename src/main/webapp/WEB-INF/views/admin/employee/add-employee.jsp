<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/employee/save-employee"></c:url>
<div class="col-12 p-3">
	<form:form class="card" action="${postURL}" method = "POST" modelAttribute="employee">
		<div class="card-body">
			<h3 class="card-title">Thêm Nhân viên</h3>
			<div class="row row-cards">
				<div class="col-sm-6 col-md-6">
					<div class="mb-3">
						<label class="form-label">Tên</label> <form:input type="text"
							class="form-control" placeholder="Tên nhân viên" value="" path = "employeeName"/>
					</div>
				</div>
				<div class="col-sm-6 col-md-6">
					<div class="mb-3">
						<label class="form-label">Email</label> <form:input
							type="email" class="form-control" placeholder="Email" path = "employeeEmail"/>
					</div>
				</div>
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">Giới tính</label> <form:select
							class="form-control form-select" path = "employeeGender">
							<option value="0">Nam</option>
							<option value="1">Nữ</option>
							<option value="2">Giới tính khác</option>
						</form:select>
					</div>
				</div>
				<div class="col-sm-6 col-md-6">
					<div class="mb-3">
						<label class="form-label">Số điện thoại</label> <form:input type="text"
							class="form-control" placeholder="Số điện thoại" value="" path="employeePhone"/>
					</div>
				</div>
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label">Địa chỉ</label> <form:input type="text"
							class="form-control" placeholder="Địa chỉ cụ thể"
							value="" path="employeeAddress"/>
					</div>
				</div>
				<div class="col-sm-6 col-md-6">
					<div class="mb-3">
						<label class="form-label">Ngày tháng năm sinh</label> <form:input type="date"
							class="form-control" value="" path = "employeeDateOfBirth"/>
					</div>
				</div>
			
			</div>
		</div>
		<div class="card-footer text-end">
			<button type="submit" class="btn btn-primary">Thêm nhân viên</button>
		</div>
	</form:form>
</div>
