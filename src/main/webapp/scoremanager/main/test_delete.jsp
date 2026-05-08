<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="container mt-4">
    <h2 class="text-danger">成績削除確認</h2>

    <c:if test="${not empty errors}">
        <div class="alert alert-danger">
            <c:forEach var="error" items="${errors}">
                ${error}<br>
            </c:forEach>
        </div>
    </c:if>

    <div class="alert alert-warning mt-4">
        以下の成績データを削除します。よろしいですか？<br>
    </div>

    <form action="TestDeleteExecute.action" method="post">
        <%-- Скрытые ключи для SQL-запроса --%>
        <input type="hidden" name="student_no" value="${test.student.no}">
        <input type="hidden" name="subject_cd" value="${test.subject.cd}">
        <input type="hidden" name="no" value="${test.no}">

        <table class="table table-bordered mt-3">
            <tr>
                <th class="table-light" style="width: 200px;">学生番号</th>
                <td>${test.student.no}</td>
            </tr>
            <tr>
                <th class="table-light">氏名</th>
                <td>${test.student.name}</td>
            </tr>
            <tr>
                <th class="table-light">科目</th>
                <td>${test.subject.name}</td>
            </tr>
            <tr>
                <th class="table-light">回数</th>
                <td>${test.no}</td>
            </tr>
            <tr>
                <th class="table-light">得点</th>
                <td class="text-danger font-weight-bold">${test.point} 点</td>
            </tr>
        </table>

        <div class="mt-4">
            <button type="submit" class="btn btn-danger">削除</button>
            <a href="TestList.action" class="btn btn-secondary">キャンセル</a>
        </div>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>