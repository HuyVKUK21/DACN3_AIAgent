<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container">
    <div class="row">
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-sunset-2">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M3 13h1"/>
                            <path d="M20 13h1"/>
                            <path d="M5.6 6.6l.7 .7"/>
                            <path d="M18.4 6.6l-.7 .7"/>
                            <path d="M8 13a4 4 0 1 1 8 0"/>
                            <path d="M3 17h18"/>
                            <path d="M7 20h5"/>
                            <path d="M16 20h1"/>
                            <path d="M12 5v-1"/>
                        </svg>
                        Ca Sáng
                    </h3>
                </div>
                <div class="card-body">
                    <%--@elvariable id="shift_morning" type="com.fsoft.dto.ShiftDTO"--%>
                    <form:form action="${pageContext.request.contextPath}/admin/shift/save" method="post"
                               modelAttribute="shift_morning">
                    <input type="hidden" class="form-control" name="id" value="${shift_morning.id}"/>
                    <input type="hidden" class="form-control" name="shiftType" value="${shift_morning.shiftType}"/>
                    <div class="mb-3">
                        <label class="form-label">Thời gian bắt đầu ca</label>
                        <input type="time" class="form-control" name="startTime" value="${shift_morning.startTime}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thời gian kết thúc ca</label>
                        <input type="time" class="form-control" name="endTime" value="${shift_morning.endTime}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nhân viên tối đa</label>
                        <input type="number" class="form-control" name="maxEmployee"
                               value="${shift_morning.maxEmployee}"/>
                    </div>
                    <div class="mb-3 ">
                        <label class="form-label">Lương</label>
                        <div class="input-group">
                            <input type="number" class="form-control" value="${shift_morning.salary}" autocomplete="off"
                                   name="salary">
                            <span class="input-group-text">VND</span>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
                </form:form>
            </div>
        </div>
        <%-- Afternoon --%>
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-cloud">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M6.657 18c-2.572 0 -4.657 -2.007 -4.657 -4.483c0 -2.475 2.085 -4.482 4.657 -4.482c.393 -1.762 1.794 -3.2 3.675 -3.773c1.88 -.572 3.956 -.193 5.444 1c1.488 1.19 2.162 3.007 1.77 4.769h.99c1.913 0 3.464 1.56 3.464 3.486c0 1.927 -1.551 3.487 -3.465 3.487h-11.878"/>
                        </svg>
                        Ca Chiều
                    </h3>
                </div>
                <div class="card-body">
                    <%--@elvariable id="shift_afternoon" type="com.fsoft.dto.ShiftDTO"--%>
                    <form:form action="${pageContext.request.contextPath}/admin/shift/save" method="post"
                               modelAttribute="shift_afternoon">
                    <input type="hidden" class="form-control" name="id" value="${shift_afternoon.id}"/>
                    <input type="hidden" class="form-control" name="shiftType" value="${shift_afternoon.shiftType}"/>
                    <div class="mb-3">
                        <label class="form-label">Thời gian bắt đầu ca</label>
                        <input type="time" class="form-control" name="startTime" value="${shift_afternoon.startTime}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thời gian kết thúc ca</label>
                        <input type="time" class="form-control" name="endTime" value="${shift_afternoon.endTime}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nhân viên tối đa</label>
                        <input type="number" class="form-control" name="maxEmployee"
                               value="${shift_afternoon.maxEmployee}"/>
                    </div>
                    <div class="mb-3 ">
                        <label class="form-label">Lương</label>
                        <div class="input-group">
                            <input type="number" class="form-control" value="${shift_afternoon.salary}"
                                   autocomplete="off"
                                   name="salary">
                            <span class="input-group-text">VND</span>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
                </form:form>
            </div>
        </div>
        <%-- Evening --%>
        <div class="col-lg-4">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="icon icon-tabler icons-tabler-outline icon-tabler-moon">
                            <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                            <path d="M12 3c.132 0 .263 0 .393 0a7.5 7.5 0 0 0 7.92 12.446a9 9 0 1 1 -8.313 -12.454z"/>
                        </svg>
                        Ca Tối
                    </h3>
                </div>
                <div class="card-body">
                    <%--@elvariable id="shift_evening" type="com.fsoft.dto.ShiftDTO"--%>
                    <form:form action="${pageContext.request.contextPath}/admin/shift/save" method="post"
                               modelAttribute="shift_evening">
                    <input type="hidden" class="form-control" name="id" value="${shift_evening.id}"/>
                    <input type="hidden" class="form-control" name="shiftType" value="${shift_evening.shiftType}"/>
                    <div class="mb-3">
                        <label class="form-label">Thời gian bắt đầu ca</label>
                        <input type="time" class="form-control" name="startTime" value="${shift_evening.startTime}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Thời gian kết thúc ca</label>
                        <input type="time" class="form-control" name="endTime" value="${shift_evening.endTime}"/>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nhân viên tối đa</label>
                        <input type="number" class="form-control" name="maxEmployee"
                               value="${shift_evening.maxEmployee}"/>
                    </div>
                    <div class="mb-3 ">	
                        <label class="form-label">Lương</label>
                        <div class="input-group">
                            <input type="number" class="form-control" value="${shift_evening.salary}" autocomplete="off"
                                   name="salary">
                            <span class="input-group-text">VND</span>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-end">
                    <button type="submit" class="btn btn-primary">Lưu</button>
                </div>
                </form:form>
            </div>
        </div>

    </div>
</div>