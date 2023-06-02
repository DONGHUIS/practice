package com.spring5218.mypro00.mapper02;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring5218.mypro00.domain.MyReplyVO;
import com.spring5218.mypro00.mapper.MyReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/mybatis-context.xml")
@Log4j
public class MyReplyMapperTests {
	 
	@Setter(onMethod_ = @Autowired)
	 private MyReplyMapper myReplyMapper;
	
	//매퍼 인스턴스 생성 테스트
	/*@Test
	public void testMapper() {
	 log.info(myReplyMapper);
	}*/
	
	//특정 게시물에 대한 댓글 목록 조회 테스트
	@Test
	public void testSelectMyReplyList() {
		Long targetBno = 229404L; //SQL Developer에서 확인된 가장 최신 게시물의 bno를 지정
		List<MyReplyVO> myReplies = myReplyMapper.selectMyReplyList(targetBno);
		myReplies.forEach(myReply -> System.out.println(myReply));
	}

}
