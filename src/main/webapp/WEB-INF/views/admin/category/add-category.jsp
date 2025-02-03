<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/category/save-category"></c:url>

<!-- Page header -->
<div class="page-header d-print-none">
  <div class="container-xl">
    <div class="row g-2 align-items-center">
      <div class="col">
        <h2 class="page-title">
          Thêm Danh Mục
        </h2>
      </div>
    </div>
  </div>
</div>

<!-- Page body -->
<div class="page-body">
  <div class="container-xl">
    <div class="col-md-12">
      <form:form id="formSubmit" class="card" action="${postURL}" method="post" enctype="multipart/form-data" modelAttribute="categoryDTO">
        <div class="card-header">
          <h3 class="card-title">Thêm Thông Tin Danh Mục</h3>
        </div>
        <div class="card-body">
          <!-- Category Name field -->
          <div class="mb-3">
            <label class="form-label required" for="categoryName">Tên Danh Mục</label>
            <form:input type="text" class="form-control" id="categoryName" path="categoryName" maxlength="100" placeholder="Tên Danh Mục" />
            <small class="form-hint text-danger form-message"><form:errors path="categoryName" /></small>
          </div>

          <!-- Category Image field -->
          <div class="mb-3">
            <label class="form-label" for="categoryImage">Tải Ảnh Lên</label>
            <form:input type="file" class="form-control" id="categoryImage" path="categoryImage" />
            <small class="form-hint text-danger form-message"><form:errors path="categoryImage" /></small>
          </div>

          <!-- Category Status field -->
          <div class="mb-3">
            <label class="form-label">Hiển Thị</label>
            <form:select path="categoryStatus" class="form-control" id="categoryStatus">
              <form:option value="1">Hiện</form:option>
              <form:option value="0">Ẩn</form:option>
            </form:select>
          </div>

          <!-- Category Description field -->
          <div class="mb-3">
            <label class="form-label" for="categoryDesc">Mô Tả Danh Mục</label>
            <form:textarea id="categoryDesc" path="categoryDesc" rows="4" class="form-control" placeholder="Mô Tả Danh Mục"></form:textarea>
            <small class="form-hint text-danger form-message"><form:errors path="categoryDesc" /></small>
          </div>
        </div>
        <div class="card-footer text-end">
          <button id="click-submit" type="submit" class="btn btn-primary">Xác Nhận</button>
        </div>
      </form:form>
    </div>
  </div>
</div>
