package com.spring5218.mypro00.service;

import com.spring5218.mypro00.common.paging.MyReplyPagingCreatorDTO;
import com.spring5218.mypro00.common.paging.MyReplyPagingDTO;
import com.spring5218.mypro00.domain.MyReplyVO;

public interface MyReplyService {
	 
	 //특정 게시물에 대한 댓글 목록 조회(페이징1)
	 //public List<MyReplyVO> getReplyListByBno(MyReplyPagingDTO myReplyPaging);
	 
	//특정 게시물에 대한 댓글 목록 조회(페이징2-수정)
	 public MyReplyPagingCreatorDTO getReplyListByBno(MyReplyPagingDTO myReplyPaging);
	 
	 //특정 게시물의 댓글 총 개수확인
	 public long getReplyTotalByBno(MyReplyPagingDTO myReplyPaging);
	 
	 //특정 게시물에 대한 댓글 등록: rno 반환
	 public long registerReplyForBoard(MyReplyVO myReply);
	 
	 //댓글의 답글 등록: rno 반환
	 public long registerReplyForReply(MyReplyVO myReply);
	 
	 //특정 게시물에 대한 특정 댓글/답글 조회
	 public MyReplyVO getReply(long bno, long rno);
	 
	 //특정 게시물에 대한 특정 댓글/답글 수정
	 public int modifyReply(MyReplyVO myReply);
	 
	 //특정 게시물에 대한 특정 댓글/답글 삭제
	 public int removeReply(long bno, long rno);
	
}
