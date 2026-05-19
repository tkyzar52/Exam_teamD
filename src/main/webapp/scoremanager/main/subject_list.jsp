<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目管理</h2>

            <div class="mb-3 text-end">
                <a href="SubjectCreate.action">新規登録</a>
            </div>

            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>科目コード</th>
                        <th>科目名</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="subject" items="${subjects}">
                        <tr>
                            <td>${subject.cd}</td>
                            <td>${subject.name}</td>
                            <td class="text-end">
                                <a href="SubjectUpdate.action?cd=${subject.cd}" class="me-5">変更</a>
                                <a href="SubjectDelete.action?cd=${subject.cd}" class="me-5">削除</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${subjects.size() == 0}">
                        <tr>
                            <td colspan="3">科目が登録されていません</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <div class="mt-3">
                <a href="Menu.action">戻る</a>
            </div>
        </section>
    </c:param>
</c:import>
