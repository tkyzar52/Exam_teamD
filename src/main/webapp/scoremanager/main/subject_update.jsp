<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目情報変更</h2>
            
            <form action="SubjectUpdateExecute.action" method="post">
                <div class="mx-3">
                    <div class="mb-3">
                        <label class="form-label">科目コード</label>
                        <input class="form-control border-0 bg-transparent" type="text" name="cd" value="${subject.cd}" readonly >
                        
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="name">科目名</label>
                        <input class="form-control" type="text" id="name" name="name" 
                               value="${subject.name}" maxlength="20" required>
                    </div>

                    <div class="mt-4">
                        <button class="btn btn-primary" type="submit">変更</button>
                    </div>
                </div>
            </form>

            <div class="mt-3 mx-3">
                <a href="SubjectList.action">戻る</a>
            </div>
        </section>
    </c:param>
</c:import>