package project.spring.guteam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ReplyController {
	
	@GetMapping("/replies")
	public void replies() {}
}
