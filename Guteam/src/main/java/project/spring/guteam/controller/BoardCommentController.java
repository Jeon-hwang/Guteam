package project.spring.guteam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BoardCommentController {

	@GetMapping("board_comment/comment_and_reply_test")
	public void commentAndReplyTest() {}
}
