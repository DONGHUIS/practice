package com.spring5218.mypro00.common.paging;

import java.util.List;

import com.spring5218.mypro00.domain.MyReplyVO;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class MyReplyPagingCreatorDTO {
	 private MyReplyPagingDTO myReplyPaging ; //페이지번호와 행 개수 저장 객체
	 private int startPagingNum; //화면에 표시되는 시작 페이징 번호
	 private int endPagingNum; //화면에 표시되는 끝 페이징 번호
	 private boolean prev; //이전 버튼 표시 여부 결정 변수(true: 표시됨, false: 표시 안됨)
	 private boolean next; //다음 버튼 표시 여부 결정 변수(true: 표시됨, false: 표시 안됨)
	 private long replyTotalByBno;//전체 행 개수
	 private int pagingNumCnt; //화면 하단에 표시할 기본 페이지 번호 개수(10)
	 private int lastPageNum ; //마지막 페이지 번호
	 
	 private List<MyReplyVO> replyList;
 
	 public MyReplyPagingCreatorDTO(long replyTotalByBno,
			 MyReplyPagingDTO myReplyPaging,
			 List<MyReplyVO> replyList) {
		 
				 this.myReplyPaging = myReplyPaging ;
				 this.replyTotalByBno = replyTotalByBno;
				 this.replyList = replyList ;
				 this.pagingNumCnt = 10;
 
			 //계산된 끝-시작 페이징 번호:
			 this.endPagingNum = 
			 (int)( Math.ceil(myReplyPaging.getPageNum() / (this.pagingNumCnt * 1.0) ) ) * this.pagingNumCnt ;
			 this.startPagingNum = this.endPagingNum - (this.pagingNumCnt -1);
 
			 //행 총수를 기준으로 한 실제 마지막 페이지 번호
			 this.lastPageNum = (int)( Math.ceil( (replyTotalByBno * 1.0) / myReplyPaging.getRowAmountPerPage() ) );
			 
			 //계산된 끝 페이징 번호가 실제 마지막 페이지 번호보다 크면, endPagingNum 값을 lastPageNum 으로 대체
			 if (lastPageNum < this.endPagingNum) {
			 this.endPagingNum = lastPageNum ;
			 }
 
			 this.prev = this.startPagingNum > 1 ;
			 this.next = this.endPagingNum < lastPageNum ;
 
			 System.out.println("댓글-전달된 페이징 기본데이터-MyReplyPagingDTO: " + myReplyPaging.toString());
			 System.out.println("댓글-끝 페이징번호: " + this.endPagingNum);
			 System.out.println("댓글-시작 페이징번호: " + this.startPagingNum);
			 System.out.println("댓글-이전버튼 표시 여부: " + this.prev);
			 System.out.println("댓글-다음버튼 표시 여부: " + this.next);
			 System.out.println("전달된 댓글 목록 데이터: " + this. replyList);
	 }
}