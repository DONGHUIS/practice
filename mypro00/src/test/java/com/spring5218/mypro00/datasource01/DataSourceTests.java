package com.spring5218.mypro00.datasource01;

import static org.junit.Assert.fail;

import java.sql.Connection;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/mybatis-context.xml")
@Log4j
public class DataSourceTests {
	
	 @Setter(onMethod_ = { @Autowired })
	 private SqlSessionTemplate sqlSession;
	 
	 @Test
	 public void testMyBatis() {
		 try ( //SqlSession sqlSession = sqlSessionFactory.openSession();
				 Connection conn = sqlSession.getConnection(); ) {
			 log.info(conn);
			 log.info(sqlSession);
		 } catch (Exception e) {
			 fail(e.getMessage());
		 }
	 }
}	