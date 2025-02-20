<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:url var="postURL" value="/admin/product/save-product"></c:url>

<!-- Page header -->
<div class="page-header d-print-none">
  <div class="container-xl">
    <div class="row g-2 align-items-center">
      <div class="col">
        <h2 class="page-title">
          ${pageTitle }
        </h2>
      </div>
    </div>
  </div>
</div>

<!-- Page body -->
<div class="page-body">
  <div class="container-xl">
    <div class="col-md-12">
      <form:form id="formSubmit" class="card" action="${postURL}" method="post" enctype="multipart/form-data" modelAttribute="productDTO">
        <div class="card-header">
          <h3 class="card-title">Thêm Thông Tin Sản Phẩm</h3>
        </div>
        <div class="card-body">
                  
          <!-- Product Name field -->
          <div class="mb-3">
            <label class="form-label required" for="productName">Tên Sản Phẩm</label>
            <form:input type="text" class="form-control" id="productName" path="productName" maxlength="100" placeholder="Tên Sản Phẩm" />
            <small class="form-hint text-danger form-message"><form:errors path="productName" /></small>
          </div>
          
          <!-- Category field -->
          
          <form:hidden path="productId" id="productId" />
    
          <div class="mb-3">
            <label class="form-label">Danh Mục Sản Phẩm</label>
            <form:select path="categoryId" class="form-select" id="categoryId">
              <form:options items="${categories}" itemValue="categoryId" itemLabel="categoryName" />
            </form:select>
            <small class="form-hint text-danger form-message"><form:errors path="categoryId" /></small>
          </div>

          <!-- Product Description field -->
          <div class="mb-3">
            <label class="form-label" for="productDesc">Mô Tả Sản Phẩm</label>
            <form:textarea id="productDesc" path="productDesc" rows="4" class="form-control" placeholder="Mô Tả Sản Phẩm"></form:textarea>
            <small class="form-hint text-danger form-message"><form:errors path="productDesc" /></small>
          </div>

          <!-- Product Price field -->
          <div class="mb-3">
            <label class="form-label required" for="productPrice">Giá Sản Phẩm</label>
            <form:input type="number" class="form-control" id="productPrice" path="productPrice" placeholder="Giá Sản Phẩm" />
            <small class="form-hint text-danger form-message"><form:errors path="productPrice" /></small>
          </div>

          <!-- Product Image field -->
          <div class="mb-3">
            <label class="form-label" for="productImage">Tải Ảnh Lên</label>
            <form:input type="file" class="form-control" id="productImage" path="productImage"  required="required" />
            <small class="form-hint text-danger form-message"><form:errors path="productImage" /></small>
          </div>

          <!-- Product Status field -->
          <div class="mb-3">
            <label class="form-label">Hiển Thị</label>
            <form:select path="productStatus" class="form-control" id="productStatus">
              <form:option value="1">Hiện</form:option>
              <form:option value="0">Ẩn</form:option>
            </form:select>
          </div>
        </div>
        <div class="card-footer text-end">
          <button id="click-submit" type="submit" class="btn btn-primary">Xác Nhận</button>
        </div>
      </form:form>
    </div>
  </div>
</div>
