package project.spring.guteam.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.annotation.JsonProperty;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;
import project.spring.guteam.service.PurchasedService;


@RestController
@RequestMapping(value="/purchased")
public class PurchasedRESTController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedRESTController.class);
	
	@Autowired
	private PurchasedService service;

	@Resource(name = "downloadPath")
	private String downloadPath;
	
	@PostMapping("/buy/{memberId}")
	public ResponseEntity<Integer> insertPurchased(@RequestBody int gameId,@PathVariable("memberId") String memberId,int price){
			PurchasedVO vo = new PurchasedVO(memberId, gameId, null);
			try {
//				logger.info("cash? "+cash);
				int result = service.create(vo,price);
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
		for(GameVO vo : gameList) {
			String gameImageName=vo.getGameImageName();
			try {
				gameImageName = (URLDecoder.decode(vo.getGameImageName(),"utf-8"));
				gameImageName = gameImageName.replaceAll("%2F", "/");
				logger.info(gameImageName);
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			} 
			vo.setGameImageName(gameImageName);
		}
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
	
	@GetMapping(value="check/{fileName:.+}")
	public ResponseEntity<String> checkFile(@PathVariable String fileName) {
		logger.info("파일 확인 : "+fileName);
		String result="N";
		String userPath = System.getProperty("user.home");
		Path sourceFilePath = Paths.get(userPath+downloadPath).resolve(fileName);
		File sourceFile = sourceFilePath.toFile();
		logger.info(sourceFilePath.toString());
		if(sourceFile.exists()) { //소스파일이 다운로드 경로에 존재한다면?
			logger.info("존재.. 합니까!!?");
			result = "Y"; // check이 true 면 다운로드 버튼을 - > 실행버튼으로
			logger.info("result = "+result);
		}		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PutMapping("/cashUpdate/{memberId}")
	@JsonProperty("cash")
	public ResponseEntity<Integer> updateCash(@PathVariable String memberId,@RequestBody Integer cash){
		logger.info("캐쉬 업데이트!");
		int result = service.updateCash(memberId, cash);
		return new ResponseEntity<Integer>(result,HttpStatus.OK);
	}
}
