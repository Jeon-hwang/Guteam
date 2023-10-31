package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller // @Component
@RequestMapping(value = "/message")
public class MessageController {
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	// 쪽지함 메인
	@GetMapping("/list")
	public void listGET() {
		logger.info("msg-listGET() 호출 ");
	}
	
}
