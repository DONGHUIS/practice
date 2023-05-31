package com.spring5218.mypro00.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring5218.mypro00.common.paging.MyBoardPagingCreatorDTO;
import com.spring5218.mypro00.common.paging.MyBoardPagingDTO;
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
	
	//게시물 목록 조회 - 페이징 고려
	@GetMapping("/list")
	public void showBoardList(MyBoardPagingDTO myBoardPagingDTO, Model model) {
		log.info("컨트롤러 - 게시물 목록 조회 시작.....");
		log.info("컨트롤러에 전달된 사용자의 페이징처리 데이터: " + myBoardPagingDTO);
		
		model.addAttribute("boardList", myBoardService.getBoardList(myBoardPagingDTO));
		
		long rowAmountTotal = myBoardService.getRowAmountTotal(myBoardPagingDTO);
		 log.info("컨트롤러에 전달된 게시물 총 개수: " + rowAmountTotal);
		 MyBoardPagingCreatorDTO myBoardPagingCreatorDTO =
				 				new MyBoardPagingCreatorDTO (rowAmountTotal, myBoardPagingDTO);
		 log.info("컨트롤러에서 생성된 MyBoardCreaingPagingDTO 객체 정보: " + myBoardPagingCreatorDTO.toString());
		 
		 model.addAttribute("pagingCreator", myBoardPagingCreatorDTO );
		log.info("컨트롤러 - 게시물 목록 조회 완료.....");
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
	 public void showBoardDetail(@RequestParam("bno") long bno, Model model,
			 					 @ModelAttribute("myBoardPagingDTO") MyBoardPagingDTO myBoardPagingDTO ) {
	  log.info("컨트롤러 - 게시물 조회 페이지 호출: "+ bno);
	  log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
	  
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
	 public void showBoardModify(@RequestParam("bno") Long bno, Model model,
			 					 MyBoardPagingDTO myBoardPagingDTO ) {
		  log.info("컨트롤러 - 게시물 수정 페이지 호출: "+ bno);
		  log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
		  
		  model.addAttribute("board", myBoardService.getBoardDetailModify(bno));
		  model.addAttribute("myBoardPagingDTO", myBoardPagingDTO);
		  log.info("컨트롤러 - 화면으로 전달할 model: "+ model);
	 }

	 
	 //특정 게시물 수정 처리
	 @PostMapping("/modify")
	 public String modifyBoard(MyBoardVO myBoard, RedirectAttributes redirectAttr, MyBoardPagingDTO myBoardPagingDTO){
		 log.info("컨트롤러 - 게시물 수정 전달된 myBoard 값: " + myBoard);
		 log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
	 
		 if (myBoardService.modifyBoard(myBoard)) {
			 redirectAttr.addFlashAttribute("result", "successModify");
	 }
		//RedirectAttribute 유형의 객체에 전달할 페이징 데이터를 속성으로 바인딩
		 redirectAttr.addAttribute("bno", myBoard.getBno());
		 redirectAttr.addAttribute("pageNum", myBoardPagingDTO.getPageNum());
		 redirectAttr.addAttribute("rowAmountPerPage", myBoardPagingDTO.getRowAmountPerPage());
		 
		 log.info("화면으로 전달될 redirectAttr: "+ redirectAttr);
		 
		 return "redirect:/myboard/detailmod";
	 }
	 
	//게시물 수정 후 -> 조회페이지 호출 시(/detailmod) 
	 @GetMapping("/detailmod")
	 public String showBoardDetailMod(@RequestParam("bno") long bno, Model model,MyBoardPagingDTO myBoardPagingDTO) {
		log.info("컨트롤러 - 게시물 수정 페이지 호출: "+ bno);
		log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
		
		//수정 후 DB에 저장된 데이터를 다시 가져와서 model에 속성으로 바인딩
		 model.addAttribute("board", myBoardService.getBoardDetailModify(bno));
		 model.addAttribute("myBoardPagingDTO", myBoardPagingDTO);
		 log.info("컨트롤러 - 화면으로 전달할 model: " + model);
		 
		 return "/myboard/detail";
	 }
	 
	 //특정 게시물 삭제 요청
	 @PostMapping("/delete")
	 public String setBoardDeleted(@RequestParam("bno") long bno, RedirectAttributes redirectAttr,MyBoardPagingDTO myBoardPagingDTO){
		 log.info("컨트롤러 - 게시물 삭제(bdelFlag값변경 글번호): " + bno);
		 log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
		 
		 if (myBoardService.setBoardDeleted(bno)) {
			 redirectAttr.addFlashAttribute("result", "successRemove");
	 }
		 redirectAttr.addAttribute("pageNum", myBoardPagingDTO.getPageNum());
		 redirectAttr.addAttribute("rowAmountPerPage", myBoardPagingDTO.getRowAmountPerPage());
		 log.info("화면으로 전달될 redirectAttr: "+ redirectAttr);
		 
		 return "redirect:/myboard/list";
	 
	 }
	 
	 //특정 게시물 실제 삭제
	 @PostMapping("/remove")
	 public String removeBoard(@RequestParam("bno") long bno, RedirectAttributes redirectAttr,MyBoardPagingDTO myBoardPagingDTO) {
		 log.info("컨트롤러 - 게시물 삭제: 삭제되는 글번호: " + bno);
		 log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
		 
		 if (myBoardService.removeBoard(bno)) {
			 redirectAttr.addFlashAttribute("result", "successRemove");
	 }
		 redirectAttr.addAttribute("pageNum", myBoardPagingDTO.getPageNum());
		 redirectAttr.addAttribute("rowAmountPerPage", myBoardPagingDTO.getRowAmountPerPage());
		 log.info("화면으로 전달될 redirectAttr: "+ redirectAttr);
		 
		 return "redirect:/myboard/list";
	 }
	 
	 //게시물 삭제 - 삭제 요청된 모든 게시물 삭제
	 @PostMapping("/removeAll")
	 public String removeAllDeletedBoard(Model model, RedirectAttributes redirectAttr,MyBoardPagingDTO myBoardPagingDTO) {
		 log.info("컨트롤러 - 전달된 MyBoardPagingDTO: "+ myBoardPagingDTO);
		 
		 model.addAttribute("removedRowCnt", myBoardService.removeAllDeletedBoard());
		 log.info("관리자에 의해 삭제된 총 행수: " + model.addAttribute("removedRowCnt"));//log.info("관리자에 의해 삭제된 총 행수: " + model.getAttribute("removedRowCnt"));
		 
		 redirectAttr.addFlashAttribute("result", "successRemoveAll");
		 
		 redirectAttr.addAttribute("pageNum", myBoardPagingDTO.getPageNum());
		 redirectAttr.addAttribute("rowAmountPerPage", myBoardPagingDTO.getRowAmountPerPage());
		 log.info("화면으로 전달될 redirectAttr: "+ redirectAttr);
		 
		 return "redirect:/myboard/list";
	 }
	
}
