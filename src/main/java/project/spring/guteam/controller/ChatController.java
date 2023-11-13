package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/chat")
public class ChatController {
	static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@GetMapping()
	public String chat() {
		return "/chat";
	} // end chat() - [getMapping = "/chat"]

} // end ChatController
