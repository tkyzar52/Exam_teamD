<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績参照</h2>
            
            <div class="mb-5">
                <p class="fw-bold border-bottom pb-2">科目情報から探す</p>
                <form action="TestList.action" method="get">
                    <input type="hidden" name="f" value="sj">
                    <div class="row align-items-end">
                        <div class="col-3">
                            <label class="form-label">入学年度</label>
                            <select class="form-select" name="f1" required>
                                <option value="">--------</option>
                                <c:forEach var="year" items="${ent_year_set}">
                                    <option value="${year}">${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-3">
                            <label class="form-label">クラス</label>
                            <select class="form-select" name="f2" required>
                                <option value="">--------</option>
                                <c:forEach var="num" items="${class_num_set}">
                                    <option value="${num}">${num}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-4">
                            <label class="form-label">科目</label>
                            <select class="form-select" name="f3" required>
                                <option value="">--------</option>
                                <c:forEach var="subject" items="${subject_set}">
                                    <option value="${subject.cd}">${subject.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <button class="btn btn-secondary w-100" type="submit">表示</button>
                        </div>
                    </div>
                </form>
            </div>

            <div>
                <p class="fw-bold border-bottom pb-2">学生情報から探す</p>
                <form action="TestList.action" method="get">
                    <input type="hidden" name="f" value="st">
                    <div class="row align-items-end">
                        <div class="col-10">
                            <label class="form-label">学生番号</label>
                            <input type="text" name="f4" class="form-control" 
                                   placeholder="学生番号を入力してください" maxlength="10" required>
                        </div>
                        <div class="col-2">
                            <button class="btn btn-secondary w-100" type="submit">表示</button>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </c:param>
</c:import>