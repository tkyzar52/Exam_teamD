<%-- 成績登録JSP --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:import url="/common/base.jsp">
    <c:param name="title">
        得点管理システム
    </c:param>

    <c:param name="scripts"></c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績登録</h2>
            <form method="post" action="TestRegistExecute.action">
                <div class="mx-4" style="max-width: 500px;">
                    <div class="mb-3">
                        <label class="form-label" for="student_no">学生番号</label>
                        <select class="form-select" id="student_no" name="student_no">
                            <option value="0">--------</option>
                            <c:forEach var="student" items="${students}">
                                <option value="${student.no}"
                                    <c:if test="${student.no == student_no}">selected</c:if>>
                                    ${student.no} - ${student.name}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="text-danger small">${errors.get("student_no")}</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="subject_cd">科目</label>
                        <select class="form-select" id="subject_cd" name="subject_cd">
                            <option value="0">--------</option>
                            <c:forEach var="subject" items="${subjects}">
                                <option value="${subject.cd}"
                                    <c:if test="${subject.cd == subject_cd}">selected</c:if>>
                                    ${subject.name}
                                </option>
                            </c:forEach>
                        </select>
                        <div class="text-danger small">${errors.get("subject_cd")}</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="no">回数</label>
                        <input class="form-control" type="number" id="no" name="no"
                               value="${no}" min="1" />
                        <div class="text-danger small">${errors.get("no")}</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="point">得点</label>
                        <input class="form-control" type="number" id="point" name="point"
                               value="${point}" min="0" max="100" />
                        <div class="text-danger small">${errors.get("point")}</div>
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">登録</button>
                        <a href="Menu.action" class="btn btn-secondary">キャンセル</a>
                    </div>
                </div>
            </form>
        </section>
    </c:param>
</c:import>