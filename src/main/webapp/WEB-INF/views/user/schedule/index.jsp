<%@page import="java.time.DayOfWeek" %>
<%@page import="java.time.LocalDate" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="now" value="<%=new java.util.Date()%>"/>
<%
    LocalDate today = LocalDate.now();

    DayOfWeek firstDayOfWeek = DayOfWeek.MONDAY;
    DayOfWeek currentDayOfWeek = today.getDayOfWeek();
    int daysUntilMonday = (currentDayOfWeek.getValue() - firstDayOfWeek.getValue() + 7) % 7;

    LocalDate monday = today.minusDays(daysUntilMonday);
    LocalDate nextMonday = monday.plusDays(7);
%>

<c:url var="dataScheduleApi" value="/api/schedule/dataEmployee"></c:url>
<c:url var="saveScheduleApi" value="/api/schedule/register"></c:url>

<style>
    td.shift-register {
        height: 40px;
        line-height: 40px;
        text-align: center;
    }
</style>

<div class="modal" id="exampleModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">

                <h5 class="modal-title">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-calendar-plus">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M12.5 21h-6.5a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v5"/>
                        <path d="M16 3v4"/>
                        <path d="M8 3v4"/>
                        <path d="M4 11h16"/>
                        <path d="M16 19h6"/>
                        <path d="M19 16v6"/>
                    </svg>
                    Đăng ký ca làm việc cho tuần tiếp theo
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="mt-4">
                <div class="d-flex justify-content-center">
                    <div class="d-flex align-items-center">
                        <div class="badge bg-green text-white px-2 py-1">YES</div>
                        <div class="ms-2">Đã đăng ký</div>
                    </div>
                    <div class="d-flex align-items-center ms-4">
                        <div class="badge bg-light text-dark px-2 py-1">NO</div>
                        <div class="ms-2">Chưa đăng ký</div>
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <table id="register_table" class="table table-bordered table-responsive">
                    <thead class="">
                    <tr class="text-center">
                        <th scope="col">Thời gian</th>
                        <th scope="col">SÁNG</th>
                        <th scope="col">CHIỀU</th>
                        <th scope="col">TỐI</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">
                            THỨ HAI
                            <br/>
                            <span class="small"><%=nextMonday%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            THỨ BA
                            <br/>
                            <span class="small"><%=nextMonday.plusDays(1)%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday.plusDays(1)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday.plusDays(1)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday.plusDays(1)%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            THỨ TƯ
                            <br/>
                            <span class="small"><%=nextMonday.plusDays(2)%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday.plusDays(2)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday.plusDays(2)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday.plusDays(2)%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            THƯ NĂM
                            <br/>
                            <span class="small"><%=nextMonday.plusDays(3)%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday.plusDays(3)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday.plusDays(3)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday.plusDays(3)%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            THỨ SÁU
                            <br/>
                            <span class="small"><%=nextMonday.plusDays(4)%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday.plusDays(4)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday.plusDays(4)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday.plusDays(4)%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            THỨ BẢY
                            <br/>
                            <span class="small"><%=nextMonday.plusDays(5)%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday.plusDays(5)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday.plusDays(5)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday.plusDays(5)%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">
                            CHỦ NHẬT
                            <br/>
                            <span class="small"><%=nextMonday.plusDays(6)%></span>
                        </th>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="1"
                            data-dateRegister="<%=nextMonday.plusDays(6)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="2"
                            data-dateRegister="<%=nextMonday.plusDays(6)%>"></td>
                        <td class="shift-register" data-employeeIdRegister="${currentAccount.id}"
                            data-shiftIdRegister="3"
                            data-dateRegister="<%=nextMonday.plusDays(6)%>"></td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button class="btn btn-outline-primary" onclick="resetRegister()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-refresh">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M20 11a8.1 8.1 0 0 0 -15.5 -2m-.5 -4v4h4"/>
                        <path d="M4 13a8.1 8.1 0 0 0 15.5 2m.5 4v-4h-4"/>
                    </svg>
                    Xóa hết
                </button>
                <button class="btn btn-primary ms-auto" onclick="sendDataAjax()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-send">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M10 14l11 -11"/>
                        <path d="M21 3l-6.5 18a.55 .55 0 0 1 -1 0l-3.5 -7l-7 -3.5a.55 .55 0 0 1 0 -1l18 -6.5"/>
                    </svg>
                    Gửi
                </button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row my-2">

        <div class="col-12 d-flex justify-content-end">
            <div class="button-group">

                <button class="btn btn-outline-primary" onclick="loadDataAjax()">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-refresh">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M20 11a8.1 8.1 0 0 0 -15.5 -2m-.5 -4v4h4"/>
                        <path d="M4 13a8.1 8.1 0 0 0 15.5 2m.5 4v-4h-4"/>
                    </svg>
                    Làm mới
                </button>

                <button class="btn btn-outline-primary"
                        data-bs-toggle="modal" data-bs-target="#exampleModal">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                         stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                         class="icon icon-tabler icons-tabler-outline icon-tabler-table-plus">
                        <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                        <path d="M12.5 21h-7.5a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h14a2 2 0 0 1 2 2v7.5"/>
                        <path d="M3 10h18"/>
                        <path d="M10 3v18"/>
                        <path d="M16 19h6"/>
                        <path d="M19 16v6"/>
                    </svg>
                    Đăng ký ca
                </button>
            </div>
        </div>

    </div>

    <div class="row ">
        <div class="col-12">
            <div class="card">
                <div class="card-header justify-content-between align-items-center">
                    <h4 class="card-title">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-calendar-clock">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M10.5 21h-4.5a2 2 0 0 1 -2 -2v-12a2 2 0 0 1 2 -2h12a2 2 0 0 1 2 2v3"/>
                            <path d="M16 3v4"/>
                            <path d="M8 3v4"/>
                            <path d="M4 11h10"/>
                            <path d="M18 18m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0"/>
                            <path d="M18 16.5v1.5l.5 .5"/>
                        </svg>
                        Lịch làm việc tuần
                    </h4>
                    <div class="card-text ">
                        <span class="card-text fw-bold"><%=monday%></span>
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-arrow-narrow-right">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M5 12l14 0"/>
                            <path d="M15 16l4 -4"/>
                            <path d="M15 8l4 4"/>
                        </svg>
                        <span class="card-text fw-bold"><%=monday.plusDays(6)%></span>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col table-responsive">
                            <table id="schedule_employee"
                                   class="table text-center table-bordered table-striped table-hover ">
                                <thead>
                                <tr>
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
                                    <td class="fw-bold">SÁNG</td>
                                    <td data-shiftId="1" data-date="<%=monday%>" class="cell"></td>
                                    <td data-shiftId="1" data-date="<%=monday.plusDays(1)%>" class="cell"></td>
                                    <td data-shiftId="1" data-date="<%=monday.plusDays(2)%>" class="cell"></td>
                                    <td data-shiftId="1" data-date="<%=monday.plusDays(3)%>" class="cell"></td>
                                    <td data-shiftId="1" data-date="<%=monday.plusDays(4)%>" class="cell"></td>
                                    <td data-shiftId="1" data-date="<%=monday.plusDays(5)%>" class="cell"></td>
                                    <td data-shiftId="1" data-date="<%=monday.plusDays(6)%>" class="cell"></td>
                                </tr>
                                <%-- AFTERNOON SHIFT --%>
                                <tr>
                                    <td class="fw-bold">CHIỀU</td>
                                    <td data-shiftId="2" data-date="<%=monday%>" class="cell"></td>
                                    <td data-shiftId="2" data-date="<%=monday.plusDays(1)%>" class="cell"></td>
                                    <td data-shiftId="2" data-date="<%=monday.plusDays(2)%>" class="cell"></td>
                                    <td data-shiftId="2" data-date="<%=monday.plusDays(3)%>" class="cell"></td>
                                    <td data-shiftId="2" data-date="<%=monday.plusDays(4)%>" class="cell"></td>
                                    <td data-shiftId="2" data-date="<%=monday.plusDays(5)%>" class="cell"></td>
                                    <td data-shiftId="2" data-date="<%=monday.plusDays(6)%>" class="cell"></td>
                                </tr>
                                <%-- EVENING SHIFT --%>
                                <tr>
                                    <td class="fw-bold">TỐI</td>
                                    <td data-shiftId="3" data-date="<%=monday%>" class="cell"></td>
                                    <td data-shiftId="3" data-date="<%=monday.plusDays(1)%>" class="cell"></td>
                                    <td data-shiftId="3" data-date="<%=monday.plusDays(2)%>" class="cell"></td>
                                    <td data-shiftId="3" data-date="<%=monday.plusDays(3)%>" class="cell"></td>
                                    <td data-shiftId="3" data-date="<%=monday.plusDays(4)%>" class="cell"></td>
                                    <td data-shiftId="3" data-date="<%=monday.plusDays(5)%>" class="cell"></td>
                                    <td data-shiftId="3" data-date="<%=monday.plusDays(6)%>" class="cell"></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    function loadDataRegisterScheduleAjax() {
        $.ajax({
            url: "${dataScheduleApi}",
            type: "GET",
            data: {
                "startDate": "<%=nextMonday%>",
                "endDate": "<%=nextMonday.plusDays(6)%>"
            },
            success: function (response) {
                var data = response.data;

                for (var i = 0; i < data.workSchedules.length; i++) {
                    var workSchedule = data.workSchedules[i];
                    var date = workSchedule.date;
                    var shiftId = workSchedule.shift.id;
                    var employeeId = workSchedule.account.id;

                    if (employeeId === ${currentAccount.id}) {
                        var cell = document.querySelector("td[data-dateRegister='" + date + "'][data-shiftIdRegister='" + shiftId + "'][data-employeeIdRegister='" + ${currentAccount.id} +"']");
                        cell.textContent = "YES";
                        cell.classList.add("bg-green");
                        cell.style.color = "white";
                    }
                }

            }
        })
    }

    function resetRegister() {
        document.querySelectorAll('td.shift-register').forEach(item => {
            // add effect transition
            item.style.transition = "all 0.5s"
            item.textContent = `NO`
            item.classList.remove("bg-green")
            item.style.color = "black"
        })
        sendDataAjax()
    }

    function sendDataAjax() {

        let tableElement = document.getElementById("register_table");

        var register_schedule = {};

        for (var i = 1; i < tableElement.rows.length; i++) {
            for (var j = 1; j < tableElement.rows[i].cells.length; j++) {
                var date = tableElement.rows[i].cells[j].getAttribute("data-dateRegister");
                var shiftId = tableElement.rows[i].cells[j].getAttribute("data-shiftIdRegister");
                var employees = [];
                if (tableElement.rows[i].cells[j].textContent === "YES") {
                    employees.push(tableElement.rows[i].cells[j].getAttribute("data-employeeIdRegister"));
                }
                if (!register_schedule[date]) {
                    register_schedule[date] = {};
                }
                register_schedule[date][shiftId] = employees;
            }
        }

        $.ajax({
            url: "${saveScheduleApi}",
            type: "POST",
            contentType: "application/x-www-form-urlencoded",
            data: {
                "startDate": "<%=nextMonday%>",
                "endDate": "<%=nextMonday.plusDays(6)%>",
                "accountId": ${currentAccount.id},
                "schedule": JSON.stringify(register_schedule)
            },
            success: function (response) {
                Swal.fire({
                    position: "center",
                    icon: "success",
                    title: "Đăng ký thành công",
                    showConfirmButton: false,
                    timer: 1000
                });
            },
            error: function (xhr, status, error) {
                toastr.error("Đăng ký thất bại");
            }
        });


    }


    function loadDataAjax() {
        var cells = document.querySelectorAll(".cell");
        for (var i = 0; i < cells.length; i++) {
            cells[i].innerHTML = "";
        }

        $.ajax({
            url: "${dataScheduleApi}",
            type: "GET",
            data: {
                "startDate": "<%=monday%>",
                "endDate": "<%=monday.plusDays(6)%>"
            },
            success: function (response) {
                var data = response.data;

                for (var i = 0; i < data.workSchedules.length; i++) {
                    var workSchedule = data.workSchedules[i];
                    var date = workSchedule.date;
                    var shiftId = workSchedule.shift.id;
                    var employeeId = workSchedule.account.id;
                    var employeeName = workSchedule.account.fullname;

                    var cell = document.querySelector("td[data-date='" + date + "'][data-shiftId='" + shiftId + "']");
                    var newItem = document.createElement("div");
                    newItem.className = "item-shift px-1 py-2 my-1 border rounded btn";
                    newItem.textContent = employeeName;
                    newItem.setAttribute("data-employeeId", employeeId);
                    if (employeeId === ${currentAccount.id}) {
                        newItem.style.backgroundColor = "green";
                        newItem.style.color = "white";
                    }
                    newItem.style.width = "100%";

                    newItem.ondragstart = function (event) {
                        drag(event);
                    };

                    cell.appendChild(newItem);
                }


                toastr.success("Lấy dữ liệu thành công");
            }
            ,
            error: function (xhr, status, error) {
                toastr.error("Lấy dữ liệu thất bại");
            }
        });
    }

    function toggleRegister() {
        if (this.textContent === "NO") {
            this.textContent = "YES";
            this.classList.add("bg-green");
            this.style.color = "white";
        } else {
            this.textContent = "NO";
            this.classList.remove("bg-green");
            this.style.color = "black";
        }
    }

    $(document).ready(function () {
        document.querySelectorAll('td.shift-register').forEach(item => {
            item.style.transition = "all 0.5s"
            item.style.cursor = "pointer"
            item.style.userSelect = "none"
            item.textContent = `NO`
            item.addEventListener("click", toggleRegister)
        })

        loadDataAjax();
        loadDataRegisterScheduleAjax()


    })
</script>
