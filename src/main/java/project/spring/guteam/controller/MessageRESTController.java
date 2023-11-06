package project.spring.guteam.controller;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.service.MessageReceiveService;

@RestController
@RequestMapping(value="/message")
public class MessageRESTController {
	private static final Logger logger = LoggerFactory.getLogger(MessageRESTController.class);
	
	@Autowired
	private MessageReceiveService messageService;
	
	@DeleteMapping("/delete")
	public ResponseEntity<Integer> delete(@RequestBody int[] msgArr) {
		logger.info(Arrays.toString(msgArr));
		int result = 0;
		for(int i=0; i<msgArr.length; i++) {
			result = messageService.delete(msgArr[i]);
		}
		logger.info("삭제 성공? = " + result);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
		
	}
}
