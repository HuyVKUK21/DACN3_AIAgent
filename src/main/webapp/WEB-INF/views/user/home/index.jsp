<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    LocalDate startDate = LocalDate.now().withDayOfMonth(1); ;
    LocalDate endDate = LocalDate.now().withDayOfMonth(startDate.lengthOfMonth()); ;
%>

<div class="container my-5">

    <div class="row">
        <div class="col-lg-3">
            <div class="card text-center">
                <div class="card-header">
                    <h3 class="card-title">✋ Xin chào, ${currentAccount.fullname}</h3>
                </div>
                <div class="card-body">
                    <p class="card-code">Chúc bạn một ngày làm việc hiệu quả!</p>
                    <p class="time-now"></p>
                    <button id="check-log" class="btn btn-primary">Check in</button>
                </div>
            </div>
        </div>

        <div class="col-lg-9 mt-2 mt-lg-0">
            <div class="card">
                <div class="card-header">
                    <div class="me-1">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-brand-google-analytics">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M10 9m0 1.105a1.105 1.105 0 0 1 1.105 -1.105h1.79a1.105 1.105 0 0 1 1.105 1.105v9.79a1.105 1.105 0 0 1 -1.105 1.105h-1.79a1.105 1.105 0 0 1 -1.105 -1.105z"/>
                            <path d="M17 3m0 1.105a1.105 1.105 0 0 1 1.105 -1.105h1.79a1.105 1.105 0 0 1 1.105 1.105v15.79a1.105 1.105 0 0 1 -1.105 1.105h-1.79a1.105 1.105 0 0 1 -1.105 -1.105z"/>
                            <path d="M5 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0"/>
                        </svg>
                    </div>
                    <h3 class="card-title">Thống kê</h3>
                </div>
                <div class="card-body">
                    <div class="row ">
                        <div class="col-lg-4 mt-2 mt-lg-0">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Lương tháng <%=LocalDate.now().getMonth().ordinal() + 1%></h5>
                                </div>
                                <div class="card-body">
                                    <h1 id="salary">000000 <span class="text-muted"> VND</span></h1>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-8 mt-2 mt-lg-0">
                            <div class="card">
                                <div class="card-header">
                                    <h5 class="card-title">Số ca làm đã check-in trong tháng <%=LocalDate.now().getMonth().ordinal() + 1%></h5>
                                </div>
                                <div class="card-body">
                                    <h1 id="works_quantity">0 <span class="text-muted"> ca</span></h1>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row my-3">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Lịch sử</h3>
                </div>
                <div class="tox-hue-slider" id="logs">


                </div>

            </div>
        </div>
    </div>


</div>
<div class="footer">
    <div class="text-center">
        <p>© 2024 <a href="" target="_blank">Gymer Team</a>. All rights reserved.</p>
    </div>
</div>
<script>

    function getLogs(accountId) {

        $.ajax({
            url: `<c:url value="/api/log/get-all-log"/>`,
            type: 'GET',
            data: {
                accountId: accountId,
            },
            success: function (response) {

                if (response.code === 400) {
                    toastr.info(response.message);
                    return
                }

                let logs = response.data;
                let logHtml = '';
                logs.forEach((log) => {


                    let action = log.action === 'CHECK_IN' ? 'Check in' : 'Check out';
                    let date = new Date(log.createdDate);
                    let createdDate = date.toLocaleString('vi-VN');
                    let time = date.toLocaleTimeString('vi-VN');

                    let tag = '';
                    if (action === 'Check in') {
                        tag = `<span class="badge bg-green"></span>`;
                    } else {
                        tag = `<span class="badge bg-red"></span>`;
                    }

                    logHtml += `
                        <div class="list-group list-group-flush list-group-hoverable">
                        <div class="card-header bg-secondary-lt">
                            <h3 class="card-title">
                                ` + createdDate + `
                            </h3>
                        </div>
                        <div class="list-group-item">
                            <div class="row align-items-center">
                                <div class="col-auto">` + tag + `</div>
                                <div class="col text-truncate">
                                    <a class="text-reset d-block">` + log.account.fullname + `</a>
                                    <div class="d-block text-secondary text-truncate mt-n1">` + action + `</div>
                                </div>

                                <div class="col-auto">
                                    <div class="d-block text-secondary text-truncate mt-n1"> ` + time + `</div>
                                </div>
                            </div>
                        </div>
                        `;
                })
                document.getElementById('logs').innerHTML = logHtml;
            },
            error: function (error) {
                alert(error.message);
            }
        })

    }
    function getLog() {
        $.ajax({
            url: `<c:url value="/api/log/get-log"/>`,
            type: 'GET',
            data: {
                accountId: `${currentAccount.id}`,
            },
            success: function (response) {

                if (response.code === 400) {
                    toastr.info(response.message);
                    return
                }

                if (response.data === `CHECKED_OUT`) {
                    document.getElementById('check-log').textContent = 'Check out';
                } else if (response.data === `CHECKED_IN`) {
                    document.getElementById('check-log').textContent = 'Check in';
                }
            },
            error: function (error) {
                alert(error.data);
            }
        })
    }
    function checkLog(logType) {

        if (logType === 'check-in') {
            $.ajax({
                url: `<c:url value="/api/log/check-in"/>`,
                type: 'POST',
                data: {
                    accountId: `${currentAccount.id}`
                },
                success: function (response) {

                    if (response.code === 400) {
                        toastr.error(response.message);
                        return
                    }

                    toastr.success(response.message)

                    getLog()
                    getLogs(${currentAccount.id});

                    document.getElementById('check-log').textContent = 'Check out';
                },
                error: function (error) {
                    toastr.error(error.message)
                }
            })
        } else if (logType === 'check-out') {
            $.ajax({
                url: `<c:url value="/api/log/check-out"/>`,
                type: 'POST',
                data: {
                    accountId: `${currentAccount.id}`
                },
                success: function (response) {

                    if (response.code === 400) {
                        toastr.error(response.message);
                        return
                    }

                    toastr.success(response.message)
                    getLog()
                    getLogs(${currentAccount.id});

                    document.getElementById('check-log').textContent = 'Check in';
                },
                error: function (error) {
                    toastr.error(error.message)
                }
            })
        }


    }
    document.getElementById('check-log').addEventListener('click', function () {

        if (document.getElementById('check-log').textContent === 'Check in') {

            document.getElementById('check-log').textContent = 'Loading...';
            setTimeout(() => {
                checkLog("check-in");
            }, 1000);
        } else if (document.getElementById('check-log').textContent === 'Check out') {
            document.getElementById('check-log').textContent = 'Loading...';
            setTimeout(() => {
                checkLog("check-out");
            }, 1000);
        }


    });
    function getSalary(){
        // start date: first day of month : 2024-08-01
        // end date: end day of month: 2024-08-31


        $.ajax({
            url: `<c:url value="/api/dashboard/get-salary"/>`,
            type: 'GET',
            data: {
                accountId: `${currentAccount.id}`,
                startDate: `<%=startDate%>`,
                endDate: `<%=endDate%>`
            },
            success: function (response) {

                if (response.code === 400) {
                    toastr.error(response.message);
                    return
                }

                document.getElementById('salary').textContent = response.data + ' VND';
            },
            error: function (error) {
                toastr.error(error.message)
            }
        })
    }
    function getWorksQuantity() {
        $.ajax({
            url: `<c:url value="/api/dashboard/get-attendance"/>`,
            type: 'GET',
            data: {
                accountId: `${currentAccount.id}`,
                startDate: `<%=startDate%>`,
                endDate: `<%=endDate%>`
            },
            success: function (response) {

                if (response.code === 400) {
                    toastr.error(response.message);
                    return
                }

                document.getElementById('works_quantity').textContent = response.data + ' ca';
            },
            error: function (error) {
                toastr.error(error.message)
            }
        })
    }
    $(document).ready(function () {
        setInterval(() => {
            let timeNow = new Date();
            document.querySelector('.time-now').textContent = timeNow.toLocaleString('vi-VN');
        }, 1000);
        getLogs(${currentAccount.id});
        getLog();
        getSalary();
        getWorksQuantity();
    });





</script>