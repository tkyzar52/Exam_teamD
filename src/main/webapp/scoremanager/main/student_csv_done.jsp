<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
    <c:param name="scripts"></c:param>

    <c:param name="content">
        <section class="me-4">

            <h2 class="h3 mb-4 fw-bold bg-secondary bg-opacity-10 py-2 px-3">
                CSV一括登録完了
            </h2>

            <div style="max-width: 700px;">

                <!-- 成功件数 -->
                <div class="alert alert-success">
                   学生登録： <strong>${csv_success_list.size()} 件</strong> 
                </div>

                <!-- 登録成功リスト -->
                <c:if test="${not empty csv_success_list}">
                    <h5>登録情報</h5>
                    <ul class="list-group mb-4">
                        <c:forEach var="item" items="${csv_success_list}">
                            <li class="list-group-item list-group-item-success">✔ ${item}</li>
                        </c:forEach>
                    </ul>
                </c:if>

                <!-- エラーリスト -->
                <c:if test="${not empty csv_error_map}">
                    <div class="alert alert-warning">
                        <strong>${csv_error_map.size()} 件</strong> の行にエラーがありスキップされました。
                    </div>
                    <ul class="list-group mb-4">
                        <c:forEach var="entry" items="${csv_error_map}">
                            <li class="list-group-item list-group-item-warning">⚠ ${entry.value}</li>
                        </c:forEach>
                    </ul>
                </c:if>

                <!-- ボタン -->
                <div class="d-flex gap-3 mt-3">
                    <a href="StudentCreate.action" class="btn btn-secondary">続けて登録</a>
                    <a href="StudentList.action" class="btn btn-outline-secondary">学生一覧へ戻る</a>
                </div>

            </div>

        </section>
    </c:param>
</c:import>
