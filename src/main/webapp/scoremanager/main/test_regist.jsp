<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>
	<%--メイン --%>
    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績管理</h2>
            
            <form action="TestRegist.action" method="get">
                <div class="row border p-3 mx-1 mb-4 align-items-center">
                <%--入学年度 --%>
                    <div class="col-2">
                        <label class="form-label">入学年度</label>
                        <select class="form-select" name="f1">
                            <option value="0">--------</option>
                            <c:forEach var="year" items="${ent_year_set}">
                                <option value="${year}" <c:if test="${year == f1}">selected</c:if>>${year}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <%--クラス --%>
                    <div class="col-2">
                        <label class="form-label">クラス</label>
                        <select class="form-select" name="f2">
                            <option value="0">--------</option>
                            <c:forEach var="num" items="${class_num_set}">
                                <option value="${num}" <c:if test="${num == f2}">selected</c:if>>${num}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <%--科目 --%>
                    <div class="col-3">
                        <label class="form-label">科目</label>
                        <select class="form-select" name="f3">
                            <option value="0">--------</option>
                            <c:forEach var="subject" items="${subject_set}">
                                <option value="${subject.cd}" <c:if test="${subject.cd == f3}">selected</c:if>>${subject.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <%--回数 --%>
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
                        <button class="btn btn-secondary w-90" type="submit">検索</button>
                    </div>
                    
                  
                </div>
                <div class="mt-3">
                    <c:if test="${not empty errorMap['select']}">
					    <div style="color: orange; font-size: 0.85em;">
					        ${errorMap['select']}
					    </div>
					</c:if>
					</div>
                
            </form>
           

			<c:if test="${tests != null}">
	            <p class="mb-2">
				    科目：${subject.name}（${f4}回）
				</p>
                <form action="TestRegistExecute.action" method="post">
                    <input type="hidden" name="f1" value="${f1}">
					<input type="hidden" name="f2" value="${f2}">
					<input type="hidden" name="f3" value="${f3}">
					<input type="hidden" name="f4" value="${f4}">
                    <%-- テーブルで情報出す --%>
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
									    <input type="text" name="point_${test.student.no}" 
									           value="${test.point >= 0 ? test.point : ''}" 
									           class="form-control" style="width: 100px;">
									    <c:if test="${not empty errorMap[test.student.no]}">
									        <div style="color: orange; font-size: 0.85em;">
									            ${errorMap[test.student.no]}
									        </div>
									    </c:if>
									    <input type="hidden" name="student_no_set" value="${test.student.no}">
									</td>
					            </tr>
					        </c:forEach>
					    </tbody>
					</table>
                    <button class="btn btn-secondary mt-3" type="submit">登録して終了</button>
                </form>
            </c:if>
        </section>
    </c:param>
</c:import>