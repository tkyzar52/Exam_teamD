<%-- 成績管理一覧JSP --%>
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
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績管理一覧</h2>
            <div class="mx-4">
                <div class="mb-3">
                    <a href="TestListStudent.action">学生別成績一覧</a>
                    &nbsp;|&nbsp;
                    <a href="TestListSubject.action">科目別成績一覧</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>