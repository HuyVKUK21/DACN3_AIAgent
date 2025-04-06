<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>505 - SpringBeanCoffee</title>
    <!-- CSS files -->
    <link href="<c:url value='/template/admin/dist/css/tabler.min.css?1692870487' />" rel="stylesheet"/>
	<link href="<c:url value='/template/admin/dist/css/tabler-flags.min.css?1692870487' />" rel="stylesheet"/>
	<link href="<c:url value='/template/admin/dist/css/tabler-payments.min.css?1692870487' />" rel="stylesheet"/>
	<link href="<c:url value='/template/admin/dist/css/tabler-vendors.min.css?1692870487' />" rel="stylesheet"/>
	<link href="<c:url value='/template/admin/dist/css/demo.min.css?1692870487' />" rel="stylesheet"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
	
  <style>
    @import url('https://rsms.me/inter/inter.css');

    :root {
      --tblr-font-sans-serif: 'Inter Var', -apple-system, BlinkMacSystemFont, San Francisco, Segoe UI, Roboto, Helvetica Neue, sans-serif;
    }

    body {
      font-feature-settings: "cv03", "cv04", "cv11";
    }
  </style>
</head>

<body class=" border-top-wide border-primary d-flex flex-column">
  <script src="./dist/js/demo-theme.min.js?1692870487"></script>
  <div class="page page-center">
    <div class="container-tight py-4">
      <div class="empty">
        <div class="empty-header" id="test">500</div>
        <p class="empty-title">Oops… You just found an error page</p>
        <p class="empty-subtitle text-secondary">
          We are sorry but our server encountered an internal error
        </p>
        <div class="empty-action" id="fixButton">
          <a  class="btn btn-primary">
            <!-- Download SVG icon from http://tabler-icons.io/i/arrow-left -->
            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24"
              stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
              <path stroke="none" d="M0 0h24v24H0z" fill="none" />
              <path d="M5 12l14 0" />
              <path d="M5 12l6 6" />
              <path d="M5 12l6 -6" /></svg>
            Bấm Dô Để Fix :))
          </a>
        </div>
      </div>
    </div>

    <div class="container-xl">
      <div class="card">
        <div class="card-body">
          <h4>
            Checked URL
          </h4>
          <div>
            <pre><code>${method} <a class="text-reset">${url}</a></code></pre>
          </div>
          <h4>Chi Tiết Lỗi</h4>
          <div>
            <pre>
              ${exception}              ${message}<br>
            </pre>
          </div>
          
          <h4>Thời Gian</h4>
          <div>
            <pre>${timestamp}</pre>
          </div>
        </div>
      </div>

    </div>
    <!-- Tabler Core -->
	<script src="<c:url value='/template/admin/dist/js/tabler.min.js?1692870487' />" defer></script>
	<script src="<c:url value='/template/admin/dist/js/demo.min.js?1692870487' />" defer></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" referrerpolicy="no-referrer"></script>
	
	<script type="text/javascript">
	$(document).ready(function() {	
	      $("#fixButton").on("click", function(event) {
	    	   var message = encodeURIComponent(`Tìm Và Hướng Dẫn Cách Gỡ Lỗi Trong Spring MVC: ${exception} - ${message}`); 
	    	   window.open("https://chatgpt.com/?q=" + message, '_blank');
	      });
	    });
	</script>
</body>

</html>