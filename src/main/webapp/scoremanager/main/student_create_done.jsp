<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">得点管理システム</c:param>

    <c:param name="scripts"></c:param>

    <c:param name="content">

        <section class="me-4">

            <h2 class="h3 mb-4 fw-bold bg-secondary bg-opacity-10 py-2 px-3">
                学生情報登録
            </h2>

            <div style="max-width: 700px;">

                <p class="bg-success bg-opacity-50 text-dark py-2 px-3 mb-4 text-center">
                    登録が完了しました
                </p>

                <div class="d-flex gap-4">

                    <a href="StudentCreate.action">
                        戻る
                    </a>

                    <a href="StudentList.action">
                        学生一覧
                    </a>

                </div>

            </div>

        </section>

    </c:param>

</c:import>
