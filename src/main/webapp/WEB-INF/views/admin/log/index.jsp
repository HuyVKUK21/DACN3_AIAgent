<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="row">
                <div class="col-md-6">
                    <h1 class="h3 mb-3">Nhật ký chấm công</h1>
                </div>
                <div class="col-md-6 text-end">
                    <button id="del_logs" class="btn btn-outline-danger">Xóa</button>
                </div>

            </div>

            <table id="table_logs" class="table table-responsive table-striped table-bordered" style="width:100%">

                <thead>
                <tr>
                    <th>Tên Đăng Nhập</th>
                    <th>Họ và tên</th>
                    <th>Thời gian</th>
                    <th>Loại</th>
                    <th>Trạng thái</th>
                </tr>
                </thead>
                <tbody>
                <jsp:useBean id="logs" scope="request" type="java.util.List"/>
                <c:forEach var="log" items="${logs}">
                    <tr data-logid="${log.id}">
                        <td>${log.account.username}</td>
                        <td>${log.account.fullname}</td>
                        <td>${log.createdDate}</td>
                        <c:choose>
                            <c:when test="${log.action == 'CHECK_IN'}">
                                <td><span class="icon me-1 badge bg-green"></span>Check in</td>
                            </c:when>
                            <c:when test="${log.action == 'CHECK_OUT'}">
                                <td><span class="icon me-1 badge bg-red"></span>Check out</td>
                            </c:when>
                            <c:otherwise>
                                <td>${log.action}</td>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${log.status == true}">
                                <td><span class="icon me-1 badge bg-green"></span>Thành công</td>
                            </c:when>
                            <c:when test="${log.status == false}">
                                <td><span class="icon me-1 badge bg-red"></span>Thất bại</td>
                            </c:when>
                            <c:otherwise>
                                <td>${log.status}</td>
                            </c:otherwise>
                        </c:choose>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

</div>


<script>
    $(document).ready(function () {
        $('#table_logs').DataTable({
            "order": [[2, "desc"]],
        });

        $('#table_logs tbody').on('click', 'tr', function () {
            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
            } else {
                $(this).addClass('selected');
            }
        });


        $('#del_logs').click(function () {
            // get long[] logIds send to server
            let logIds = [];
            $('#table_logs tbody tr.selected').each(function () {
                logIds.push($(this).data('logid'));
            });

            if (logIds.length === 0) {
                Swal.fire({
                    icon: 'error',
                    title: 'Chưa chọn bản ghi nào',
                    showConfirmButton: false,
                    timer: 1500
                });
                return;
            }

            $.ajax({
                url: '<c:url value="/api/log/delete"/>',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(logIds),
                success: function (data) {
                    if (data.code === 200) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Xóa thành công',
                            showConfirmButton: false,
                            timer: 1500
                        });
                        $('#table_logs tbody tr.selected').remove();
                    }
                },
                error: function (data) {
                    if (data.code === 400) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Xóa thất bại',
                            showConfirmButton: false,
                            timer: 1500
                        });
                    }
                }
            });
        });
    });
</script>