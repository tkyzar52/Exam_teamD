<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目情報登録</h2>
            
            <form action="SubjectCreateExecute.action" method="post">
                <div class="mx-3">
                    <div class="mb-3">
                        <label class="form-label" for="cd">科目コード</label>
                        <input class="form-control" type="text" id="cd" name="cd" 
                               placeholder="科目コードを入力してください" maxlength="3" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label" for="name">科目名</label>
                        <input class="form-control" type="text" id="name" name="name" 
                               placeholder="科目名を入力してください" maxlength="20" required>
                    </div>

                    <div class="mt-4">
                        <button class="btn btn-secondary" type="submit">登録して終了</button>
                    </div>
                </div>
            </form>

            <div class="mt-3 mx-3">
                <a href="SubjectList.action">戻る</a>
            </div>
        </section>
    </c:param>
</c:import>

// コミット