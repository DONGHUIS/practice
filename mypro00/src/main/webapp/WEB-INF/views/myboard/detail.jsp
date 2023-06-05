<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

		 <%@ include file="../myinclude/myheader.jsp" %>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header"
                    	style="white-space: nowrap;" > <c:out value="${board.bno}"/>번 게시물 </h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        	<div class="row">
								 <div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:11px;">
								 	<strong style="font-size:18px;">${board.bwriter}님 작성</strong>
								 </div>
								<div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
								 	<span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
								 		<span>
								 			<span>등록일:&nbsp;</span>
											<strong><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" 
								 									value="${board.bregDate}"/></strong>
								 			<span>&nbsp;&nbsp;</span>
								 		</span>
										<span>조회수:&nbsp;<strong><c:out value="${board.bviewsCnt}"/></strong></span>
								 	</span>
								 </div>
								<div class="col-md-6" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
								 	<div class="button-group pull-right">
								 		<button type="button" id="btnToModify" data-oper="modify" 
								 				class="btn btn-primary"><span>수정</span></button>
										 <button type="button" id="btnToList" data-oper="list"
										 		class="btn btn-info"><span>목록</span></button>
								 	</div>
								 </div>
							</div>
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body form-horizontal">
                             
                             <%-- 아래의 내용 전체 추가 --%>
							 <div class="form-group">
							 	<label class="col-sm-2 control-label" style="white-space: nowrap;">글제목</label>
							 	<div class="col-sm-10">
							 		<input class="form-control" name="btitle" value='<c:out value="${board.btitle}"/>'
							 			   readonly="readonly"/>
							 	</div>
							 </div>
							 <div class="form-group">
							 	<label  class="col-sm-2 control-label" style="white-space: nowrap;">글내용</label>
							 <%-- <textarea>와 </textarea>는 사이에 공백이 없어야 데이터베이스 저장 시에 필요 없는 공백이 포함되지 않음 --%>
							 <div class="col-sm-10">
							 	<textarea class="form-control" rows="3" name="bcontent" style="resize: none;"
							 			  readonly="readonly"><c:out value="${board.bcontent}"/></textarea>
							 </div>
							 </div>
							 
							 
							 <div class="form-group">
							 	<label class="col-sm-2 control-label" style="white-space: nowrap;">최종수정일</label>
							 	<div class="col-sm-10">
								 	<input class="form-control" name="bmodDate"
								 		   value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${board.bmodDate}"/>'
								 		   readonly="readonly" />
								</div>
							 </div>
							 
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            
        
        
        <form id="frmSendValue">
			 <input type='hidden' name='bno' id="bno" value='<c:out value="${board.bno}"/>'>
			 <input type='hidden' name='pageNum' value='${myBoardPagingDTO.pageNum}'>
			 <input type='hidden' name='rowAmountPerPage' value='${myBoardPagingDTO.rowAmountPerPage}'>
			 <input type='hidden' name='scope' value='${myBoardPagingDTO.scope}'>
			 <input type='hidden' name='keyword' value='${myBoardPagingDTO.keyword}'>
		</form>
		<%-- 게시물 상세 표시 끝 --%>
		
		<%-- 댓글 화면 표시 시작, 붙여넣기 후, 아래의 style 태그 내용은 <div id="page-wrapper"> 태그 위에 옮겨놓을 것 --%>
        <style>
		.txtBoxCmt, .txtBoxComment {
		 overflow: hidden; resize: vertical; min-height: 100px; color: black;
		}
		</style>
		
		<div class="row">
	 		<div class="col-lg-12">
	 			<div class="panel panel-default" >
	 				<div class="panel-heading">
 						<p style="margin-bottom: 0px; font-size: 16px;">
 							<strong style="padding-top: 2px;">
 								<span>댓글&nbsp;<c:out value="${board.breplyCnt}"/>개</span> 
 								<span>&nbsp;</span>
								<button type="button" id="btnChgCmtReg" class="btn btn-info btn-sm">댓글 작성</button>
								<button type="button" id="btnRegCmt" class="btn btn-warning btn-sm"
								 		style="display:none">댓글 등록</button>
								 <button type="button" id="btnCancelRegCmt" class="btn btn-warning btn-sm"
										 style="display:none">취소</button>
 							</strong>
 						</p>
 					</div> <%-- /.panel-heading --%>
 			<div class="panel-body">
			<%-- 댓글 입력창 div 시작 --%>
 			<div class="form-group" style="margin-bottom: 5px;">
 				<textarea class="form-control txtBoxCmt" name="rcontent"
 						  placeholder="댓글작성을 원하시면,&#10;댓글 작성 버튼을 클릭해주세요."
 						  readonly="readonly"
 				></textarea>
 			</div>
 			<hr style="margin-top: 10px; margin-bottom: 10px;">
<%-- 댓글 입력창 div 끝 --%>
 			<ul class="chat">
 			<%-- 댓글 목록 표시 영역 - JavaScript 로 내용이 생성되어 표시됩니다.--%>
 			</ul><%-- /.chat --%>
 		</div><%-- /.panel-body --%>
 
 		<div class="panel-footer text-center" id="showCmtPagingNums">
 			<%-- 댓글 목록의 페이징 번호 표시 영역 - JavaScript 로 내용이 생성되어 표시됩니다.--%>
 		</div>
 	</div><%-- /.panel --%>
  </div><%-- .col-lg-12 --%>
</div><%-- .row : 댓글 화면 표시 끝 --%>

<!-- 댓글 목록 표시 영역 시작 -->
<ul class="chat">
 	<li class="left clearfix commentLi" data-bno="123456" data-rno="12">
 		<div>
 			<div>
 				<span class="header info-rwriter">
					 <strong class="primary-font">user00</strong>
					 <span>&nbsp;</span>
					 <small class="text-muted">2018-01-01 13:13</small>
 				</span>
 				<p>앞으로 사용할 댓글 표시 기본 템플릿입니다.</p>
 			</div>
			 <div class="btnsComment" style="margin-bottom:10px">
			 	<button type="button" style="display:in-block"
			 			class="btn btn-primary btn-xs btnChgReg">답글 작성</button>
				 <button type="button" style="display:none" 
				 		class="btn btn-warning btn-xs btnRegCmt">답글 등록</button>
 				 <hr class="txtBoxCmtHr" style="margin-top:10px; margin-bottom:10px">
 				 <textarea class="form-control txtBoxCmtMod" name="rcontent" style="margin-bottom:10px"
 						   placeholder="답글작성을 원하시면,&#10;답글 작성 버튼을 클릭해주세요."
 				></textarea>
 		</div>
 	</div>
  </li>
</ul><%-- /.chat --%>

		<%-- 댓글 페이징 데이터 저장 form --%>
		<form id="frmCmtPagingValue">
			 <input type='hidden' name='pageNum' value='' />
			 <input type='hidden' name='rowAmountPerPage' value='' />
		</form>
		
		</div>
       	<!-- /#page-wrapper -->
        
        
        <script>
		
        var frmSendValue = $("#frmSendValue");
        
        //게시물 수정 페이지로 이동
		$("#btnToModify").on("click", function(){
			//location.href='${contextPath}/myboard/modify?bno=<c:out value="${board.bno}"/>'; 주석처리
			 frmSendValue.attr("action", "${contextPath}/myboard/modify");
			 frmSendValue.attr("method", "get");
			 frmSendValue.submit();
		})
		
		//게시물 목록 페이지로 이동
		$("#btnToList").on("click", function(){
		 	//location.href="${contextPath}/myboard/list";
		 	frmSendValue.find("#bno").remove();// 목록화면 이동 시, bno 값 삭제
		 	frmSendValue.attr("action", "${contextPath}/myboard/list");
		 	frmSendValue.attr("method", "get");
		 	frmSendValue.submit();
		})
		
		var result = '<c:out value="${result}"/>';
		
		function checkModifyOperation(result) {
		 	if (result === ''|| history.state) {
		 		return;
		 	} else if (result === 'successModify'){
		 		var myMsg = "글이 수정되었습니다";
		 }
		 
		 alert(myMsg);
		 myMsg='';
		}
		$(document).ready(function(){
		 checkModifyOperation(result);
		});
		</script>
		
		<script type="text/javascript" src="${contextPath}/resources/js/mycomment.js"></script>
		
		
		<script>
		//게시물 번호 저장
		var bnoValue = '<c:out value="${board.bno}"/>';
		var commentUL = $(".chat");
		var frmCmtPagingValue = $("#frmCmtPagingValue");
		
		//댓글 목록표시 함수 선언: ajax 클로저 모듈 함수를 호출함
		function showCmtList(page){
			//댓글 목록 데이터를 요청하는 클로저 모듈 함수 호출
			myCommentClsr.getCmtList(
			 	{bno: bnoValue, page: page || 1 },
			 	function(replyPagingCreator) { //ajax에서 실행할 callback 함수
			 		console.log("서버로부터 전달된 pageNum(replyPagingCreator.myRelyPaging.pageNum): "
			 					+ replyPagingCreator.myReplyPaging.pageNum);
			 
			 	frmCmtPagingValue.find("input[name='pageNum']")
			 					.val(replyPagingCreator.myReplyPaging.pageNum);
			 
			 
			 	console.log("폼에 저장된 페이징번호 pageNum(): "
			 			+ frmCmtPagingValue.find("input[name='pageNum']").val());
			 
			 	var str="";
			 
			 	//댓글이 없으면, if 문의 블록이 실행되고, 함수 실행이 중지됨(return), 따라서, for문 실행 않됨
			 	if( (! replyPagingCreator.replyList) || (replyPagingCreator.replyList.length == 0) ){
			 		str += '<li class="left clearfix commentLi" '
			 			+ ' style="text-align: center; background-color: lightCyan;'
			 			+ ' height: 35px;margin-bottom: 0px;padding-bottom:0px;'
			 			+ ' padding-top:6px;border: 1px dotted;">'
			 			+ ' <strong>등록된 댓글이 없습니다.</strong></li>';
			 		commentUL.html(str);
			 		return;
			}

			 	//답글 표시 for문(<ul></ul>내에 아래의 li 요소들이 for문에 의해서 생성되어 표시됨)
			 	for (var i = 0, len = replyPagingCreator.replyList.length; i < len; i++) {
					 	 str +='<li class="left clearfix commentLi" data-bno="' + bnoValue
					 	 + '" data-rno="'+replyPagingCreator.replyList[i].rno+'">'
					 	 + ' <div>';
				
				//댓글에 대한 답글 들여쓰기
	     	 	if(replyPagingCreator.replyList[i].lvl == 1){//댓글 들여쓰기 안함
					 str +=' <div>';
				} else if (replyPagingCreator.replyList[i].lvl == 2){//답글 들여쓰기
					 str +=' <div style="padding-left:25px">';
				} else if (replyPagingCreator.replyList[i].lvl == 3){//답글의 답글 들여쓰기
					 str +=' <div style="padding-left:50px">';
				} else if (replyPagingCreator.replyList[i].lvl == 4){//답글의 답글 들여쓰기
					 str +=' <div style="padding-left:75px">';
				} else {//답글의 레벨이 5이상이면 동일한 들여쓰기
					 str +=' <div style="padding-left:100px">';
				} 
					 str +=' <span class="header info-rwriter">'
					 	 + ' <strong class="primary-font">';
				if(replyPagingCreator.replyList[i].lvl > 1){//답글인 경우, 앞에 아이콘 표시
					str +=' <i class="fa fa-reply fa-fw"></i>&nbsp;';
				}
					 str += replyPagingCreator.replyList[i].rwriter 
					 	 + ' </strong>'
					 	 + ' <span>&nbsp;</span>'
					 	 + ' <small class="text-muted">'
					 	 + replyPagingCreator.replyList[i].rmodDate //수정날짜가 정수값으로 표시됨
					 	 + ' </small>';
				if(replyPagingCreator.replyList[i].lvl > 1){ //답글인 경우, 답글을 표시
					 str +=' <small>&nbsp; 답글</small>';
				}
					 str +=' </span>'
					 	 + ' <p data-bno=' + replyPagingCreator.replyList[i].bno
					 	 + ' data-rno=' + replyPagingCreator.replyList[i].rno
					 	 + ' data-rwriter=' + replyPagingCreator.replyList[i].rwriter
					 	 + ' >' + replyPagingCreator.replyList[i].rcontent + '</p>'
					 	 + ' </div>';
					 str +=' <div class="btnsReply" style="margin-bottom:10px">'
					 	 + ' <button type="button" style="display:in-block" '
					 	 + ' class="btn btn-primary btn-xs btnChgReplyReg">'
					 	 + ' <span>답글 작성</span></button>'
					 	 + ' </div>';
					 str +=' </div>'
					 	 + '</li>';
				}//for-End
					 //UL 태그 내에 HTML 내용 표시
					 commentUL.html(str); //html() 사용 시, 새로운 내용으로 교체.
					 //commentUL.append(str); //append 사용 시, 기존 내용 밑에 새로운 내용 추가 (페이징 대신 사용).
					 
					//페이징번호 표시 함수 호출
					 showCmtPagingNums(replyPagingCreator.myReplyPaging.pageNum,
					 				   replyPagingCreator.startPagingNum,
					 				   replyPagingCreator.endPagingNum,
					                   replyPagingCreator.prev,
					 				   replyPagingCreator.next,
					 				   replyPagingCreator.lastPageNum);

					}//.end callback 매개변수의 익명 함수
				);//.end myCommentClsr.getCmtList
			}//.end showCmtList
			
			//댓글 목록에 표시할 페이징번호 생성 함수: replyPagingCreator로 부터 받아온 값들을 이용
			function showCmtPagingNums(pageNum, startPagingNum, endPagingNum, prev, next, lastPageNum ) {
			 	if(endPagingNum >= lastPageNum){ 
			 		endPagingNum = lastPageNum;
			 	}
			 
			 	var str = "<ul class='pagination pagination-sm'>";
			 	
			 	//맨 앞으로
			 	if(prev){
			 	   str +=" <li class='page-item'>"
			 		   + " <a class='page-link' href='"+1+"'>"
			 		   + " <span aria-hidden='true'>&laquo;</span>"
			 	       + " </a>"
			 		   + " </li>";
				 }
				 //이전 페이지
			 	if(prev){
			 		str +=" <li class='page-item'>"
			 			+ " <a class='page-link' href='"+(startPagingNum -1)+"'>이전</a>"
			 			+ " </li>";
			 	}
			 	
				 //선택된 페이지 번호 Bootstrap의 색상표시
			 	for(var i = startPagingNum ; i <= endPagingNum; i++){
			 	
			 	 	//active는 Bootstrap 클래스 이름
			 		var active = ( ( pageNum == i ) ? "active" : "" );
			 
			 	 	str +=" <li class='page-item "+active+"'>"
			 			+ " <a class='page-link' href='"+i+"'>"+i+"</a>"
			 			+ " </li>";
			 	}
			 
			 	if(next){
			 		str +=" <li class='page-item'>"
			 			+ " <a class='page-link' href='"+(endPagingNum + 1)+"'>다음</a>"
			 			+ " </li>";
			 	}
			 
			 		//맨 마지막으로
			 	if(next){
			 		str +=" <li class='page-item'>"
			 			+ " <a class='page-link' href='"+(lastPageNum)+"'>&raquo;</a>"
			 			+ " </li>";
			 	}
			 
			 		str +="</ul>";
			 	$("#showCmtPagingNums").html(str); //#showCmtPagingNums div에 표시
			}
					 	
			$(document).ready(function(){//페이지 로딩 시 함수 실행 
				showCmtList(1);
			});
		
		</script>
        
        <%@ include file="../myinclude/myfooter.jsp" %>

    