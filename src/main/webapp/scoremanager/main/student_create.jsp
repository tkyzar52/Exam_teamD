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

            <form method="post" action="StudentCreateExecute.action">

                <div style="max-width: 700px;">

                    <!-- 入学年度 -->
                    <div class="">
                        <label for="ent_year" class="col-sm-2 col-form-label">
                            入学年度
                        </label>
                  

                        <div class="col-sm-10">
                            <select class="form-select " id="ent_year" name="ent_year">
                                <option value="">--------</option>

                                <c:forEach var="year" items="${ent_year_set}">
                                    <option value="${year}"
                                        <c:if test="${year == ent_year}">selected</c:if>>
                                        ${year}
                                    </option>
                                </c:forEach>
                            </select>

                            <c:if test="${not empty errors.get('ent_year')}">
							    <div class="form-text" style="color: orange;">
							        ${errors.get("ent_year")}
							    </div>
							</c:if>
                        </div>
                    </div>

                    <!-- 学生番号 -->
                    <div class="">
                        <label for="no" class="col-sm-2 col-form-label">
                            学生番号
                        </label>

                        <div class="col-sm-10">
                            <input
                                type="text"
                                class="form-control"
                                id="no"
                                name="no"
                                value="${no}"
                                placeholder="学生番号を入力してください"
                                maxlength="10" required
                            />

                             <c:if test="${not empty errors.get('no')}">
							    <div class="form-text" style="color: orange;">
							        ${errors.get("no")}
							    </div>
							</c:if>
                        </div>
                    </div>

                    <!-- 氏名 -->
                    <div class="">
                        <label for="name" class="col-sm-2 col-form-label">
                            氏名
                        </label>

                        <div class="col-sm-10">
                            <input
                                type="text"
                                class="form-control"
                                id="name"
                                name="name"
                                value="${name}"
                                placeholder="氏名を入力してください"
                                maxlength="30" required
                            />

                        </div>
                    </div>

                    <!-- クラス -->
                    <div class="mx-auto py-2">
                        <label for="class_num" class="col-sm-2 col-form-label">
                            クラス
                        </label>

                        <div class="col-sm-10">
                            <select class="form-select" id="class_num" name="class_num">

                                <c:forEach var="num" items="${class_num_set}">
                                    <option value="${num}"
                                        <c:if test="${num == class_num}">selected</c:if>>
                                        ${num}
                                    </option>
                                </c:forEach>

                            </select>

                            
                        </div>
                    </div>

                    <!-- ボタン -->
                    <div class="mx-auto py-2">
                        <button type="submit" class="btn btn-secondary">
                            登録して終了
                        </button>
                    </div>

                    <!-- 戻る -->
                    <div>
                        <a href="StudentList.action">戻る</a>
                    </div>

                </div>

            </form>

        </section>
    </c:param>
</c:import>