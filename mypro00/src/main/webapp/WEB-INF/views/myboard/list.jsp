<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

		 <%@ include file="../myinclude/myheader.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">Board - List</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
			<div class="panel-heading">
				 <div class="row">
				 	<div class="col-md-6" style="font-size:20px; height: 45px; padding-top:10px;">게시글 목록</div>
				 		<div class="col-md-6" style="padding-top:8px;">
				 			<button type="button" id="btnMoveRegister" class="btn btn-primary btn-sm pull-right">게시글 등록</button>
				 </div>
				 </div>
			</div><!-- /.panel-heading -->
                        
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example" style="width:100%;text-align:center;" >
                                <thead>
                                    <tr>
                                         <th style="text-align:center;">번호</th>
			 							 <th style="text-align:center;">제목</th>
										 <th style="text-align:center;">작성자</th>
										 <th style="text-align:center;">작성일</th>
										 <th style="text-align:center;">수정일</th>
										 <th style="text-align:center;">조회수</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%-- 아래의 forEach 요소 전체 내용 추가 --%>
									<c:forEach items="${boardList}" var="board"><%-- 컨트롤러에서 보낸 목록객체 이름: boardList --%>
									   <c:if test="${board.bdelFlag == 1}">
									 		<tr style="background-color:Moccasin; text-align:center">
									 			<td><c:out value="${board.bno}" /></td>
									 			<td colspan="5"><em>작성자에 의하여 삭제된 게시글입니다.</em></td>
									 		</tr>
									 	</c:if>
									 	<c:if test="${board.bdelFlag == 0}">
									 		<tr class="moveDetail" data-bno='<c:out value="${board.bno}"/>' >
									 			<td><c:out value="${board.bno}" /></td>
									 			<td style="text-align:left;" >
									 				<a class='moveDetail' target="_self" href='<c:out value="${board.bno}" />'>
									 				<c:out value="${board.btitle}"/>
									 				</a>
									 			</td>
									 			<td><c:out value="${board.bwriter}" /></td>
									 			<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.bregDate}" /><br>
									 				<%-- ${board.bregDate} --%>
									 			</td>
									 			<td><fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.bmodDate}" /><br>
									 				<%-- ${board.bmodDate} --%>
									 			</td>
                                    			<td>${board.bviewsCnt}</td>
									 		</tr>
									 	</c:if>
									 </c:forEach>
                                </tbody>
                            </table>
                            <%-- Modal 모달 시작--%>
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							 	<div class="modal-dialog">
							 		<div class="modal-content">
							 			<div class="modal-header">
							 				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
							 				<h4 class="modal-title" id="myModalLabel">처리결과</h4>
										</div>
							 			<div class="modal-body">처리가 완료되었습니다.</div>
							 			<div class="modal-footer">
							 				<button type="button" class="btn btn-default" data-dismiss="modal">확인</button>
							 			</div>
							 		</div><%-- END .modal-content --%>
							 	</div><%-- END .modal-dialog --%>
							</div><%-- END .modal --%>
                            
                            <form id="frmSendValue"><%-- 전달할 hidden 유형의 input 요소들이 추가되어 값들이 전달될 비어있는 form --%>
							</form>
                           
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
         
           
        </div>
        <!-- /#page-wrapper -->
        
        <script>
		<%--//새글 등록 버튼 클릭 이벤트 처리: 게시물 등록 화면 이동////////////////////////////////// --%>
		$("#btnMoveRegister").on("click", function(){
			 self.location = "${contextPath}/myboard/register";
		})
		</script>
        
        
        <%--//게시물 행이나 제목 클릭 이벤트 처리: 게시물 상세 화면 이동//////////////////////////////// --%>
		<script>
		var frmSendValue = $("#frmSendValue");
		
		$(".moveDetail").on( "click", function(e) {
			e.preventDefault(); //<a> 태그 기능 방지
		 	frmSendValue.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'/>");
		 	
			frmSendValue.attr("action", "${contextPath}/myboard/detail");
		 	frmSendValue.attr("method", "get");
		 	
		 	frmSendValue.submit();
		});

		var result = '<c:out value="${result}"/>'; //컨트롤러가 전달한 result 값을 변수에 저장
		
		function checkModal(result) {
		 	if (result === ''|| history.state) {
				 return;
		 	} else if(result === 'successRemove'){
		 		var myMsg = "글이 삭제되었습니다";
		 	} else if (parseInt(result) > 0) {
		 		var myMsg = "게시글 " + parseInt(result) + " 번이 등록되었습니다.";
		 }
		 $(".modal-body").html(myMsg);
		 $("#myModal").modal("show");
		 myMsg='';
		}
		//checkModal(result);
		</script>
		<script>
		$(document).ready(function(){
		 	//모달 동작 후, 아래의 history.pushState() 동작과 popstate 이벤트 리스너에 의해 뒤로가기 방지됨.
		 	checkModal(result);
		 	//popstate 이벤트를 처리하는 자바스크립트 리스너 추가, popstate는 간단히 브라우저의 뒤로가기 버튼 클릭 이벤트 이름입니다.
		 	window.addEventListener('popstate', function(event) { 
		 	history.pushState(null, null, location.href); //뒤로가기 Block.
		 	})
		 	//페이지 로딩 시에, 실행되어 현재 목록페이지의 URL을 강제로 최근 URL로서 히스토리 객체에 다시 추가
		 	history.pushState(null, null, location.href);
		});
		</script>
        
        <%@ include file="../myinclude/myfooter.jsp" %>

    