package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.domain.PurchasedVO;

@RestController
public class PurchasedRESTController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedRESTController.class);
	
	public ResponseEntity<PurchasedVO> insertPurchased(){
		PurchasedVO vo = null;
		
		return new ResponseEntity<PurchasedVO>(vo,HttpStatus.OK);
	}
}
