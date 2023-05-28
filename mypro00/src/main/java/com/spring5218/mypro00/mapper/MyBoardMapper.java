package com.spring5218.mypro00.mapper;

import java.util.List;

import com.spring5218.mypro00.domain.MyBoardVO;

public interface MyBoardMapper {
	
	 //게시물 조회 - 목록
	 public List<MyBoardVO> selectMyBoardList();
	 
	 //게시물 등록1 - selectKey 이용 않함
	 public Integer insertMyBoard(MyBoardVO myBoard);
	 
	 //게시물 등록2 - selectKey 이용
	 public Integer insertMyBoardSelectKey(MyBoardVO myBoard);
	 
	 //특정 게시물 조회
	 public MyBoardVO selectMyBoard(Long bno);
	 
	 //특정 게시물 삭제 요청 - 해당 글의 bdelFlag을 1로 수정
	 public int updateBdelFlag(Long bno);
	 
	 //특정 게시물 삭제 - 실제 삭제
	 public int deleteMyBoard(Long bno);
	 
	 //게시물 삭제(관리자) – 사용자 삭제 요청된 게시물(bdelFlag = 1) 전체 삭제
	 public int deleteAllBoardSetDeleted();
	 
	 //특정 게시물 수정
	 public int updateMyBoard(MyBoardVO myBoard);
	 
	 //특정 게시물 조회수 증가
	 public void updateBviewsCnt(Long bno);
}
