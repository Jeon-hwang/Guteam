package project.spring.guteam.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.guteam.domain.FriendRequestVO;
import project.spring.guteam.service.FriendRequestService;

@Controller // @Component
@RequestMapping(value = "/friendReq")
public class FriendRequestController {
	private static final Logger logger = LoggerFactory.getLogger(FriendRequestController.class);
	
	@Autowired
	FriendRequestService friendRequestService;
	
	// 친구 요청
	@PostMapping("/addFriend")
	public String addFriend (FriendRequestVO vo, HttpSession session) {
		logger.info("addFriend() vo = " + vo.toString());
		int result = friendRequestService.create(vo);
		if(result == 1) {
			logger.info("친구 요청 성공");
			return "redirect:/member/friends";
		} else {
			logger.info("친구 요청 실패");
			return "redirect:/member/friends";
		}
	}
	
	// 받은 요청 조회
	
	
}
