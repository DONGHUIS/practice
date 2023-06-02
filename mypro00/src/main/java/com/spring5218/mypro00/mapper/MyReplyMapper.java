package com.spring5218.mypro00.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring5218.mypro00.domain.MyReplyVO;

public interface MyReplyMapper {
	
	//특정 게시물에 대한 댓글 목록 조회
	 public List<MyReplyVO> selectMyReplyList(Long bno);
	
	 //특정 게시물에 대한 댓글 등록
	 public long insertMyReplyForBoard(MyReplyVO myReplyVO);
	 
	 //댓글에 대한 답글 등록
	 public long insertMyReplyForReply(MyReplyVO myReplyVO);
	 
	 //특정 게시물에 대한 특정 댓글/답글 조회
	 public MyReplyVO selectMyReply(@Param("bno") Long bno, @Param("rno") Long rno);
	 
	 //특정 게시물에 대한 특정 댓글/답글 수정
	 public int updateMyReply(MyReplyVO myReply);
	 
	 //특정 게시물에 대한 특정 댓글/답글 삭제
	 public int deleteMyReply(@Param("bno") Long bno, @Param("rno") Long rno);
	 
	 //특정 게시물에 대한 모든 댓글 삭제(관리자) -- myreply.bno 컬럼의 F.K 에 ON DELETE CASCADE 를 사용하는 경우, 필요 없음
	 //public int deleteAllReply(@Param("bno") Long bno);
}
