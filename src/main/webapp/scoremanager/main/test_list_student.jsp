<%-- 学生別成績一覧JSP --%>
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
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">学生別成績一覧</h2>
            <form method="get" action="TestListStudent.action">
                <div class="row border mx-3 mb-3 py-2 align-items-center rounded" id="filter">
                    <div class="col-4">
                        <label class="form-label" for="student_no">学生</label>
                        <select class="form-select" id="student_no" name="student_no">
                            <option value="0">--------</option>
                            <c:forEach var="student" items="${students}">
                                <option value="${student.no}"
                                    <c:if test="${student.no == student_no}">selected</c:if>>
                                    ${student.no} - ${student.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-2 text-center">
                        <button class="btn btn-secondary" id="filter-button">検索</button>
                    </div>
                </div>
            </form>

            <c:choose>
                <c:when test="${tests != null && tests.size() > 0}">
                    <div class="mx-3">検索結果：${tests.size()}件</div>
                    <table class="table table-hover">
                        <tr>
                            <th>科目コード</th>
                            <th>科目名</th>
                            <th>回数</th>
                            <th>得点</th>
                        </tr>
                        <c:forEach var="test" items="${tests}">
                            <tr>
                                <td>${test.subjectCd}</td>
                                <td>${test.subjectName}</td>
                                <td>${test.num}</td>
                                <td>${test.point}</td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:when>
                <c:when test="${tests != null && tests.size() == 0}">
                    <div class="mx-4">成績情報が存在しませんでした。</div>
                </c:when>
            </c:choose>
        </section>
    </c:param>
</c:import>