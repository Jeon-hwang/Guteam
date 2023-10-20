package project.spring.guteam.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.service.ReviewService;
import project.spring.guteam.service.ThumbService;

@RestController
@RequestMapping(value="/thumb")
public class ThumbRESTController {
	private static Logger logger = LoggerFactory.getLogger(ThumbRESTController.class);
	
	@Autowired
	private ThumbService thumbService;
	
	@PostMapping	
	public ResponseEntity<Integer> create(@RequestBody ThumbVO vo) throws Exception{
		logger.info(vo.toString());
		int result = thumbService.create(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@GetMapping
	public ResponseEntity<ThumbVO> read(@RequestBody ThumbVO vo) {
		logger.info(vo.toString());
		ThumbVO result = thumbService.read(vo);
		return new ResponseEntity<ThumbVO>(result,HttpStatus.OK);
	}
	
	@PutMapping
	public ResponseEntity<Integer> update(@RequestBody ThumbVO vo) throws Exception{
		logger.info(vo.toString());
		int result = thumbService.update(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	
	@DeleteMapping
	public ResponseEntity<Integer> delete(@RequestBody ThumbVO vo) throws Exception{
		logger.info(vo.toString());
		int result = thumbService.delete(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
