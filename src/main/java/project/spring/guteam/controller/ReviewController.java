package project.spring.guteam.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.GameService;
import project.spring.guteam.service.MemberService;
import project.spring.guteam.service.ReviewService;
import project.spring.guteam.service.ThumbService;

@Controller
@RequestMapping(value="/review")
public class ReviewController {
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private ThumbService thumbService;
	
	@Autowired
	private GameService gameService;
	
	@GetMapping("/list")
	public void list(int gameId, Model model, Integer page, Integer numsPerPage) {
		logger.info("review list() 호출");
		PageCriteria criteria = new PageCriteria();
		if(page != null) {
			criteria.setPage(page);
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		List<ReviewVO> list = reviewService.read(gameId, criteria);
		pageMaker.setTotalCount(reviewService.getTotalCount(gameId));
		pageMaker.setPageData();
		model.addAttribute("pageMaker",pageMaker);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < list.size(); i++) {
			String memberId = list.get(i).getMemberId();
			MemberVO memberVO = memberService.read(memberId);
			logger.info(memberVO.toString());
			String nickname = memberVO.getNickname();
			nicknameList.add(nickname);
		}
		model.addAttribute("nicknameList", nicknameList);
		GameVO gameVO = gameService.read(gameId);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("list",list);
	}
	
	@GetMapping("/register")
	public void registerGET(Model model, int gameId) {
		model.addAttribute("gameId", gameId);
	}
	
	@PostMapping("/register")
	public String registerPOST(ReviewVO vo, RedirectAttributes reAttr) {
		int result = reviewService.create(vo);
		if(result == 1 ) {
			reAttr.addFlashAttribute("insert_result","success");
			return "redirect:list?gameId="+vo.getGameId();
		}else {
			return "redirect:register?gameId="+vo.getGameId();
		}
	}
	
	@GetMapping("/detail")
	public void detail(Model model, int reviewId, int page, HttpSession session) {
		ReviewVO reviewVO = reviewService.read(reviewId);
		GameVO gameVO = gameService.read(reviewVO.getGameId());
		model.addAttribute("reviewVO", reviewVO);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("page", page);
		String memberId = "test";//(String)session.getAttribute("memberId")
		ThumbVO thumbVO = thumbService.read(new ThumbVO(reviewId, memberId, 0));
		if(thumbVO!=null) {
			logger.info(thumbVO.toString());
		}
		model.addAttribute("thumbVO",thumbVO);
	}
	
	@GetMapping("/update")
	public void updateGET(Model model, int reviewId, int page) {
		ReviewVO reviewVO = reviewService.read(reviewId);
		model.addAttribute("reviewVO",reviewVO);
		model.addAttribute("page",page);
	}
	
	@PostMapping("/update")
	public String updatePOST(ReviewVO vo, RedirectAttributes reAttr, int page) {
		int result = reviewService.update(vo);
		if(result==1) {
			reAttr.addFlashAttribute("update_result","success");
			return "redirect:detail?reviewId="+vo.getReviewId()+"&page="+page;
		}else {
			return "redirect:update?reviewId="+vo.getReviewId()+"&page="+page;
		}
		
	}
	
	@PostMapping("/delete")
	public String delete(int reviewId, int gameId, RedirectAttributes reAttr) {
		int result = reviewService.delete(reviewId);
		
		if(result==1) {
			reAttr.addFlashAttribute("delete_result","success");
			return "redirect:/review/list?gameId="+gameId;
		}else {
			return "redirect:/review/detail?reviewId="+reviewId+"&gameId="+gameId;
		}
	}

}
