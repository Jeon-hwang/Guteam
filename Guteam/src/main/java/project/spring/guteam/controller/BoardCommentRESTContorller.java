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

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.service.BoardCommentService;


@RestController
@RequestMapping(value="board_comment/comments")
public class BoardCommentRESTContorller {
	private static final Logger logger = LoggerFactory.getLogger(BoardCommentRESTContorller.class);
	
	@Autowired
	private BoardCommentService service;
	
	@PostMapping
	public ResponseEntity<Integer> createComment(@RequestBody BoardCommentVO vo){
		logger.info("createComment 실행");
		int result = 0;
		result = service.create(vo);
		logger.info(Integer.toString(result));
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@GetMapping("/all/{gameBoardId}")
	public ResponseEntity<List<BoardCommentVO>> readComment(@PathVariable("gameBoardId") int gameBoardId){
		logger.info("readComment 실행");
		
		List<BoardCommentVO> list = service.read(gameBoardId);
		return new ResponseEntity<List<BoardCommentVO>>(list,HttpStatus.OK);
	}
	
	@PostMapping("/{commentId}")
	public ResponseEntity<Integer> updateComment(@PathVariable("commentId") int commentId,@RequestBody String commentContent){
		logger.info("comment update 호출");
		
		int result;
		result = service.update(commentId, commentContent);
		
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
}
