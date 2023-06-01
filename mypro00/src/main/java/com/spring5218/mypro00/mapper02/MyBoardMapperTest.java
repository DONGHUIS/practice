package com.spring5218.mypro00.mapper02;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring5218.mypro00.common.paging.MyBoardPagingDTO;
import com.spring5218.mypro00.domain.MyBoardVO;
import com.spring5218.mypro00.mapper.MyBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/mybatis-context.xml")
@Log4j
public class MyBoardMapperTest {
	 @Setter(onMethod_ = @Autowired)
	 private MyBoardMapper myBoardMapper;
	 
	 @Test
	 public void testSearchBoardWithPaging() {
	  MyBoardPagingDTO myBoardPagingDTO = new MyBoardPagingDTO(); //기본 생성자 이용(1, 10)
	  myBoardPagingDTO.setKeyword("5");
	  
	  //myBoardPagingDTO.setScope("T");
	  //myBoardPagingDTO.setScope("C");
	  //myBoardPagingDTO.setScope("W");
	  //myBoardPagingDTO.setScope("TC");
	  myBoardPagingDTO.setScope("TCW");
	  //myBoardPagingDTO.setScope("TW");
	  //myBoardPagingDTO.setScope("CW");
	  log.info("행 총 개수: " + myBoardMapper.selectRowAmountTotal(myBoardPagingDTO));
	  
	  List<MyBoardVO> list = myBoardMapper.selectMyBoardList(myBoardPagingDTO);
	  list.forEach(board -> log.info(board));
	 }
	
}
