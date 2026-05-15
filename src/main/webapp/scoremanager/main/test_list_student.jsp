<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績一覧 (学生)</h2>
            
             <div class=""> 
             <div class="mb-4 px-2">
               
                <form action="TestListStudentExecute.action" method="get">
                    <input type="hidden" name="f" value="sj">
                    <div class="border rounded bg-white p-4 mb-4 shadow-sm">
                     <div class="row mb-3 align-items-center">
                        <div class="col-md-2">
                        	<label class="form-label">科目情報</label>
                        </div>
                        <div class="col-2">
                            <label class="form-label">入学年度</label>
                            <select class="form-select" name="f1" required>
                                <option value="">--------</option>
                                <c:forEach var="year" items="${ent_year_set}">
                                    <option value="${year}" <c:if test="${year == f1}">selected</c:if>>
							            ${year}
							        </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <label class="form-label">クラス</label>
                            <select class="form-select" name="f2" required>
                                <option value="">--------</option>
                                <c:forEach var="num" items="${class_num_set}">
                                    <option value="${num}" <c:if test="${num == f2}">selected</c:if>>
									    ${num}
									</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-4">
                            <label class="form-label">科目</label>
                            <select class="form-select" name="f3" required>
                                <option value="">--------</option>
                                <c:forEach var="subject" items="${subject_set}">
                                    <option value="${subject.cd}" <c:if test="${subject.cd == f3}">selected</c:if>>
									    ${subject.name}
									</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <button class="btn btn-secondary w-80" type="submit">検索</button>
                        </div>
                    </div>
                    
                    <hr class="my-4">

					<div class="row align-items-end">
                </form>
            </div>

            <div>
                
                <form action="TestList.action" method="get">
                    <input type="hidden" name="f" value="st"> 
                    <div class="row align-items-center">
                    	<div class="col-md-2">
                        	<label class="form-label">学生情報</label>
                        </div>
                        <div class="col-5">
                            <label class="form-label">学生番号</label>
                            <input type="text" name="f4" class="form-control" 
						       value="${f4}"
						       placeholder="学生番号を入力してください" maxlength="10" required>
                        </div>
                        <div class="col-2">
                            <button class="btn btn-secondary w-80" type="submit">検索</button>
                        </div>
		            	
                    </div>
                </form>
            </div>
            </div>
            
     		<%--学生別成績一覧 --%>
            <div class="mb-3">
			    <c:if test="${not empty student}">
			        <p>氏名: ${student.name} (${student.no})</p>
			    </c:if>
			</div>
			
			<c:if test="${not empty tests}">
			    <table class="table table-hover">
			        <thead>
			            <tr>
			                <th>科目名</th>
			                <th>科目コード</th>
			                <th>回数</th>
			                <th>点数</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach var="test" items="${tests}">
			                <tr>
			                    <td>${test.subject.name}</td>
			                    <td>${test.subject.cd}</td>
			                    <td>${test.no}</td>
			                    <td>${test.point}</td>
			                </tr>
			            </c:forEach>
			        </tbody>
			    </table>
			</c:if>
			<%--情報ない場合 --%>
			<c:if test="${empty tests && not empty param.f4}">
			    <div class="text">
			        成績情報が存在しませんでした
			    </div>
			</c:if>
            <div class="mt-4 mx-3">
                <a href="TestList.action" class="btn btn-secondary">戻る</a>
            </div>
        </section>
    </c:param>
</c:import>