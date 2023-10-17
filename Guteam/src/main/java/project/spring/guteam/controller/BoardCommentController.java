package project.spring.guteam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/boardComment")
public class BoardCommentController {

	@GetMapping("/comment_and_reply_test")
	public void commentAndReplyTest() {}
	
}
          