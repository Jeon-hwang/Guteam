package project.spring.guteam.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.service.WishListService;

@RestController
@RequestMapping("/wishList")
public class WishListRESTController {
	private static final Logger logger = LoggerFactory.getLogger(WishListRESTController.class);
	
	@Autowired
	private WishListService service;
	
	@PostMapping
	public ResponseEntity<Integer> createWishList(@RequestBody WishListVO vo){
		logger.info("createWishList 실행");
		int result = 0;
		result = service.create(vo);
		logger.info(Integer.toString(result));
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	@GetMapping("/all/{memberId}")
	public ResponseEntity<List<GameVO>> readWishList(@PathVariable String memberId){
		PageCriteria criteria = new PageCriteria(1, 5);
		List<GameVO> list = service.read(memberId, criteria);
		return new ResponseEntity<List<GameVO>>(list,HttpStatus.OK);
	}
	@GetMapping("/find/{memberId}")
	public ResponseEntity<WishListVO> findWishList(@PathVariable("memberId") String memberId, int gameId){
		WishListVO vo = service.find(memberId, gameId);
		return new ResponseEntity<WishListVO>(vo, HttpStatus.OK);
	}
	
	@DeleteMapping("/{memberId}")
	public ResponseEntity<Integer> deleteWishList(@PathVariable("memberId")String memberId,@RequestBody int gameId){
		WishListVO vo = new WishListVO(memberId, gameId);
		logger.info("컨트롤러 값"+vo.toString());
		int result = service.delete(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
