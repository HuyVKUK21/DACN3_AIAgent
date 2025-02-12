<%@page import="java.time.DayOfWeek" %>
<%@page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="now" value="<%=new java.util.Date()%>"/>
<c:url var="saveScheduleApi" value="/api/schedule/save"></c:url>
<c:url var="dataScheduleApi" value="/api/schedule/data"></c:url>

<%
    LocalDate monday = LocalDate.now().with(DayOfWeek.MONDAY);
    if (request.getParameter("type") != null && request.getParameter("type").equals("NEXT_WEEK")) {
        monday = LocalDate.now().with(DayOfWeek.MONDAY).plusDays(7);
    }
%>

<div class="container">
    <h1 class="text-center">LỊCH LÀM VIỆC</h1>
    <p class="text-center">
        <fmt:formatDate type="both" dateStyle="medium" timeStyle="medium"
                        value="${now}"/>
    </p>
    <div class="row">
        <div class="col">
            <button class="btn btn-outline-primary" onclick="loadDataAjax(`<%=monday%>`,`<%=monday.plusDays(6)%>`)">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                     class="icon icon-tabler icons-tabler-outline icon-tabler-refresh">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                    <path d="M20 11a8.1 8.1 0 0 0 -15.5 -2m-.5 -4v4h4"/>
                    <path d="M4 13a8.1 8.1 0 0 0 15.5 2m.5 4v-4h-4"/>
                </svg>
                Làm mới
            </button>

        </div>
        <div class="col-3 d-flex justify-content-end">
            <button class="btn btn-outline-danger me-1" onclick="removeAllData()">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                     class="icon icon-tabler icons-tabler-outline icon-tabler-trash-x">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                    <path d="M4 7h16"/>
                    <path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12"/>
                    <path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3"/>
                    <path d="M10 12l4 4m0 -4l-4 4"/>
                </svg>
                Xóa tất cả
            </button>
            <button class="btn btn-primary" onclick="save()">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                     class="icon icon-tabler icons-tabler-outline icon-tabler-device-floppy">
                    <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                    <path d="M6 4h10l4 4v10a2 2 0 0 1 -2 2h-12a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2"/>
                    <path d="M12 14m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0"/>
                    <path d="M14 4l0 4l-6 0l0 -4"/>
                </svg>
                Lưu
            </button>
        </div>
    </div>
    <div class="row my-3">
        <div class="col-lg-12">
            <table id="schedule"
                   class="table table-bordered table-responsive mb-0">
                <thead>
                <tr class="text-center">
                    <th></th>
                    <th>Thứ Hai <br/> <%=monday%>
                    </th>
                    <th>Thứ Ba <br/> <%=monday.plusDays(1)%>
                    </th>
                    <th>Thứ Tư <br/> <%=monday.plusDays(2)%>
                    </th>
                    <th>Thứ Năm <br/> <%=monday.plusDays(3)%>
                    </th>
                    <th>Thứ Sáu <br/> <%=monday.plusDays(4)%>
                    </th>
                    <th>Thứ Bảy <br/> <%=monday.plusDays(5)%>
                    </th>
                    <th>Chủ Nhật <br/> <%=monday.plusDays(6)%>
                    </th>
                </tr>
                </thead>
                <tbody>
                <%-- MORNING SHIFT --%>

                <tr>
                    <td class="text-center fw-bold">SÁNG</td>
                    <td data-shiftId="1" data-date="<%=monday%>" class="cell"
                        ondrop="drop(event)" ondragover="allowDrop(event)">
                    </td>
                    <td data-shiftId="1" data-date="<%=monday.plusDays(1)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="1" data-date="<%=monday.plusDays(2)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="1" data-date="<%=monday.plusDays(3)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="1" data-date="<%=monday.plusDays(4)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="1" data-date="<%=monday.plusDays(5)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="1" data-date="<%=monday.plusDays(6)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                </tr>
                <%-- AFTERNOON SHIFT --%>
                <tr>
                    <td class="text-center fw-bold">CHIỀU</td>
                    <td data-shiftId="2" data-date="<%=monday%>" class="cell"
                        ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="2" data-date="<%=monday.plusDays(1)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="2" data-date="<%=monday.plusDays(2)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="2" data-date="<%=monday.plusDays(3)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="2" data-date="<%=monday.plusDays(4)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="2" data-date="<%=monday.plusDays(5)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="2" data-date="<%=monday.plusDays(6)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                </tr>
                <%-- EVENING SHIFT --%>
                <tr>
                    <td class="text-center fw-bold">TỐI</td>
                    <td data-shiftId="3" data-date="<%=monday%>" class="cell"
                        ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="3" data-date="<%=monday.plusDays(1)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="3" data-date="<%=monday.plusDays(2)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="3" data-date="<%=monday.plusDays(3)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="3" data-date="<%=monday.plusDays(4)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="3" data-date="<%=monday.plusDays(5)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                    <td data-shiftId="3" data-date="<%=monday.plusDays(6)%>"
                        class="cell" ondrop="drop(event)" ondragover="allowDrop(event)"></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-10">
            <c:if test="${not empty employee}">

                <c:forEach var="e" items="${employee.listResult}">
                    <div class="item btn" draggable="true" ondragstart="drag(event)"
                         data-employeeId="${e.id}">${e.fullname}</div>
                </c:forEach>
            </c:if>
        </div>
        <div class="col-2 d-flex justify-content-end">
            <button class="btn btn-outline-primary" onclick="changeWeekType()">
                <c:if test="${not empty param.type}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-chevron-left">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M9 6l-6 6l6 6"/>
                    </svg>
                    Tuần hiện tại
                </c:if>

                <c:if test="${empty param.type}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-chevron-right">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M9 6l6 6l-6 6"/>
                    </svg>
                    Tuần tiếp theo
                </c:if>

            </button>
        </div>
    </div>
</div>
<script>
    $(document).ready(() => {
    })

    function changeWeekType() {
        if (window.location.href.includes("NEXT_WEEK")) {
            window.location.href = `<c:url value="/admin/schedule"/>`;
            return;
        }
        window.location.href = `<c:url value="/admin/schedule?type=NEXT_WEEK"/>`;
    }

    function removeAllData() {
        const swalWithBootstrapButtons = Swal.mixin({
            customClass: {
                confirmButton: "btn btn-success ",
                cancelButton: "btn btn-danger me-2"
            },
            buttonsStyling: false
        });
        swalWithBootstrapButtons.fire({
            title: "Bạn có chắc chắn không?",
            text: "Bạn không thể hoàn tác hành động này!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Đồng ý, xóa và lưu!",
            cancelButtonText: "Không, hủy bỏ!",
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {


                var cells = document.querySelectorAll(".cell");
                for (var i = 0; i < cells.length; i++) {
                    cells[i].innerHTML = "";
                }

                save();

                swalWithBootstrapButtons.fire({
                    title: "Đã xóa",
                    text: "Xóa thành công!",
                    icon: "success"
                });

            } else if (
                /* Read more about handling dismissals below */
                result.dismiss === Swal.DismissReason.cancel
            ) {
                swalWithBootstrapButtons.fire({
                    title: "Đã hủy bỏ",
                    text: "Hủy bỏ thành công!",
                    icon: "error"
                });
            }
        });
    }


    // function remove employee from cell
    function removeEmployee(event) {
        if (event.target.classList.contains("is-del")) {
            event.target.classList.remove("btn-danger")
            event.target.classList.remove("is-del")
            return
        }
        event.target.classList.add("btn-danger")
        event.target.classList.add("is-del")
    }

    function loadDataAjax(startDate, endDate) {
        var cells = document.querySelectorAll(".cell");
        for (var i = 0; i < cells.length; i++) {
            cells[i].innerHTML = "";
        }

        $.ajax({
            url: "${dataScheduleApi}",
            type: "GET",
            data: {
                "startDate": startDate,
                "endDate": endDate
            },
            success: function (response) {
                var data = response.data;

                for (var i = 0; i < data.workSchedules.length; i++) {
                    var workSchedule = data.workSchedules[i];
                    var date = workSchedule.date;
                    var shiftId = workSchedule.shift.id;
                    var employeeId = workSchedule.account.id;
                    var employeeName = workSchedule.account.fullname;
                    var isActive = workSchedule.isActive;


                    var cell = document.querySelector("td[data-date='" + date + "'][data-shiftId='" + shiftId + "']");
                    var newItem = document.createElement("div");
                    newItem.className = "item-shift px-1 py-2 my-1 border rounded btn";
                    newItem.textContent = employeeName;
                    newItem.setAttribute("data-employeeId", employeeId);
                    newItem.style.width = "100%";

                    if (!isActive) {
                        newItem.classList.add("btn-info");
                        newItem.classList.add("is_not_active");
                    }

                    // set event double click to remove employee from cell
                    newItem.addEventListener("click", removeEmployee);

                    newItem.ondragstart = function (event) {
                        drag(event);
                    };

                    cell.appendChild(newItem);
                }


                toastr.success("Lấy thông tin thành công!");
            }
            ,
            error: function (xhr, status, error) {
                toastr.error("Hiện tại không thể lấy thông tin!");
            }
        });
    }

    // onload
    window.onload = function () {
        loadDataAjax(`<%=monday%>`, `<%=monday.plusDays(6)%>`);
    };

    function allowDrop(event) {
        // get element source
        event.preventDefault();
    }

    function drag(event) {
        console.log(event.target);
        event.dataTransfer.setData("text", event.target.textContent);
        event.dataTransfer.setData("employeeId", event.target.getAttribute("data-employeeId"));
        event.dataTransfer.setData("item", "TRUE");
    }

    function drop(event) {
        event.preventDefault();

        if (!event.dataTransfer.getData("item")) {
            return;
        }

        var data = event.dataTransfer.getData('text');
        var employeeId = event.dataTransfer.getData('employeeId');


        var newItem = document.createElement("div");
        newItem.className = "item-shift px-1 py-2 my-1 border rounded btn";
        newItem.textContent = data;
        // add atributte custom to item
        newItem.setAttribute("data-employeeId", employeeId);
        newItem.style.width = "100%";

        newItem.addEventListener("click", removeEmployee);

        newItem.ondragstart = function (event) {
            drag(event);
        };
        // if target is not cell, return
        if (!event.target.classList.contains("cell")) {
            if (!event.currentTarget) {
                toastr.error("Kéo vào ô ca làm việc mong muốn!");
                return;
            }
            for (var i = 0; i < event.currentTarget.children.length; i++) {
                if (event.currentTarget.children[i].textContent === data) {
                    toastr
                        .error("Nhân viên này đã tồn tại trong ca làm việc này!");
                    return;
                }
            }
            event.currentTarget.appendChild(newItem);
        } else {
            for (var i = 0; i < event.currentTarget.children.length; i++) {
                if (event.currentTarget.children[i].textContent === data) {
                    toastr
                        .error("Nhân viên này đã tồn tại trong ca làm việc này!");
                    return;
                }
            }
            event.currentTarget.appendChild(newItem);
        }
    }

    function save() {
        tableElement = document.getElementById("schedule");
        var data = {};

        let listCellDelete = document.querySelectorAll(".is-del");
        for (let i = 0; i < listCellDelete.length; i++) {
            listCellDelete[i].remove();
        }
        let listCellActive = document.querySelectorAll(".is_not_active");
        for (let i = 0; i < listCellActive.length; i++) {
            listCellActive[i].classList.remove("is_not_active");
            listCellActive[i].classList.remove("btn-info");

        }

        for (var i = 1; i < tableElement.rows.length; i++) {
            for (var j = 1; j < tableElement.rows[i].cells.length; j++) {
                // if cell is empty, continue
                if (tableElement.rows[i].cells[j].children.length === 0) {
                    continue;
                }

                var date = tableElement.rows[i].cells[j].getAttribute("data-date");
                var shiftId = tableElement.rows[i].cells[j].getAttribute("data-shiftId");
                var employees = [];
                for (var k = 0; k < tableElement.rows[i].cells[j].children.length; k++) {
                    employees.push(tableElement.rows[i].cells[j].children[k].getAttribute("data-employeeId"));
                }
                if (!data[date]) {
                    data[date] = {};
                }
                data[date][shiftId] = employees;
            }
        }

        // send data to server
        $.ajax({
            url: "${saveScheduleApi}",
            type: "POST",
            contentType: "application/x-www-form-urlencoded",
            data: {
                "schedule": JSON.stringify(data),
                "startDate": "<%=monday%>",
                "endDate": "<%=monday.plusDays(6)%>"
            },
            success: function (response) {
                toastr.success("Lưu thành công!");
            },
            error: function (xhr, status, error) {
                toastr.error("Có lỗi!");
            }
        });

    }
</script>
