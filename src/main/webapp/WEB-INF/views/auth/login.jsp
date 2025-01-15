<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dec"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<c:url var="postURL" value="/auth/login"></c:url>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <title>Đăng nhập - SpringBeanCoffee</title>
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
<body class=" d-flex flex-column">
<script src="<c:url value='/template/admin/dist/js/demo-theme.min.js?1692870487' />"></script>
<div class="page page-center">
    <div class="container container-normal py-4">
        <div class="row align-items-center g-4">
            <div class="col-lg">
                <div class="container-tight">
                    <div class="card card-md">
                        <div class="card-body">
                            <div class="text-center mb-4">
                                <a href="<c:url value=""/>" class="navbar-brand navbar-brand-autodark">
                                    <img src="<c:url value='/template/admin/static/img/cover.png' />"
                                         alt="SpringBeanCoffee"
                                         class="navbar-brand-image">
                                </a>
                            </div>
                            <form id="formSubmit" action="${postURL}" method="post" autocomplete="off" novalidate>
                                <div class="mb-3">
                                    <label class="form-label">Tên đăng nhập <span class="text-danger">*</span></label>
                                    <input type="text" id="username" name="username" class="form-control"
                                           placeholder="Nhập tên đăng nhập" autocomplete="off" value="admin">
                                    <div class="form-check-label invalid-feedback form-message"></div>
                                </div>
                                <div class="mb-2">
                                    <label class="form-label">
                                        Mật khẩu
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input type="password" id="password" name="password" class="form-control"
                                           placeholder="Nhập mật khẩu" autocomplete="off" value="123456">
                                    <div class="form-check-label invalid-feedback form-message"></div>
                                </div>
                                <div class="form-footer">
                                    <button id="click-submit" tabindex="1" type="submit" class="btn btn-primary w-100">Đăng nhập
                                    </button>
                                </div>
                                <div class="hr-text">
                                    <span>Hoặc</span>
                                </div>
                                <div class="form-footer">
                                    <a href="<c:url value="/contact"/>">
                                        <button type="button" class="btn btn-outline-primary w-100">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                                 viewBox="0 0 24 24" fill="currentColor"
                                                 class="icon icon-tabler icons-tabler-filled icon-tabler-alert-square-rounded">
                                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                                <path d="M12 2l.642 .005l.616 .017l.299 .013l.579 .034l.553 .046c4.687 .455 6.65 2.333 7.166 6.906l.03 .29l.046 .553l.041 .727l.006 .15l.017 .617l.005 .642l-.005 .642l-.017 .616l-.013 .299l-.034 .579l-.046 .553c-.455 4.687 -2.333 6.65 -6.906 7.166l-.29 .03l-.553 .046l-.727 .041l-.15 .006l-.617 .017l-.642 .005l-.642 -.005l-.616 -.017l-.299 -.013l-.579 -.034l-.553 -.046c-4.687 -.455 -6.65 -2.333 -7.166 -6.906l-.03 -.29l-.046 -.553l-.041 -.727l-.006 -.15l-.017 -.617l-.004 -.318v-.648l.004 -.318l.017 -.616l.013 -.299l.034 -.579l.046 -.553c.455 -4.687 2.333 -6.65 6.906 -7.166l.29 -.03l.553 -.046l.727 -.041l.15 -.006l.617 -.017c.21 -.003 .424 -.005 .642 -.005zm.01 13l-.127 .007a1 1 0 0 0 0 1.986l.117 .007l.127 -.007a1 1 0 0 0 0 -1.986l-.117 -.007zm-.01 -8a1 1 0 0 0 -.993 .883l-.007 .117v4l.007 .117a1 1 0 0 0 1.986 0l.007 -.117v-4l-.007 -.117a1 1 0 0 0 -.993 -.883z"/>
                                            </svg>
                                            Liên hệ với quản trị viên
                                        </button>
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
            <div class="col-lg d-none d-lg-block">
                <img src="<c:url value='/template/admin/static/img/undraw_secure_login_pdn4.svg' />" height="300"
                     class="d-block mx-auto" alt="">
            </div>
        </div>
    </div>
</div>
<!-- Libs JS -->
<!-- Tabler Core -->
<script src="<c:url value='/template/admin/dist/js/tabler.min.js?1692870487' />" defer></script>
<script src="<c:url value='/template/admin/dist/js/demo.min.js?1692870487' />" defer></script>
<script src="<c:url value='/template/admin/dist/js/validator.js' />" defer></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js" referrerpolicy="no-referrer"></script>
<!--  Js Toast -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!--  moment -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!--  sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

    $(document).ready(function () {

        Validator({
            form: '#formSubmit',
            errorSelector: '.form-message',
            rules: [
                Validator.isRequired('#username', 'Vui lòng nhập trường này'),
                Validator.isRequired('#password', 'Vui lòng nhập trường này'),
            ]
        });

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

        <c:if test="${not empty message}">
        message_toastr("${message.type}", "${message.message}");
        </c:if>


        $('#click-submit').click(function (event) {
            event.preventDefault();

            if ($('#username').val() === '' ||
                $('#password').val() === '' ||
                $('.form-message').text() !== '') {
                message_toastr("warning", "Dữ liệu nhập vào không hợp lệ!");
            } else {
                $("#formSubmit").unbind('submit').submit();
            }

        });
    });

</script>
</body>
</html>