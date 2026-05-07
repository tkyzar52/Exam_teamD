<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">
            <h2 class="h3 mb-3 fw-norma bg-secondary bg-opacity-10 py-2 px-4">成績参照</h2>
            
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
                            <select class="form-select" name="f1" >
                                <option value="0">--------</option>
                                <c:forEach var="year" items="${ent_year_set}">
                                    <option value="${year}">${year}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-2">
                            <label class="form-label">クラス</label>
                            <select class="form-select" name="f2" >
                                <option value="0">--------</option>
                                <c:forEach var="num" items="${class_num_set}">
                                    <option value="${num}">${num}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="col-4">
                            <label class="form-label">科目</label>
                            <select class="form-select" name="f3" >
                                <option value="0">--------</option>
                                <c:forEach var="subject" items="${subject_set}">
                                    <option value="${subject.cd}">${subject.name}</option>
                                </c:forEach>
                            </select>
                      
                        </div>
                        
                        <div class="col-2">
                            <button class="btn btn-secondary w-80" type="submit">検索</button>
                        </div>
                    </div>
                    
                    <c:if test="${not empty errorMessage}">
					    <div class="text-warning mt-2">
					        ${errorMessage}
					    </div>
					</c:if>
							
                    <hr class="my-2">

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
            
        </section>
        
        <div class="small fw-bold" style="color:#0aa2c0;">
		      科目情報を選択または学生情報を入力して検索ボタンをクリックしてください
		</div>
		    
    </c:param>
</c:import>