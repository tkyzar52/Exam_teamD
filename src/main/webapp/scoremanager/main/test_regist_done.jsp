<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績管理</h2>
            
	            <div class="mx-3 mt-4">
	                <p class="bg-success bg-opacity-25 p-2 text-center">登録が完了しました。</p>
	             <div class="mt-6">
                <br>
                <br>
                <div class="mt-6">
                    <a href="TestRegist.action" class="mt-3 mx-3">戻る</a>
                    <a href="TestList.action" class="mt-3 mx-3">成績参照</a>
                </div>
            </div>
        </section>
    </c:param>
</c:import>