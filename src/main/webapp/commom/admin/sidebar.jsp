<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="dec"
           uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!-- Sidebar -->
<aside class="navbar navbar-vertical navbar-expand-lg"
       data-bs-theme="dark">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#sidebar-menu" aria-controls="sidebar-menu"
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <h1 class="navbar-brand navbar-brand-autodark">
            <a href="<c:url value="/admin/dashboard"/>"> <img
                    src="<c:url value="/template/admin/static/img/cover.png"/>"
                    class="navbar-brand-image py-1">
            </a>
        </h1>
        <div class="collapse navbar-collapse" id="sidebar-menu">
            <ul class="navbar-nav pt-lg-3">
                <!-- Menu -->
                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/admin/dashboard'/>"> <span
                        class="nav-link-icon d-md-none d-lg-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/home -->
							<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24"
                                 height="24" viewBox="0 0 24 24" stroke-width="2"
                                 stroke="currentColor" fill="none" stroke-linecap="round"
                                 stroke-linejoin="round">
								<path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								<path d="M5 12l-2 0l9 -9l9 9l-2 0"/>
								<path d="M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-7"/>
								<path d="M9 21v-6a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v6"/></svg>
					</span> <span class="nav-link-title"> Dashboard </span>
                </a></li>

                <!-- Schedule -->
                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/admin/schedule'/>"> <span
                        class="nav-link-icon d-md-none d-lg-inline-block"> <svg
                        xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                        class="icon icon-tabler icons-tabler-outline icon-tabler-calendar-time">
								<path stroke="none" d="M0 0h24v24H0z" fill="none"/>
								<path
                                        d="M11.795 21h-6.795a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v4"/>
								<path d="M18 18m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0"/>
								<path d="M15 3v4"/>
								<path d="M7 3v4"/>
								<path d="M3 11h16"/>
								<path d="M18 16.496v1.504l1 1"/></svg>
					</span> <span class="nav-link-title">Quản Lý Lịch Làm Việc</span>
                </a></li>
                <!-- Log -->
                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/admin/log'/>"> <span
                        class="nav-link-icon d-md-none d-lg-inline-block"> <svg xmlns="http://www.w3.org/2000/svg"
                                                                                width="24" height="24"
                                                                                viewBox="0 0 24 24" fill="none"
                                                                                stroke="currentColor" stroke-width="2"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round"
                                                                                class="icon icon-tabler icons-tabler-outline icon-tabler-checkbox"><path
                        stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 11l3 3l8 -8"/><path
                        d="M20 12v6a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h9"/></svg>
					</span> <span class="nav-link-title">Quản Lý Chấm Công</span>
                </a></li>
                <!-- Shift -->
                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/admin/shift'/>"> <span
                        class="nav-link-icon d-md-none d-lg-inline-block"><svg xmlns="http://www.w3.org/2000/svg"
                                                                               width="24" height="24"
                                                                               viewBox="0 0 24 24" fill="none"
                                                                               stroke="currentColor" stroke-width="2"
                                                                               stroke-linecap="round"
                                                                               stroke-linejoin="round"
                                                                               class="icon icon-tabler icons-tabler-outline icon-tabler-stack-2"><path
                        stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M12 4l-8 4l8 4l8 -4l-8 -4"/><path
                        d="M4 12l8 4l8 -4"/><path d="M4 16l8 4l8 -4"/></svg></span> <span class="nav-link-title">Quản Lý Ca Làm</span>
                </a></li>

                <!-- Category -->
                <li class="nav-item"><a
                        class="nav-link" href="<c:url value='/admin/category/list-category'/>"> <span
                        class="nav-link-icon d-md-none d-lg-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/star -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="currentColor" class="icon icon-tabler icons-tabler-filled icon-tabler-category"><path
                                    stroke="none" d="M0 0h24v24H0z" fill="none"/><path
                                    d="M10 3h-6a1 1 0 0 0 -1 1v6a1 1 0 0 0 1 1h6a1 1 0 0 0 1 -1v-6a1 1 0 0 0 -1 -1z"/><path
                                    d="M20 3h-6a1 1 0 0 0 -1 1v6a1 1 0 0 0 1 1h6a1 1 0 0 0 1 -1v-6a1 1 0 0 0 -1 -1z"/><path
                                    d="M10 13h-6a1 1 0 0 0 -1 1v6a1 1 0 0 0 1 1h6a1 1 0 0 0 1 -1v-6a1 1 0 0 0 -1 -1z"/><path
                                    d="M17 13a4 4 0 1 1 -3.995 4.2l-.005 -.2l.005 -.2a4 4 0 0 1 3.995 -3.8z"/></svg>
					</span> <span class="nav-link-title"> Quản Lý Danh Mục </span>
                </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/product/list-product'/>">
                        <span class="nav-link-icon d-md-none d-lg-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/star -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-coffee"><path stroke="none"
                                                                                                        d="M0 0h24v24H0z"
                                                                                                        fill="none"/><path
                                    d="M3 14c.83 .642 2.077 1.017 3.5 1c1.423 .017 2.67 -.358 3.5 -1c.83 -.642 2.077 -1.017 3.5 -1c1.423 -.017 2.67 .358 3.5 1"/><path
                                    d="M8 3a2.4 2.4 0 0 0 -1 2a2.4 2.4 0 0 0 1 2"/><path
                                    d="M12 3a2.4 2.4 0 0 0 -1 2a2.4 2.4 0 0 0 1 2"/><path
                                    d="M3 10h14v5a6 6 0 0 1 -6 6h-2a6 6 0 0 1 -6 -6v-5z"/><path
                                    d="M16.746 16.726a3 3 0 1 0 .252 -5.555"/></svg>
					</span> <span class="nav-link-title"> Quản Lý Sản Phẩm </span>
                    </a>
                </li>


                <!-- Table Order -->
                <li class="nav-item ">
                    <a class="nav-link" href="<c:url value='/admin/table-user/list'/>">
                        <span
                                class="nav-link-icon d-md-none d-lg-inline-block">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-armchair">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M5 11a2 2 0 0 1 2 2v2h10v-2a2 2 0 1 1 4 0v4a2 2 0 0 1 -2 2h-14a2 2 0 0 1 -2 -2v-4a2 2 0 0 1 2 -2z"/>
                            <path d="M5 11v-5a3 3 0 0 1 3 -3h8a3 3 0 0 1 3 3v5"/>
                            <path d="M6 19v2"/>
                            <path d="M18 19v2"/>
                        </svg>
                        </span>
                        <span class="nav-link-title"> Quản Lý Bàn </span>
                    </a>
                </li>

                <%-- Order --%>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/order/list-order?page=1&limit=5'/>">
                    <span
                            class="nav-link-icon d-md-none d-lg-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/star -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-file-invoice"><path
                                    stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M14 3v4a1 1 0 0 0 1 1h4"/><path
                                    d="M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z"/><path
                                    d="M9 7l1 0"/><path d="M9 13l6 0"/><path d="M13 17l2 0"/></svg>
					</span>
                        <span class="nav-link-title"> Quản Lý Hóa Đơn </span>
                    </a>
                </li>
                <%-- Account --%>
                <li class="nav-item">
                    <a class="nav-link" href="<c:url value='/admin/account-admin/list'/>">
                    <span
                            class="nav-link-icon d-md-none d-lg-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/star -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-user-circle"><path
                                    stroke="none" d="M0 0h24v24H0z" fill="none"/><path
                                    d="M12 12m-9 0a9 9 0 1 0 18 0a9 9 0 1 0 -18 0"/><path
                                    d="M12 10m-3 0a3 3 0 1 0 6 0a3 3 0 1 0 -6 0"/><path
                                    d="M6.168 18.849a4 4 0 0 1 3.832 -2.849h4a4 4 0 0 1 3.834 2.855"/></svg>
					</span>
                        <span class="nav-link-title"> Quản Lý Tài Khoản </span>
                    </a>
                </li>

                <li class="nav-item"><a class="nav-link"
                                        href="<c:url value='/user/order'/>"> <span
                        class="nav-link-icon d-md-none d-lg-inline-block"> <!-- Download SVG icon from http://tabler-icons.io/i/home -->
							<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-clock"><path stroke="none"
                                                                                                       d="M0 0h24v24H0z"
                                                                                                       fill="none"/><path
                                    d="M3 12a9 9 0 1 0 18 0a9 9 0 0 0 -18 0"/><path d="M12 7v5l3 3"/></svg>
					</span> <span class="nav-link-title"> Trang Đặt Món</span>
                </a></li>
                <!--  -->
                <!--   endmenu -->

            </ul>
        </div>
    </div>
</aside>