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
                        
                        <%-- 전달할 hidden 유형의 input 요소들이 추가되어 값들이 전달될 비어있는 form --%>
						<%-- 목록 화면에서 페이징 화면 이동 시, 페이징 데이터 전달을 위해 사용됨 --%>
						<%-- 표시 행수/검색유형/검색어 입력 form 시작 --%>
						<form class="form-inline" id="frmSendValue" action="${contextPath}/myboard/list" method="get" name="frmSendValue">
						 	<div class="form-group">
						 		<label class="sr-only">frmSendValues</label>
						 		<select class="form-control" id="selectAmount" name="rowAmountPerPage"><!-- 표시 게시물 수 선택 -->
						 			<option value="10" <c:out value="${pagingCreator.myBoardPagingDTO.rowAmountPerPage eq '10'
						 											 ? 'selected' : ''}" /> >10개</option>
						 			<option value="20" <c:out value="${pagingCreator.myBoardPagingDTO.rowAmountPerPage eq '20'
						 											 ? 'selected' : ''}" /> >20개</option>
						 			<option value="50" <c:out value="${pagingCreator.myBoardPagingDTO.rowAmountPerPage eq '50'
						 											 ? 'selected' : ''}" /> >50개</option>
						 			<option value="100" <c:out value="${pagingCreator.myBoardPagingDTO.rowAmountPerPage eq '100'
						 											 ? 'selected' : ''}" /> >100개</option>
						 		</select>
						 
						 		<select class="form-control" id="selectScope" name="scope"><!-- 검색 범위 선택 -->
						 			<option value="" <c:out value="${pagingCreator.myBoardPagingDTO.scope == null
						 											 ? 'selected':''}" /> >검색범위</option>
						 			<option value="T" <c:out value="${pagingCreator.myBoardPagingDTO.scope eq 'T'
						 											? 'selected' : ''}" /> >제목</option>
						 			<option value="C" <c:out value="${pagingCreator.myBoardPagingDTO.scope eq 'C'
						 											? 'selected' : ''}" /> >내용</option>
						 			<option value="W" <c:out value="${pagingCreator.myBoardPagingDTO.scope eq 'W'
						 											? 'selected' : ''}" /> >작성자</option>
						 			<option value="TC" <c:out value="${pagingCreator.myBoardPagingDTO.scope eq 'TC'
						 											? 'selected' : ''}" /> >제목 + 내용</option>
						 			<option value="TW" <c:out value="${pagingCreator.myBoardPagingDTO.scope eq 'TW'
						               								 ? 'selected' : ''}" /> >제목 + 작성자</option>
						 			<option value="TCW" <c:out value="${pagingCreator.myBoardPagingDTO.scope eq 'TCW'
						 											  ? 'selected' : ''}" /> >제목 + 내용 + 작성자</option>
						 		</select>
						 
						 <div class="input-group"><!-- 검색어 입력 -->
						 	<input class="form-control" id="inputKeyword" name="keyword" type="text" placeholder="검색어를 입력하세요"
						 		   value='<c:out value="${pagingCreator.myBoardPagingDTO.keyword}" />' />
						 	<span class="input-group-btn"><!-- 전송버튼 -->
						 		<button class="btn btn-info" type="button" id="btnSearchGo">
						 			검색 &nbsp;<i class="fa fa-search"></i>
						 		</button>
						 	</span>
						 </div>
						 
						 <div class="input-group"><!-- 검색 초기화 버튼 -->
						 	<button id="btnReset" class="btn btn-warning" type="reset">검색초기화</button>
						 </div>
						</div><%-- /.form-group --%>
						 
								<input type='hidden' name='pageNum' value='${pagingCreator.myBoardPagingDTO.pageNum}'> 
								<input type='hidden' name='rowAmountPerPage' value='${pagingCreator.myBoardPagingDTO.rowAmountPerPage}'>
								<input type='hidden' name='lastPageNum' value='${pagingCreator.lastPageNum}'>
							</form><%-- END 검색범위 및 검색어 입력 폼 --%>
							<br>
                        
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
                            <%-- Pagination 시작 --%>
							<div class='pull-right'>
							 	<ul class="pagination pagination-sm">
							 	<%-- 페이징 버튼 클릭 시, jQuery로 페이지 번호를 전달하도록 a 태그에 전달된 pagingCreator 객체의 필드 지정 --%>
							 		<c:if test="${pagingCreator.prev}">
							 			<li class="paginate_button previous">
							 				<a href="1">&laquo;</a><%-- 맨 앞으로 페이지로 이동 --%>
							 			</li>
							 		</c:if>
							 		<c:if test="${pagingCreator.prev}">
							 			<li class="paginate_button previous">
							 				<a href="${pagingCreator.startPagingNum - 1}">이전</a><%-- 이전 페이징 그룹 끝 페이지로 이동 --%>
							 			</li>
							 		</c:if>
							 		<%-- 페이징 그룹의 페이징 숫자(10개 표시) --%>
							 		<c:forEach var="pageNum" begin="${pagingCreator.startPagingNum}" end="${pagingCreator.endPagingNum}">
							 		<%-- 선택된 숫자의 경우, Bootstrap의 active 클래스 이름 추가 --%>
							 			<li class='paginate_button ${pagingCreator.myBoardPagingDTO.pageNum == pageNum ? "active":"" }'>
							 				<a href="${pageNum}">${pageNum}</a>
							 			</li>
							 		</c:forEach>
							 		<c:if test="${pagingCreator.next}">
							 			<li class="paginate_button next">
							 				<a href="${pagingCreator.endPagingNum +1}">다음</a><%-- 다음 페이징 그룹의 첫 페이지로 이동 --%>
							 			</li>
							 		</c:if>
							 		<c:if test="${pagingCreator.next}">
							 			<li class="paginate_button next">
							 				<a href="${pagingCreator.lastPageNum}">&raquo;</a><%-- 맨 마지막으로 페이지로 이동 --%>
							 			</li>
							 		</c:if>
							 	</ul>
							</div><%-- Pagination 끝 --%>
                            
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
		
		$(document).ready(function() {
			
			<%-- 페이징 화면 이동(페이징 버튼 클릭 이벤트 처리): 폼에 저장된 페이지번호를 클릭한 페이지번호로 변경한 후, 전송 --%>
			$(".paginate_button a").on( "click", function(e) {
				 e.preventDefault(); <%--a 태그의 클릭 시 동작 막음 --%>
				 <%--폼에 저장된 현재 화면의 페이지번호를 클릭한 페이징 버튼의 페이지번호로 변경 --%>
				 frmSendValue.find("input[name='pageNum']").val($(this).attr("href"));
				 //alert(frmSendValue.find("input[name='pageNum']").val());
				 frmSendValue.attr("action", "${contextPath}/myboard/list");
				 frmSendValue.attr("method", "get");
				 frmSendValue.submit();
			});
			
			
			<%--검색 관련 요소의 이벤트 처리--%>
			<%--표시행수 변경 이벤트 처리--%>
			$("#selectAmount").on("change", function(){
				 frmSendValue.find("input[name='pageNum']").val(1);
				 frmSendValue.attr("action", "${contextPath}/myboard/list");
				 frmSendValue.attr("method", "get");
				 frmSendValue.submit();
			});
			
			<%--검색버튼 클릭 이벤트 처리 --%>
			$("#btnSearchGo").on("click", function(e) {
			 if (!$("#selectScope").find("option:selected").val()) {
			 	alert("검색범위를 선택하세요");
			 	return false;
			 }
			 
			 //if (!frmSendValue.find("input[name='keyword']").val()) {
			 if (!frmSendValue.find("input[name='keyword']").val()) {
			 	alert("검색어를 입력하세요");
			 	return false;
			 }
			 
			 frmSendValue.find("input[name='pageNum']").val("1");
			 frmSendValue.submit();
			});
			 
			<%--검색초기화 버튼 이벤트처리, 버튼 초기화 시, 1페이지에 목록 정보 다시 표시 --%>
			$("#btnReset").on("click", function(){
			 	$("#selectAmount").val(10);
			 	$("#selectScope").val("");
			 	$("#inputKeyword").val("") ;
			 	$("#hiddenPageNum").val(1);
			 	$("#hiddenLastPageNum").val("");
			 	
			 	frmSendValue.submit();
			});
			
			 checkModal(result);
			 window.addEventListener('popstate', function(event) { 
			 	history.pushState(null, null, location.href); //뒤로가기 Block.
			 })
			 history.pushState(null, null, location.href);
		})
		
		
		</script>
        
        <%@ include file="../myinclude/myfooter.jsp" %>

    