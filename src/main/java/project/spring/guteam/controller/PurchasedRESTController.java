package project.spring.guteam.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;
import project.spring.guteam.service.PurchasedService;


@RestController
@RequestMapping(value="/purchased")
public class PurchasedRESTController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedRESTController.class);
	
	@Autowired
	private PurchasedService service;
	
	@PostMapping("/buy/{memberId}")
	public ResponseEntity<Integer> insertPurchased(@RequestBody int gameId,@PathVariable("memberId") String memberId,int cash){
			PurchasedVO vo = new PurchasedVO(memberId, gameId, null);
			try {
//				logger.info("cash? "+cash);
				int result = service.create(vo,cash);
				return new ResponseEntity<Integer>(result,HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<Integer>(1,HttpStatus.OK);
			}			 
		}
	@GetMapping("/all/{memberId}")
	public ResponseEntity<Map<String, Object>> readPurchased(@PathVariable("memberId") String memberId){
		logger.info("read 실행");
		List<PurchasedVO> purchasedList = service.read(memberId);
		List<GameVO> gameList = service.readGame(memberId);
		HashMap<String , Object> args = new HashMap<String, Object>();
		args.put("purchasedList", purchasedList);
		args.put("gameList", gameList);
		return new ResponseEntity<Map<String,Object>>(args,HttpStatus.OK);
	}
	
	@GetMapping("/find/{memberId}")
	public ResponseEntity<PurchasedVO> findPurchaseㅇ(@PathVariable("memberId") String memberId, int gameId){
		logger.info("findPurchased 실행");
		PurchasedVO vo = service.find(memberId, gameId);
		if(vo!=null) {
		logger.info("vo : "+vo.toString());
		return new ResponseEntity<PurchasedVO>(vo, HttpStatus.OK);
		}else {
		return null;
		}	
	}
	
	@GetMapping("findFriends/{memberId}")
	public ResponseEntity<Map<String, Object>> findFriendOwnGame(@PathVariable("memberId") String memberId, int gameId){
			Map<String, Object> data = service.findFriends(memberId, gameId);
			logger.info(data.toString());
		return new ResponseEntity<Map<String, Object>>(data,HttpStatus.OK);		
	}
	//"../purchased/findFriends/"+memberId+'?gameId='+gameId;
}
