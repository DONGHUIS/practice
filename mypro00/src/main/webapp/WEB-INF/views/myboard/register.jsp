<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

		 <%@ include file="../myinclude/myheader.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">Board - Register</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading"><h4>게시글 등록</h4></div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                             <%-- 아래의 form 요소 내용 추가 --%>
							 <form role="form" action="${contextPath}/myboard/register" method="post" name="frmBoard">
							 	<div class="form-group">
							 		<label>제목</label> <input class="form-control" name="btitle">
							 	</div>
								<div class="form-group">
							 		<label>내용</label> <textarea class="form-control" rows="3" name="bcontent"></textarea>
							 	</div>
								<div class="form-group">
							 		<label>작성자</label> <input class="form-control" name="bwriter">
							 	</div>
								<button type="submit" class="btn btn-primary">등록</button>
							 	<button type="button" class="btn btn-warning" data-oper="list"
							 			onclick="location.href='${contextPath}/myboard/list'">취소
							 	</button>
							 </form>
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            
        </div>
        <!-- /#page-wrapper -->
        
        <%@ include file="../myinclude/myfooter.jsp" %>

    