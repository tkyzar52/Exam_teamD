<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:import url="/common/base.jsp">

    <c:param name="title">得点管理システム</c:param>

    <c:param name="scripts"></c:param>

    <c:param name="content">

        <section class="me-4">

            <!-- タイトル -->
            <h2 class="h3 mb-4 fw-bold bg-secondary bg-opacity-10 py-2 px-3">
                学生情報変更
            </h2>

            <form method="post" action="StudentUpdateExecute.action">

                <div style="max-width: 700px; margin-left: 15px;">

                    <!-- 入学年度 -->
                    <div class="mb-3">

                        <label
                            class="form-label d-block mb-1"
                            for="ent_year">

                            入学年度

                        </label>

                        <select
                            class="form-control border-0 bg-transparent ps-0"
                            id="ent_year"
                            name="ent_year">

                            <c:forEach var="year" items="${ent_year_set}">

                                <option value="${year}"

                                    <c:if test="${year == student.entYear}">
                                        selected
                                    </c:if>>

                                    ${year}

                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <!-- 学生番号 -->
                    <div class="mb-3">

                        <label class="form-label d-block mb-1">

                            学生番号

                        </label>

                        <input
                            class="form-control border-0 bg-transparent ps-0"
                            type="text"
                            value="${student.no}"
                            readonly />

                        <input
                            type="hidden"
                            name="no"
                            value="${student.no}" />

                    </div>

                    <!-- 氏名 -->
                    <div class="mb-3">

                        <label
                            class="form-label d-block mb-1"
                            for="name">

                            氏名

                        </label>

                        <input
                            class="form-control"
                            type="text"
                            id="name"
                            name="name"
                            value="${student.name}"
                            maxlength="30"
                            placeholder="氏名を入力してください"  required/>

                      
                    </div>

                    <!-- クラス -->
                    <div class="mb-3">

                        <label
                            class="form-label d-block mb-1"
                            for="class_num">

                            クラス

                        </label>

                        <select
                            class="form-select"
                            id="class_num"
                            name="class_num">

                            <c:forEach var="num" items="${class_num_set}">

                                <option value="${num}"

                                    <c:if test="${num == student.classNum}">
                                        selected
                                    </c:if>>

                                    ${num}

                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <!-- 在学中 -->
                    <div class="mb-3">

                        <label
                            class="form-label me-2"
                            for="is_attend">

                            在学中

                        </label>

                        <input
                            class="form-check-input"
                            type="checkbox"
                            id="is_attend"
                            name="is_attend"
                            value="true"

                            <c:if test="${student.isAttend()}">
                                checked
                            </c:if> />

                    </div>

                    <!-- 変更ボタン -->
                    <div class="mb-2">

                        <button
                            type="submit"
                            class="btn btn-primary btn-sm">

                            変更

                        </button>

                    </div>

                    <!-- 戻る -->
                    <div>

                        <a href="StudentList.action">

                            戻る

                        </a>

                    </div>

                </div>

            </form>

            </script>

        </section>

    </c:param>

</c:import>