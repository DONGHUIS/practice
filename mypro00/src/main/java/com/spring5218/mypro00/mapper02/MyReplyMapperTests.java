package com.spring5218.mypro00.mapper02;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.spring5218.mypro00.common.paging.MyReplyPagingDTO;
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
	
	//특정 게시물에 대한 댓글 목록 조회(페이징) 테스트
	@Test
	public void testSelectMyReplyListPaging() {
		 long targetBno = 1; //SQL Developer 에서 확인된 가장 최신 게시물의 bno 를 지정
		 MyReplyPagingDTO myReplyPagingDTO = new MyReplyPagingDTO(targetBno, 1);
		 
		 long totalReplyCnt = myReplyMapper.selectReplyTotalByBno(myReplyPagingDTO);
		 log.info("댓글 총 개수: "+ totalReplyCnt);
		 
		 List<MyReplyVO> myReplies = myReplyMapper.selectMyReplyList(myReplyPagingDTO);
		 myReplies.forEach(myReply -> System.out.println(myReply));
	}

}
