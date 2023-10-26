package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import project.spring.guteam.service.PurchasedService;


@RestController
@RequestMapping(value="/purchased/buy")
public class PurchasedRESTController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedRESTController.class);
	
	@Autowired
	private PurchasedService service;
	
	@PostMapping
	public ResponseEntity<Integer> insertPurchased(@RequestBody String data){
		logger.info("insertControll 실행");
		logger.info(data);

			return new ResponseEntity<Integer>(1,HttpStatus.OK); 
		}
		
		
	
}
