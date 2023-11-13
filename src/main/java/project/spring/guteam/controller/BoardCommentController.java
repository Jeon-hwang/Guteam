package project.spring.guteam.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.guteam.service.BoardCommentService;

@Controller
@RequestMapping(value="/boardComment")
public class BoardCommentController {

	@Autowired BoardCommentService service;
	
	@GetMapping("/comment_and_reply_test")
	public void commentAndReplyTest() {}
	
}