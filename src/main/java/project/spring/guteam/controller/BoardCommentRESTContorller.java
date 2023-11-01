package project.spring.guteam.controller;

import java.util.List;
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

import project.spring.guteam.domain.BoardAndReplyVO;
import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.BoardCommentService;


@RestController
@RequestMapping(value="boardComment/comments")
public class BoardCommentRESTContorller {
	private static final Logger logger = LoggerFactory.getLogger(BoardCommentRESTContorller.class);
	
	@Autowired
	private BoardCommentService service;
	
	@GetMapping
	public void comment() {}
	
	@PostMapping
	public ResponseEntity<Integer> createComment(@RequestBody BoardCommentVO vo) throws Exception{
		logger.info("createComment 실행");
		int result = 0;
		result = service.create(vo);
		logger.info(Integer.toString(result));
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@GetMapping("/all/{gameBoardId}")
	public ResponseEntity<Map<String, Object>> readComment(@PathVariable("gameBoardId") int gameBoardId,Integer page){
		logger.info("readComment 실행");
		PageCriteria criteria = new PageCriteria(1, 3);
		if(page != null) {
			criteria.setPage(page);
		}
		Map<String, Object> data = service.read(gameBoardId,criteria);
		
		return new ResponseEntity<Map<String,Object>>(data,HttpStatus.OK);
	}
	
	@PutMapping("/{commentId}")
	public ResponseEntity<Integer> updateComment(@PathVariable("commentId") int commentId,@RequestBody String commentContent){
		logger.info("comment update 호출");
		
		int result;
		result = service.update(commentId, commentContent);
		
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	 
	@DeleteMapping("/{commentId}")
	public ResponseEntity<Integer> deleteComment(@PathVariable("commentId") int commentId,@RequestBody int gameBoardId){
		logger.info("comment delete 호출");
		int result = service.delete(commentId, gameBoardId);
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	@GetMapping("/{memberId}")
	public ResponseEntity<Map<String, Object>> readAllComment(@PathVariable("memberId") String memberId,Integer page){
		PageCriteria criteria = new PageCriteria(1, 10);
		if(page != null) {
			criteria.setPage(page);
		}
		Map<String, Object> data = service.getAllCommentsAndReplies(memberId,criteria);
		return new ResponseEntity<Map<String, Object>>(data,HttpStatus.OK);
	}
}
