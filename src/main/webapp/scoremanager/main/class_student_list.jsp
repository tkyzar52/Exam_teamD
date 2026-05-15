<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:import url="/common/base.jsp">
    <c:param name="title">得点管理システム</c:param>

    <c:param name="content">
        <section class="me-4">

            <!-- タイトル -->
            <h2 class="h3 mb-3 fw-normal bg-secondary bg-opacity-10 py-2 px-4">
                クラス管理
            </h2>

            <!-- 検索フォーム -->
            <div class="mb-4 px-2">
                <form action="ClassList.action" method="get">
                    <input type="hidden" name="f" value="sj">
                    <input type="hidden" name="search" value="true">

                    <div class="border rounded bg-white p-4 mb-4 shadow-sm">
                        <div class="row mb-3 align-items-end">

			    <!-- 入学年度 -->
			    <div class="col-2">
			        <label class="form-label">入学年度</label>
			        <select class="form-select" name="f1">
			            <option value="0">--------</option>
			            <c:forEach var="year" items="${ent_year_set}">
			                <option value="${year}"
			                    <c:if test="${year == f1}">selected</c:if>>
			                    ${year}
			                </option>
			            </c:forEach>
			        </select>
			    </div>
			
			    <!-- クラス -->
			    <div class="col-2">
			        <label class="form-label">クラス</label>
			        <select class="form-select" name="f2">
			            <option value="0">--------</option>
			            <c:forEach var="num" items="${class_num_set}">
			                <option value="${num}"
			                    <c:if test="${num == f2}">selected</c:if>>
			                    ${num}
			                </option>
			            </c:forEach>
			        </select>
			    </div> 
			
			    <!-- 在学チェック -->
			    <div class="col-2">
			        <label class="form-check-label">
			            <input type="checkbox" name="f3" class="form-check-input"
			                <c:if test="${f3}">checked</c:if>>
			            在学中
			        </label>
			    </div>
			
			    <!-- ボタン -->
			    <div class="col-2">
			        <button class="btn btn-secondary w-100" type="submit">
			            検索
			        </button>
			    </div>
				
			</div>
			
			
            <!-- エラーメッセージ -->
            <c:if test="${not empty errors}">
                <div style="color: orange; font-size: 0.85em;">
                    <c:forEach var="e" items="${errors}">
                        <div>${e.value}</div>
                    </c:forEach>
                </div>
            </c:if>
            </div>
            <div class="small fw-bold" style="color:#0aa2c0;">
		      		入学年度を選択またはクラスを入力して検索ボタンをクリックしてください
			</div>
            </form>
            </div>
            
 

            <!-- 学生一覧テーブル -->
            <c:if test="${not empty param.search && empty errors}">
            <div class ="searched">
            <div>
	            <div class="mx-3">
				    <p>
				        入学年度：${f1}　
				        クラス：${f2}
				    </p>
				</div>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>学生番号</th>
                            <th>学生名</th>
                           <%-- <th>入学年度</th>
                             <th>クラス</th> --%>
                            <th>在籍状態</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="student" items="${students}">
                            <tr>
                                <td>${student.no}</td>
                                <td>${student.name}</td>
                                <!-- <td>${student.entYear}</td>-->
                                <!--  <td>${student.classNum}</td> -->
                                <td>
                                    <c:choose>
                                        <c:when test="${student.attend}">
                                            在学中
                                        </c:when>
                                        <c:otherwise>
                                            退学
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                        <!-- データがない場合 -->
                        <c:if test="${empty students}">
                            <tr>
                                <td colspan="4" class="text-danger text-center">
                                    データがありません
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            </div>
            </c:if>

        </section>
    </c:param>
</c:import>