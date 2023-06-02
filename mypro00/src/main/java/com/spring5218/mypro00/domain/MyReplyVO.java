package com.spring5218.mypro00.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyReplyVO {
 private long bno;
 private long rno;
 private String rcontent;
 private String rwriter;
 private Timestamp rregDate;
 private Timestamp rmodDate;
 private long prno;
 private int lvl; //계층쿼리의 level 값을 저장할 필드
}
