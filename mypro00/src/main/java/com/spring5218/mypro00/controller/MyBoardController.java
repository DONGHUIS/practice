package com.spring5218.mypro00.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring5218.mypro00.domain.MyBoardVO;
import com.spring5218.mypro00.service.MyBoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/myboard")
public class MyBoardController {

	@Setter(onMethod_ = @Autowired)
	private MyBoardService myBoardService;
	
	//게시물 전체 목록 조회
	 @GetMapping("/list")
	 public void showBoardList(Model model) { 
		 log.info("컨트롤러 - 게시물 목록 조회.....");
		 model.addAttribute("boardList", myBoardService.getBoardList());
	 }
	 
	//게시물 등록 - 페이지 호출
	 @GetMapping("/register")
	 public void showBoardRegisterPage() {
		 log.info("컨트롤러 - 게시물 등록 페이지 호출");
	 }
	 
	 //게시물 등록 - 처리
	 @PostMapping("/register")
	 public String registerNewBoard(MyBoardVO myBoard, RedirectAttributes redirectAttr) {
		 log.info("컨트롤러 - 게시물 등록: " + myBoard);
		 long bno = myBoardService.registerBoard(myBoard);
		 
		 log.info("등록된 개시물의 bno: " + bno );
		 redirectAttr.addFlashAttribute("result", bno);
		 
		 return "redirect:/myboard/list"; //jsp 대신, 리다이렉트 방식으로 사용자 브라우저가 게시물 목록을 호출하게 함.
		 
	 }
	//특정 게시물 조회 페이지 호출: 목록페이지에서 호출
	 @GetMapping("/detail")
	 public void showBoardDetail(@RequestParam("bno") Long bno, Model model) {
		 log.info("컨트롤러 - 게시물 조회 페이지 호출: "+ bno);
		 model.addAttribute("board", myBoardService.getBoard(bno));
		 log.info("컨트롤러 - 화면으로 전달할 model: "+ model);
	 }
	 
	 
	//특정 게시물 조회-수정 페이지 호출
	 @GetMapping({"/detail", "/modify"})
	 public void showBoardDetail(@RequestParam("bno") long bno, Model model) {
		 log.info("컨트롤러 - 게시물 조회-수정 페이지 호출: "+ bno);
		 model.addAttribute("board", myBoardService.getBoard(bno));
		 log.info("컨트롤러 - 화면으로 전달할 model: "+ model);
	 }
	 
	//게시물 조회페이지 -> 수정페이지 호출(/modify)
	 @GetMapping("/modify")
	 public void showBoardModify(@RequestParam("bno") Long bno, Model model) {
		 log.info("컨트롤러 - 게시물 수정 페이지 호출: "+ bno);
		 model.addAttribute("board", myBoardService.getBoardDetailModify(bno));
		 log.info("컨트롤러 - 화면으로 전달할 model: "+ model);
	 }

	 
	 //특정 게시물 수정 처리
	 @PostMapping("/modify")
	 public String modifyBoard(MyBoardVO myBoard, RedirectAttributes redirectAttr){
		 log.info("컨트롤러 - 게시물 수정 전달된 myBoard 값: " + myBoard);
	 
		 if (myBoardService.modifyBoard(myBoard)) {
			 redirectAttr.addFlashAttribute("result", "successModify");
	 }
		 return "redirect:/myboard/detailmod?bno=" + myBoard.getBno();
	 }
	 
	//게시물 수정 후 -> 조회페이지 호출 시(/detailmod) 
	 @GetMapping("/detailmod")
	 public String showBoardDetailMod(@RequestParam("bno") long bno, Model model) {
		log.info("컨트롤러 - 게시물 수정 페이지 호출: "+ bno);
	  	model.addAttribute("board", myBoardService.getBoardDetailModify(bno));
	  	log.info("컨트롤러 - 화면으로 전달할 model: "+ model);
	  	return "/myboard/detail" ;
	 }
	 
	 //특정 게시물 삭제 요청
	 @PostMapping("/delete")
	 public String setBoardDeleted(@RequestParam("bno") long bno, RedirectAttributes redirectAttr){
		 log.info("컨트롤러 - 게시물 삭제(bdelFlag값변경 글번호): " + bno);
		 
		 if (myBoardService.setBoardDeleted(bno)) {
			 redirectAttr.addFlashAttribute("result", "successRemove");
	 }
		 return "redirect:/myboard/list";
	 
	 }
	 
	 //특정 게시물 실제 삭제
	 @PostMapping("/remove")
	 public String removeBoard(@RequestParam("bno") long bno, RedirectAttributes redirectAttr) {
		 log.info("컨트롤러 - 게시물 삭제: 삭제되는 글번호: " + bno);
		 
		 if (myBoardService.removeBoard(bno)) {
			 redirectAttr.addFlashAttribute("result", "successRemove");
	 }
		 return "redirect:/myboard/list";
	 }
	 
	 //게시물 삭제 - 삭제 요청된 모든 게시물 삭제
	 @PostMapping("/removeAll")
	 public String removeAllDeletedBoard(Model model, RedirectAttributes redirectAttr) {
		 model.addAttribute("removedRowCnt", myBoardService.removeAllDeletedBoard());
		 log.info("관리자에 의해 삭제된 총 행수: " + model.addAttribute("removedRowCnt"));//log.info("관리자에 의해 삭제된 총 행수: " + model.getAttribute("removedRowCnt"));
		 redirectAttr.addFlashAttribute("result", "successRemoveAll");
		 return "redirect:/myboard/list";
	 }
	
}
