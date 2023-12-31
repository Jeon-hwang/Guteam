package project.spring.guteam.controller;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.domain.ReplyVO;
import project.spring.guteam.service.ReplyService;

@RestController
@RequestMapping("boardComment/replies")
public class ReplyRESTController {
	private static final Logger logger= LoggerFactory.getLogger(ReplyRESTController.class);
	
	@Autowired
	private ReplyService replyService;
	
	@PostMapping
	public ResponseEntity<Integer> createReply(@RequestBody ReplyVO vo){
		logger.info("createReply 호출");
		int result = 0;
		result = replyService.create(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@GetMapping("/all/{commentId}")
	public ResponseEntity<Map<String, Object>> readReply(@PathVariable("commentId") int commentId){
		logger.info("readReply 호출");
		Map<String, Object> data = replyService.read(commentId);
		
		return new ResponseEntity<Map<String,Object>>(data,HttpStatus.OK);
	}
	
	@PutMapping("/{replyId}")
	public ResponseEntity<Integer> updateReply(@PathVariable("replyId") int replyId, @RequestBody String replyContent){
		logger.info("updateReply 호출");
		int result = 0;
		
		result = replyService.update(replyId, replyContent);
		
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@DeleteMapping("/{replyId}")
	public ResponseEntity<Integer> deleteReply(@PathVariable("replyId") int replyId
			,@RequestBody(required = false) String commentContent, int commentId){
		int result;
		result = replyService.delete(commentId, commentContent, replyId);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
