<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績登録完了</h2>
            
            <div class="mx-3 mt-4">
                <p>成績情報の登録が完了しました。</p>
                
                <div class="mt-4">
                    <a href="TestRegist.action" class="btn btn-secondary me-2">戻る</a>
                    <a href="TestList.action" class="btn btn-outline-secondary">成績参照へ</a>
                </div>
            </div>
        </section>
    </c:param>
