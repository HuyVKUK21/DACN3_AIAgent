<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="dec"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>

<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, viewport-fit=cover" />
<meta http-equiv="X-UA-Compatible" content="ie=edge" />
<title>SpringBeanCoffee</title>
<!-- CSS files -->
<link
	href="<c:url value='/template/admin/dist/css/tabler.min.css?1692870487' />"
	rel="stylesheet" />
<link
	href="<c:url value='/template/admin/dist/css/tabler-flags.min.css?1692870487' />"
	rel="stylesheet" />
<link
	href="<c:url value='/template/admin/dist/css/tabler-payments.min.css?1692870487' />"
	rel="stylesheet" />
<link
	href="<c:url value='/template/admin/dist/css/tabler-vendors.min.css?1692870487' />"
	rel="stylesheet" />
<link
	href="<c:url value='/template/admin/dist/css/demo.min.css?1692870487' />"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/tabler-icons/1.35.0/iconfont/tabler-icons.min.css"
	referrerpolicy="no-referrer" />


<style>
@import url('https://rsms.me/inter/inter.css');

:root { -
	-tblr-font-sans-serif: 'Inter Var', -apple-system, BlinkMacSystemFont,
		San Francisco, Segoe UI, Roboto, Helvetica Neue, sans-serif;
}

body {
	font-feature-settings: "cv03", "cv04", "cv11";
}
</style>
</head>
<body>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" referrerpolicy="no-referrer"></script>
	<script src="https://unpkg.com/gijgo@1.9.14/js/gijgo.min.js"
		type="text/javascript"></script>
	<link href="https://unpkg.com/gijgo@1.9.14/css/gijgo.min.css"
		rel="stylesheet" type="text/css" />
	<script
		src="<c:url value='/template/admin/dist/js/demo-theme.min.js?1692870487' />"></script>
	<link rel="stylesheet" href="https://cdn.datatables.net/2.1.4/css/dataTables.dataTables.css" />
	<script src="https://cdn.datatables.net/2.1.4/js/dataTables.js"></script>

	<div class="page">
		<!-- Sidebar -->
		<%@include file="/commom/admin/sidebar.jsp"%>
		<!-- Navbar -->
		<%@include file="/commom/admin/header.jsp"%>
		<!-- Content -->
		<div class="page-wrapper">
			<div class="mt-lg-7 mt-md-2">
				<dec:body />
			</div>

			<!-- footer -->
			<%@include file="/commom/admin/footer.jsp"%>
		</div>
	</div>

	<!-- Libs JS -->
	<script>
		$(function() {
			$('#datepicker').datepicker();
		});
	</script>
	<script
		src="<c:url value='/template/admin/dist/libs/apexcharts/dist/apexcharts.min.js?1692870487' />"
		defer></script>
	<script
		src="<c:url value='/template/admin/dist/libs/jsvectormap/dist/js/jsvectormap.min.js?1692870487' />"
		defer></script>
	<script
		src="<c:url value='/template/admin/dist/libs/jsvectormap/dist/maps/world.js?1692870487' />"
		defer></script>
	<script
		src="<c:url value='/template/admin/dist/libs/jsvectormap/dist/maps/world-merc.js?1692870487' />"
		defer></script>
	<!-- Tabler Core -->
	<script
		src="<c:url value='/template/admin/dist/js/tabler.min.js?1692870487' />"
		defer></script>
	<script
		src="<c:url value='/template/admin/dist/js/demo.min.js?1692870487' />"
		defer></script>
	<script src="<c:url value='/template/admin/dist/js/validator.js' />"
		defer></script>

	<!--  Js Toast -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
	<!--  moment -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<!--  sweetalert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<!--   Pagination  -->
	<script
		src="<c:url value='/template/admin/dist/js/jquery.twbsPagination.js'/>"></script>

	<script>
		function message_toastr(type, content) {
			toastr.options = {
				"closeButton" : true,
				"debug" : true,
				"newestOnTop" : false,
				"progressBar" : true,
				"positionClass" : "toast-top-right",
				"preventDuplicates" : true,
				"showDuration" : "300",
				"hideDuration" : "1000",
				"timeOut" : "5000",
				"extendedTimeOut" : "1000",
				"showEasing" : "swing",
				"hideEasing" : "linear",
				"showMethod" : "fadeIn",
				"hideMethod" : "fadeOut"
			};
			toastr[type](content);
		}

		function message_toastr(type, content, title) {
			// Cấu hình các tùy chọn cho toastr
			toastr.options = {
				"closeButton" : false,
				"debug" : false,
				"newestOnTop" : false,
				"progressBar" : false,
				"positionClass" : "toast-top-right",
				"preventDuplicates" : false,
				"onclick" : null,
				"showDuration" : "300",
				"hideDuration" : "1000",
				"timeOut" : "5000",
				"extendedTimeOut" : "1000",
				"showEasing" : "swing",
				"hideEasing" : "linear",
				"showMethod" : "fadeIn",
				"hideMethod" : "fadeOut"
			};

		
			toastr[type](content, title);
		}
	</script>

	<script>
		$(document).ready(function() {
			var today = new Date();

			
			$('#startDate').datepicker({
				uiLibrary : 'bootstrap5',
				format : 'yyyy-mm-dd',
				maxDate : function() {
					return today; 
				},
				change : function(e) {
					var selectedDate = $('#startDate').datepicker().value();
					$('#endDate').datepicker().destroy();
					$('#endDate').datepicker({
						uiLibrary : 'bootstrap5',
						format : 'yyyy-mm-dd',
						minDate : selectedDate, 
						maxDate : today, 
					});
				}
			});

		
			$('#endDate').datepicker({
				uiLibrary : 'bootstrap5',
				format : 'yyyy-mm-dd',
				maxDate : today, 
			});
		});
	</script>

</body>
</html>
