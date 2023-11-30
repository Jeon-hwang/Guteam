package project.spring.guteam.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.service.MemberService;

@RestController
@RequestMapping(value="/tag")
public class TagRESTController {
	private static final Logger logger = LoggerFactory.getLogger(TagRESTController.class);
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/{keyword}")
	public ResponseEntity<List<MemberVO>> read(@PathVariable("keyword") String keyword) {
		logger.info("tag read 호출");
		List<MemberVO> result = memberService.findLikeNickname(keyword);
		return new ResponseEntity<List<MemberVO>>(result,HttpStatus.OK);
	} // end read()
	

}
