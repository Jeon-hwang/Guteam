package project.spring.guteam.controller;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.service.MessageService;

@RestController
@RequestMapping(value="/message")
public class MessageRESTController {
	private static final Logger logger = LoggerFactory.getLogger(MessageRESTController.class);
	
	@Autowired
	private MessageService messageService;
	
	@DeleteMapping("/delete/{sendRecv}")
	public ResponseEntity<Integer> delete(@PathVariable("sendRecv") String sendRecv, @RequestBody int[] msgArr) {
		logger.info(Arrays.toString(msgArr));
		int result = 0;
		if(sendRecv.equals("receive")) {
			for(int i=0; i<msgArr.length; i++) {
				result = messageService.deleteByReceive(msgArr[i]);
			} 
		} else if(sendRecv.equals("send")) {
			for(int i=0; i<msgArr.length; i++) {
				result = messageService.deleteBySend(msgArr[i]);
			}
		} else {
			logger.info("삭제 실패");
		}
		logger.info("삭제 성공? = " + result);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
		
	}
	
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
}
