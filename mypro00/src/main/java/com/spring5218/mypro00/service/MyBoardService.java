package com.spring5218.mypro00.service;

import java.util.List;

import com.spring5218.mypro00.common.paging.MyBoardPagingDTO;
import com.spring5218.mypro00.domain.MyBoardVO;

public interface MyBoardService{
	 
	//게시물 목록 조회 서비스 - 페이징 고려
	public List<MyBoardVO> getBoardList(MyBoardPagingDTO myBoardPagingDTO);
	
	 //게시물 등록: selectKey이용
	 public long registerBoard(MyBoardVO myBoard);
	 
	 //게시물 조회: by bno + 조회수 증가 고려
	 public MyBoardVO getBoard(long bno);
	 
	//게시물 조회: 게시물 조회 페이지 -> 게시물 수정 페이지 호출(by bno), 조회수 변화 없음
	//게시물 조회: 게시물 수정 후 -> 게시물 조회 페이지 호출(by bno), 조회수 증가 없음
	public MyBoardVO getBoardDetailModify(long bno);
	
	//게시물 총 개수 조회 서비스 - 페이징 시 필요
	public long getRowAmountTotal(MyBoardPagingDTO myBoardPagingDTO);
	 
	 //게시물 수정
	 public boolean modifyBoard(MyBoardVO myBoard);
	 
	 //게시물 삭제 - bdelFlag 컬럼만 1로 수정
	 public boolean setBoardDeleted(long bno);
	 
	 //게시물 삭제 - 실제 삭제 발생
	 public boolean removeBoard(long bno);
	 
	 //게시물 삭제(관리자) – 사용자 삭제 요청된 게시물 전체 삭제: bdelFlag = 1
	 public int removeAllDeletedBoard();
}
