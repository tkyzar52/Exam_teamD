<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">科目情報削除</h2>
            
            <form action="SubjectDeleteExecute.action" method="post">
              <input type="hidden" name="cd" value="${subject.cd}">
                <div class="mx-3">
                    <p>
    						${subject.name}（${subject.cd}）を削除します。よろしいですか？
					</p>
                    
                   <%--  <div class="mb-3">
                        <label class="form-label">科目コード</label>
                        <input class="form-control-plaintext border-bottom" type="text" name="cd" value="${subject.cd}" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">科目名</label>
                        <input class="form-control-plaintext border-bottom" type="text" value="${subject.name}" readonly>
                    </div>--%>

                    <div class="mt-4">
                        <button class="btn btn-danger" type="submit">削除</button>
                    </div>
                </div>
            </form>

            <div class="mt-3 mx-3">
                <a href="SubjectList.action">戻る</a>
            </div>
        </section>
    </c:param>
</c:import>