<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">

    <c:param name="title">CSV学生登録</c:param>

    <c:param name="content">

        <section class="me-4">

            <h2 class="h3 mb-4 fw-bold bg-secondary bg-opacity-10 py-2 px-3">CSV学生登録</h2>

            <form action="StudentCsvCreateExecute.action"
                  method="post"
                  enctype="multipart/form-data">

                <div class="mb-3">

                    <label class="form-label">CSVファイル</label>

                    <input type="file"
                           name="csv_file"
                           class="form-control"
                           accept=".csv">

                </div>

                <button type="submit"
                        class="btn btn-primary">

                    CSV登録

                </button>

                <a href="StudentCreate.action"
                   class="btn btn-secondary">

                    戻る

                </a>

            </form>

        </section>

    </c:param>

</c:import>