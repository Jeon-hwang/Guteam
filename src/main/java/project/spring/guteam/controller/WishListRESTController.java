package project.spring.guteam.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import project.spring.guteam.service.WishListService;

@RestController
@RequestMapping("/wishList")
public class WishListRESTController {
	private static final Logger logger = LoggerFactory.getLogger(WishListRESTController.class);
	
	@Autowired
	private WishListService service;
	
	@PostMapping
	public ResponseEntity<Integer> createWishList(@RequestBody WishListVO vo,HttpServletResponse response,HttpServletRequest request){
		int result = 0;
		String thisGameId = Integer.toString(vo.getGameId());
		logger.info("createWishList 실행 wishListVO값 : "+vo.toString());
		Cookie[] cookies = request.getCookies(); 
		if(vo.getMemberId()==null) { //로그인상태가 아닐 시
			for(Cookie cookie : cookies) {
				logger.info("==== 쿠키이름 ===="+cookie.getName());
				
				if(cookie.getName().equals("wishListGameId")) {//이미 쿠키가 존재하는경우
					String existingGameId = cookie.getValue();
					String[] gameIds = existingGameId.split("%");
					for(String gameId : gameIds) {
						if(gameId.equals(thisGameId)) { // gameID가 중복으로 들어갈 경우 즉시 리턴
							return new ResponseEntity<Integer>(result,HttpStatus.OK);
						}
					}
					existingGameId = existingGameId+"%"+thisGameId;
					logger.info(existingGameId);
					cookie = new Cookie("wishListGameId", existingGameId);
					cookie.setMaxAge(60*60*24*3);
					cookie.setPath("/");
					response.addCookie(cookie);
					result=1;
					return new ResponseEntity<Integer>(result,HttpStatus.OK);
				}
			}			
			Cookie cookie = new Cookie("wishListGameId", thisGameId);
			cookie.setMaxAge(60*60*24*3);
			cookie.setPath("/");
			response.addCookie(cookie);
			result=1;
		}else {
		result = service.create(vo);
		logger.info(Integer.toString(result));
		}
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
	@GetMapping("/all/{memberId}")
	public ResponseEntity<List<GameVO>> readWishList(@PathVariable String memberId,HttpServletRequest request){
		logger.info(memberId);
		List<GameVO> list = new ArrayList<GameVO>();
		if(memberId.equals("undefined")) {
		Cookie[] cookies = request.getCookies();
			for(Cookie cookie: cookies) {
				if(cookie.getName().equals("wishListGameId")) {
					String[] gameIdsString = cookie.getValue().split("%");
					List<Integer> gameIds = new ArrayList<Integer>();
					for(int i =0;i<gameIdsString.length;i++) {
						gameIds.add(Integer.parseInt(gameIdsString[i]));
						list = service.read(gameIds);
					}
				}
			}	
		}else {
			list = service.read(memberId);
		}
		return new ResponseEntity<List<GameVO>>(list,HttpStatus.OK);
	}
	@GetMapping("/find/{memberId}")//중복된 값 찾기 용도
	public ResponseEntity<Integer> findWishList(@PathVariable("memberId") String memberId, int gameId,HttpServletRequest request){
		int result=0;
		if(memberId.equals("undefined")) { //로그인이 되어있지 않은 경우
		logger.info("로그인 안되어있음");
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			logger.info("쿠키값 존재함 쿠키값="+cookie.getValue());
			if(cookie.getName().equals("wishListGameId")) { // 게임 ID 쿠키값이 존재하고 
				String[] gameIds = cookie.getValue().split("%");
				for(String thisGameId : gameIds) {
					if(thisGameId.equals(Integer.toString(gameId))) { // 쿠키값 안에 들어있는 게임 ID값과
						result = 1;									  // 현재 게임의 ID값이 같으면 이미 존재 하는 위시리스트로 출력		
						return new ResponseEntity<Integer>(result, HttpStatus.OK);
						}
					}
				}
			}
		}
		WishListVO vo = service.find(memberId, gameId);
		if(vo!=null) {
			result=1;
		}
		return new ResponseEntity<Integer>(result, HttpStatus.OK);
	}
	
	@DeleteMapping("/{memberId}") // 한개만 제거
	public ResponseEntity<Integer> deleteWishList(@PathVariable("memberId")String memberId,@RequestBody int gameId,HttpServletRequest request,HttpServletResponse response){
		logger.info("delete 실행 memberId,gameId= "+memberId+","+gameId);
		int result=0;
		if(memberId.equals("undefined")) { //로그인이 되어있지 않은 경우
			Cookie[] cookies = request.getCookies();
			String afterCookie = "";
			for(Cookie cookie : cookies) {
				logger.info("쿠키값 존재함 쿠키값="+cookie.getValue());
					if(cookie.getName().equals("wishListGameId")) {
					String deleteGameId = Integer.toString(gameId);
					String existingGameId = cookie.getValue();
					String[] gameIds = existingGameId.split("%");
					
					if(existingGameId.equals(deleteGameId)){ // 게임아이디가 한개일 경
						logger.info("한개만 지워지는가");
						Cookie cookietwo = new Cookie("wishListGameId",existingGameId);
						cookietwo.setMaxAge(0);
						cookietwo.setPath("/");
						response.addCookie(cookietwo);
						result=1;
						return new ResponseEntity<Integer>(result,HttpStatus.OK);
					}
					for(int i =0;i<gameIds.length;i++) {
						if(!gameIds[i].equals(deleteGameId)) {
							if(afterCookie.equals("")) {
								afterCookie = gameIds[i];
							}else{
								afterCookie += "%"+gameIds[i];
							}
						}
					}
					cookie = new Cookie("wishListGameId", afterCookie);
					cookie.setMaxAge(60*60*24*3);
					cookie.setPath("/");
					response.addCookie(cookie);
					result=1;
					return new ResponseEntity<Integer>(result,HttpStatus.OK);
					}
				}
			}
		
		WishListVO vo = new WishListVO(memberId, gameId);
		logger.info("컨트롤러 값 : "+vo.toString());
		result = service.delete(vo);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
