<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dec" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>SpringBeanCoffee - Nhân viên</title>
    <!-- CSS files -->
    <link href="<c:url value='/template/admin/dist/css/tabler.min.css?1692870487' />" rel="stylesheet"/>
    <link href="<c:url value='/template/admin/dist/css/tabler-flags.min.css?1692870487' />" rel="stylesheet"/>
    <link href="<c:url value='/template/admin/dist/css/tabler-payments.min.css?1692870487' />" rel="stylesheet"/>
    <link href="<c:url value='/template/admin/dist/css/tabler-vendors.min.css?1692870487' />" rel="stylesheet"/>
    <link href="<c:url value='/template/admin/dist/css/demo.min.css?1692870487' />" rel="stylesheet"/>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"
            referrerpolicy="no-referrer"></script>


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
<body>
<%@include file="/commom/user/header.jsp" %>
<dec:body/>


<!-- Tabler Core -->
<script src="<c:url value='/template/admin/dist/js/tabler.min.js?1692870487' />" defer></script>
<script src="<c:url value='/template/admin/dist/js/demo.min.js?1692870487' />" defer></script>
<script src="<c:url value='/template/admin/dist/js/validator.js' />" defer></script>
<!--  sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!--  Js Toast -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!--   Pagination  -->
<script src="<c:url value='/template/admin/dist/js/jquery.twbsPagination.js'/>"></script>
</body>
</html>
