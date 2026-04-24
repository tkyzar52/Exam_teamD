<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目削除完了</h2>
            
            <div class="mx-3 mt-4">
                <p>科目情報の削除が完了しました。</p>
                <div class="mt-4">
                    <a href="SubjectList.action" class="btn btn-secondary">科目一覧へ戻る</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>