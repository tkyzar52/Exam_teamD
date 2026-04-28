<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績管理</h2>
            
            <form action="TestRegist.action" method="get">
                <div class="row border p-3 mx-1 mb-4 align-items-end">
                    <div class="col-2">
                        <label class="form-label">入学年度</label>
                        <select class="form-select" name="f1">
                            <option value="0">--------</option>
                            <c:forEach var="year" items="${ent_year_set}">
                                <option value="${year}" <c:if test="${year == f1}">selected</c:if>>${year}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-2">
                        <label class="form-label">クラス</label>
                        <select class="form-select" name="f2">
                            <option value="0">--------</option>
                            <c:forEach var="num" items="${class_num_set}">
                                <option value="${num}" <c:if test="${num == f2}">selected</c:if>>${num}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-3">
                        <label class="form-label">科目</label>
                        <select class="form-select" name="f3">
                            <option value="0">--------</option>
                            <c:forEach var="subject" items="${subject_set}">
                                <option value="${subject.cd}" <c:if test="${subject.cd == f3}">selected</c:if>>${subject.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-2">
                        <label class="form-label">回数</label>
                        <select class="form-select" name="f4">
                            <option value="0">--------</option>
                            <c:forEach var="no" items="${test_no_set}">
                                <option value="${no}" <c:if test="${no == f4}">selected</c:if>>${no}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-3">
                        <button class="btn btn-secondary w-100" type="submit">検索</button>
                    </div>
                </div>
            </form>

            <c:if test="${tests != null}">
                <form action="TestRegistExecute.action" method="post">
                    <input type="hidden" name="subject_cd" value="${f3}">
                    <input type="hidden" name="test_no" value="${f4}">
                    
                    <table class="table table-hover">
					    <thead>
					        <tr>
					            <th>入学年度</th>
					            <th>クラス</th>
					            <th>学生番号</th>
					            <th>氏名</th>
					            <th>点数</th>
					        </tr>
					    </thead>
					    <tbody>
					        <c:forEach var="test" items="${tests}">
					            <tr>
					                <td>${test.student.entYear}</td>
					                <td>${test.student.classNum}</td>
					                <td>${test.student.no}</td>
					                <td>${test.student.name}</td>
					                <td>
					                    <input type="number" name="point_${test.student.no}" 
					                           value="${test.point >= 0 ? test.point : ''}" 
					                           class="form-control" min="0" max="100" style="width: 100px;">
					                    <input type="hidden" name="student_no_set" value="${test.student.no}">
					                </td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
                    <button class="btn btn-primary mt-3" type="submit">登録して終了</button>
                </form>
            </c:if>
        </section>
    </c:param>
</c:import>