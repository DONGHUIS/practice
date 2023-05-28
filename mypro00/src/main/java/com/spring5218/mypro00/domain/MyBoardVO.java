package com.spring5218.mypro00.domain;

import java.sql.Timestamp;
import java.util.Date;
import lombok.Data;

@Data
public class MyBoardVO {
	private long bno ;
	private String btitle ;
	private String bcontent ;
	private String bwriter ;
	private int bviewsCnt ;
	private int breplyCnt ;
	private int bdelFlag ; //1: 삭제요청됨, 0: 유지
	private Date bregDate ;
	private Timestamp bmodDate ;
}