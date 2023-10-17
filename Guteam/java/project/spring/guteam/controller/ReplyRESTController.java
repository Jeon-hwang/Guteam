package project.spring.guteam.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
	private ReplyService service;
	
	@PostMapping
	public ResponseEntity<Integer> createReply(@RequestBody ReplyVO vo){
		int result = 0;
		result = service.create(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@GetMapping("/all/{commentId}")
	public ResponseEntity<List<ReplyVO>> readReply(@PathVariable("commentId") int commentId){
		logger.info("readReply 호출");
		List<ReplyVO> list = service.read(commentId);
		
		return new ResponseEntity<List<ReplyVO>>(list,HttpStatus.OK);
	}
}
