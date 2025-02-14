<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/account-admin/save"></c:url>

<!-- Page body -->
<div class="page-body">
  <div class="container-xl">
    <div class="col-md-12">
      <form:form id="formSubmit" class="card" action="${postURL}" method="post" enctype="multipart/form-data" modelAttribute="accountAdmin">
        <div class="card-header">
          <h3 class="card-title">
            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-user-circle"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0" /><path d="M12 10m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0" /><path d="M6.168 18.849a4 4 0 0 1 3.832 -2.849h4a4 4 0 0 1 3.834 2.855" /></svg>
            <c:if test="${not empty accountAdmin.id}">Cập Nhật Tài Khoản</c:if>
            <c:if test="${empty accountAdmin.id}">Thêm Tài Khoản</c:if>
            </h3>
        </div>
        <div class="card-body">
          <!-- Hidden field for ID -->
          <form:hidden path="id" id="id" />
          <!-- Fullname field -->
          <div class="mb-3">
            <label class="form-label required" for="fullname">Họ Và Tên</label>
            <form:input type="text" class="form-control" id="fullname" path="fullname" maxlength="20" placeholder="Họ Và Tên" />
            <small class="form-hint text-danger form-message"><form:errors path="fullname" /></small>
          </div>

          <!-- Username field -->
          <div class="mb-3">
            <label class="form-label required" for="username">Tài Khoản</label>
            <form:input type="text" class="form-control" id="username" path="username" maxlength="20" placeholder="Tài Khoản" />
            <small class="form-hint text-danger form-message"><form:errors path="username" /></small>
          </div>

          <!-- Email field -->
          <div class="mb-3">
            <label class="form-label required" for="email">Email</label>
            <form:input type="email" class="form-control" id="email" path="email" placeholder="Email" />
            <small class="form-hint text-danger form-message"><form:errors path="email" /></small>
          </div>

          <!-- Password field -->
          <div class="mb-3">
            <label class="form-label required" for="password">Mật Khẩu</label>
            <form:input type="password" class="form-control" id="password" path="password" placeholder="Mật Khẩu" />
            <small class="form-hint text-danger form-message"><form:errors path="password" /></small>
          </div>

          <!-- Confirm Password field -->
          <div class="mb-3">
            <label class="form-label required" for="password1">Nhập Lại Mật Khẩu</label>
            <input type="password" class="form-control" id="password1"  placeholder="Nhập Lại Mật Khẩu" />
            <small class="form-hint text-danger form-message"></small>
          </div>

          <!-- Role selection -->
          <div class="mb-3">
            <label class="form-label">Quyền Hạn Tài Khoản</label>
            <div>
              <label class="form-check">
                <form:radiobutton path="typeRole" class="form-check-input" id="roleAdmin" value="1" checked="true" />
                <span class="form-check-label">Quản trị viên</span>
              </label>
              <label class="form-check">
                <form:radiobutton path="typeRole" class="form-check-input" id="roleManager" value="2" />
                <span class="form-check-label">Quản lý</span>
              </label>
              <label class="form-check">
                <form:radiobutton path="typeRole" class="form-check-input" id="roleEmployee" value="3" />
                <span class="form-check-label">Nhân viên</span>
              </label>
            </div>
          </div>
        </div>
        <div class="card-footer text-end">
          <button id="click-submit" type="submit" class="btn btn-primary">Xác Nhận</button>
        </div>
      </form:form>
    </div>
  </div>
</div>

