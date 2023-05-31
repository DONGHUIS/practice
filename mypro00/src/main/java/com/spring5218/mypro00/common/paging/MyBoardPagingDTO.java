package com.spring5218.mypro00.common.paging;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@EqualsAndHashCode
public class MyBoardPagingDTO {
	
	private int pageNum; //현재 페이지 번호
	private int rowAmountPerPage; //페이지당 출력할 레코드 개수
 
	//생성자를 통해 표시할 페이지번호와 페이지당 출력할 레코드 개수를 컨트롤러로 전달
	//생성자1: list.jsp가 처음 호출 시에, 페이지번호와 행수를 각각 1과 10으로 전달
	public MyBoardPagingDTO() {
		this.pageNum = 1 ;
		this.rowAmountPerPage = 10 ;
	}
	//생성자2: 목록 화면에서 페이징번호 클릭 시, 페이지번호와 행수를 각각 사용자가 선택한 페이징번호와 10으로 전달
	public MyBoardPagingDTO(int pageNum) {
		if(pageNum <= 0) {
			this.pageNum = 1 ;
		} else {
			this.pageNum = pageNum;
		}
		this.rowAmountPerPage = 10 ;
 }
	
	//생성자3: 목록 화면에서 사용자가 표시할 행수를 선택하고 페이징 번호 클릭 시,
	//페이지번호와 행수를 각각 사용자가 선택한 페이징번호와 표시행수로 전달
	 public MyBoardPagingDTO(int pageNum, int rowAmountPerPage) {
		 if(pageNum <= 0) {
			 this.pageNum = 1 ;
		 } else {
			 this.pageNum = pageNum;
		 }
 
		 if(rowAmountPerPage <= 0) {
			 this.rowAmountPerPage = 10 ;
		 } else {
			 this.rowAmountPerPage = rowAmountPerPage;
		 }
	 }
}