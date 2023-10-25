package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.service.GameService;
import project.spring.guteam.service.MemberService;

@Controller
@RequestMapping(value="/purchased")
public class PurchasedController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedController.class);
	
	@Autowired
	GameService gameService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/myPurchased")
	public void myPurchased() {}
	
  @GetMapping("/purchaseWindow")
  public void purchaseWindow() {}
/*	public void purchaseWindow(Model model,int gameId,String memberId) {
		logger.info("구매창으로 이동 게임아디 : , 멤버 아디 : "+gameId+", "+memberId);
		GameVO gameVO = gameService.read(gameId);
		MemberVO memberVO = memberService.read(memberId);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("gameVO", gameVO);
	}*/
}
