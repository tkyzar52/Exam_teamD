<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績一覧 (科目)</h2>
            
            <div class=""> 
             <div class="mb-4 px-2">
               
                <form action="TestList.action" method="get">
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
                        <div class="col-3">
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
                                   placeholder="学生番号を入力してください" maxlength="10" required>
                        </div>
                        <div class="col-2">
                            <button class="btn btn-secondary w-80" type="submit">検索</button>
                        </div>
		            	
                    </div>
                </form>
            </div>
            </div>
            
            <c:if test="${not empty student_map}">
			    <table class="table table-hover">
			     <div class="mb-4 ">
                <p>科目: ${subject.name}</p>
            	</div>
			        <thead>
			            <tr>
			                <th>入学年度</th>
			                <th>クラス</th>
			                <th>学生番号</th>
			                <th>氏名</th>
			                <th class="text-center">1回目</th>
			                <th class="text-center">2回目</th>
			            </tr>
			        </thead>
			        <tbody>
			            <c:forEach var="entry" items="${student_map}">
			                <c:set var="sNo" value="${entry.key}" />
			                <c:set var="student" value="${entry.value}" />
			                <tr>
			                    <td>${student.entYear}</td>
			                    <td>${student.classNum}</td>
			                    <td>${sNo}</td>
			                    <td>${student.name}</td>
			                    <td class="text-center">
			                        ${score_map[sNo]['1'] != null ? score_map[sNo]['1'] : '-'}
			                    </td>
			                    <td class="text-center">
			                        ${score_map[sNo]['2'] != null ? score_map[sNo]['2'] : '-'}
			                    </td>
			                </tr>
			            </c:forEach>
			        </tbody>
			    </table>
			</c:if>
			
			<c:if test="${empty student_map}">
			    <div class="text">
			        学生情報が存在しませんでした
			    </div>
			</c:if>
			
            <div class="mt-4 mx-3">
                <a href="TestList.action" class="btn btn-secondary">戻る</a>
            </div>
        </section>
    </c:param>
</c:import>