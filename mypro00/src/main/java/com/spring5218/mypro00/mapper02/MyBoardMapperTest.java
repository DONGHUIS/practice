package com.spring5218.mypro00.mapper02;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring5218.mypro00.mapper.MyBoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/mybatis-context.xml")
@Log4j
public class MyBoardMapperTest {
	 @Setter(onMethod_ = @Autowired)
	 private MyBoardMapper myBoardMapper;
	 
	//게시물 목록 조회 테스트  테스트 후 메서드 주석처리
	 @Test
	 public void testSelectBoardList() {
		 myBoardMapper.selectMyBoardList().forEach(myBoard -> log.info(myBoard));
	 }
}