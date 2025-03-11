<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/table-user/edit"></c:url>

<!-- Header trang -->
<div class="page-header d-print-none">
    <div class="container-xl">
        <div class="row g-2 align-items-center">
            <div class="col">
                <h2 class="page-title">Cập nhật thông tin bàn</h2>
            </div>
        </div>
    </div>
</div>

<!-- Nội dung trang -->
<div class="page-body">
    <div class="container-xl">
        <div class="col-md-12">
            <form:form id="formSubmit" class="card" action="${postURL}" method="post" modelAttribute="tableUserDTO">
                <div class="card-header">
                    <h3 class="card-title">Sửa thông tin bàn</h3>
                </div>
                <div class="card-body">
                    <!-- Trường ID Bàn (ẩn) -->
                    <form:hidden path="userTableID" />

                    <!-- Tên Bàn -->
                    <div class="mb-3">
                        <label class="form-label required" for="tableUserName">Tên Bàn</label>
                        <form:input type="text" class="form-control" id="tableUserName" path="tableUserName" maxlength="100" placeholder="Tên Bàn" />
                        <small class="form-hint text-danger form-message"><form:errors path="tableUserName" /></small>
                    </div>

                    <!-- Số Ghế -->
                    <div class="mb-3">
                        <label class="form-label" for="tableNumberOfChair">Số Ghế</label>
                        <form:input type="number" class="form-control" id="tableNumberOfChair" path="tableNumberOfChair" min="1" placeholder="Số Ghế" />
                        <small class="form-hint text-danger form-message"><form:errors path="tableNumberOfChair" /></small>
                    </div>

                    <!-- Loại Bàn -->
                    <div class="mb-3">
                        <label class="form-label" for="tableUserGroup">Loại Bàn</label>
                        <form:select path="tableUserGroup" class="form-select" id="tableUserGroup">
                            <form:option value="Trong Nhà">Trong Nhà</form:option>
                            <form:option value="Ngoài Trời">Ngoài Trời</form:option>
                        </form:select>
                        <small class="form-hint text-danger form-message"><form:errors path="tableUserGroup" /></small>
                    </div>

                    <!-- Số Thứ Tự -->
                    <div class="mb-3">
                        <label class="form-label" for="tableUserIndex">Số Thứ Tự</label>
                        <form:input type="text" class="form-control" id="tableUserIndex" path="tableUserIndex" placeholder="Số Thứ Tự" />
                        <small class="form-hint text-danger form-message"><form:errors path="tableUserIndex" /></small>
                    </div>

                    <!-- Trạng Thái Bàn -->
                    <div class="mb-3">
                        <label class="form-label">Trạng Thái</label>
                        <form:select path="tableUserStatus" class="form-select" id="tableUserStatus">
                            <form:option value="1">Đang Hoạt Động</form:option>
                            <form:option value="0">Không Hoạt Động</form:option>
                        </form:select>
                        <small class="form-hint text-danger form-message"><form:errors path="tableUserStatus" /></small>
                    </div>

                    <!-- Ghi Chú -->
                    <div class="mb-3">
                        <label class="form-label" for="tableUserNote">Ghi Chú</label>
                        <form:textarea id="tableUserNote" path="tableUserNote" rows="3" class="form-control" placeholder="Ghi Chú"></form:textarea>
                        <small class="form-hint text-danger form-message"><form:errors path="tableUserNote" /></small>
                    </div>

                </div>
                <div class="card-footer text-end">
                    <button id="click-submit" type="submit" class="btn btn-primary">Xác Nhận</button>
                </div>
            </form:form>
        </div>
    </div>
</div>
