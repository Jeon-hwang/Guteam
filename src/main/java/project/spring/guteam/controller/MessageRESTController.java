package project.spring.guteam.controller;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.service.MemberService;
import project.spring.guteam.service.MessageService;

@RestController
@RequestMapping(value="/message")
public class MessageRESTController {
	private static final Logger logger = LoggerFactory.getLogger(MessageRESTController.class);
	
	@Autowired
	private MessageService messageService;
	
	@Autowired
	private MemberService memberService;
	
	// 쪽지 삭제 (비동기)
	@DeleteMapping("/delete/{sendRecv}")
	public ResponseEntity<Integer> delete(@PathVariable("sendRecv") String sendRecv, @RequestBody int[] msgArr) {
		logger.info(Arrays.toString(msgArr));
		int result = 0;
		// 문제점 : 보낸/받은 쪽지 보관 후 삭제시 "보낸", "받은"인  String sendRecv로 판별 후 삭제 불가능
		//		해결1. ${svo.fromTo}를 자바스크립트로 찾아와서 판별 후 send나 receive로 삭제 전송
		//		해결2. 컨트롤러에서 sendRecv를 따로 받아 로직 수행 (box로 받으면 받은 msgArr이 보낸/받은 판단 불가)
//		if(sendRecv.equals("box")) {
//			
//		}
		if(sendRecv.equals("receive")) {
			logger.info("receive다");
			for(int i=0; i<msgArr.length; i++) {
				result = messageService.deleteByReceive(msgArr[i]);
			} 
		} else if(sendRecv.equals("send")) {
			logger.info("send다");
			for(int i=0; i<msgArr.length; i++) {
				result = messageService.deleteBySend(msgArr[i]);
			}
		} else {
			logger.info("삭제 실패");
		}
		logger.info("삭제 성공? = " + result);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
		
	}
	
	// 쪽지 보관 (비동기)
	@PutMapping("/box/{sendRecv}")
	public ResponseEntity<Integer> update(@PathVariable("sendRecv") String sendRecv, @RequestBody int[]msgArr){
		logger.info(Arrays.toString(msgArr));
		int result = 0;
		if(sendRecv.equals("send")) {
			for(int i=0; i<msgArr.length; i++) {
				result = messageService.updateBox("Y", msgArr[i], "send");			
			} 
		} else {
			for(int i=0; i<msgArr.length; i++) {
				result = messageService.updateBox("Y", msgArr[i], "");			
			} 
		}
		
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
		
	}
	
	// 수신자 검색
	@GetMapping("/search/{keyword}")
	public ResponseEntity<List<String>> keywords(@PathVariable("keyword") String keyword) {
		List<String> keywords = memberService.search(keyword);
		logger.info(keywords.toString());
		logger.info("keyword? " + keyword);
		return new ResponseEntity<List<String>>(keywords, HttpStatus.OK);
		
	}
}
