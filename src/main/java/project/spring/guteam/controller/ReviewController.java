package project.spring.guteam.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
@RequestMapping(value = "/review")
public class ReviewController {
	private static Logger logger = LoggerFactory.getLogger(ReviewController.class);

	@Autowired
	private ReviewService reviewService;

	@GetMapping("/list")
	public void list(int gameId, Model model, Integer page, Integer numsPerPage, Principal principal, String keyword, String orderBy) {
		logger.info("review list() 호출");
		PageCriteria criteria = new PageCriteria();
		if (page != null) {
			criteria.setPage(page);
		}
		if (numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		readListsAndSetModel(model, gameId, criteria, pageMaker, principal, keyword, orderBy);
	}

	@GetMapping("/register")
	public void registerGET(Model model, int gameId) {
		model.addAttribute("gameId", gameId);
	}

	@PostMapping("/register")
	public String registerPOST(ReviewVO vo, RedirectAttributes reAttr) {
		int result = reviewService.create(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("insert_result", "success");
			return "redirect:list?gameId=" + vo.getGameId();
		} else {
			return "redirect:register?gameId=" + vo.getGameId();
		}
	}

	@GetMapping("/detail")
	public void detail(Model model, int reviewId, Integer page, Principal principal) {
		if(page==null) {
			page=1;
		}
		Map<String, Object> args = null;
		if (principal != null) {
			args = reviewService.read(reviewId, principal.getName());
		} else {
			args = reviewService.read(reviewId, "");
		}
		ReviewVO reviewVO = (ReviewVO) args.get("reviewVO");
		GameVO gameVO = (GameVO) args.get("gameVO");
		if (principal != null) {
			ThumbVO thumbVO = (ThumbVO) args.get("thumbVO");
			if (thumbVO != null) {
				logger.info(thumbVO.toString());
				model.addAttribute("thumbVO", thumbVO);
			}
		}
		logger.info(reviewVO.toString());
		model.addAttribute("reviewVO", reviewVO);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("page", page);
	}

	@GetMapping("/update")
	public void updateGET(Model model, int reviewId, Integer page) {
		if(page==null) {
			page=1;
		}
		ReviewVO reviewVO = (ReviewVO) reviewService.read(reviewId, "").get("reviewVO");
		model.addAttribute("reviewVO", reviewVO);
		model.addAttribute("page", page);
	}

	@PostMapping("/update")
	public String updatePOST(ReviewVO vo, RedirectAttributes reAttr, Integer page) {
		if(page==null) {
			page=1;
		}
		int result = reviewService.update(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:detail?reviewId=" + vo.getReviewId() + "&page=" + page;
		} else {
			return "redirect:update?reviewId=" + vo.getReviewId() + "&page=" + page;
		}

	}

	@PostMapping("/delete")
	public String delete(int reviewId, int gameId, RedirectAttributes reAttr) {
		int result = reviewService.delete(reviewId);
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/review/list?gameId=" + gameId;
		} else {
			return "redirect:/review/detail?reviewId=" + reviewId + "&gameId=" + gameId;
		}
	}

	private void readListsAndSetModel(Model model, int gameId, PageCriteria criteria, PageMaker pageMaker,
			Principal principal, String keyword, String orderBy) {
		Map<String, Object> args=null;
		if(orderBy!=null&&orderBy.equals("thumbUpCnt")) {
			if (keyword != null && !keyword.equals("")) {
				pageMaker.setTotalCount(reviewService.getTotalCount(gameId, keyword));
				paging(pageMaker, criteria);
				args = reviewService.read(orderBy, criteria, keyword, gameId);
			} else {
				pageMaker.setTotalCount(reviewService.getTotalCount(gameId));
				paging(pageMaker, criteria);
				args = reviewService.read(orderBy, gameId, criteria);
			}
		}else if (keyword != null && !keyword.equals("")) {
			pageMaker.setTotalCount(reviewService.getTotalCount(gameId, keyword));
			paging(pageMaker, criteria);
			args = reviewService.read(gameId, criteria, keyword);
		} else {
			pageMaker.setTotalCount(reviewService.getTotalCount(gameId));
			paging(pageMaker, criteria);
			args = reviewService.read(gameId, criteria);
		}
		List<ReviewVO> reviewList = (List<ReviewVO>) args.get("reviewList");
		List<String> nicknameList = (List<String>) args.get("nicknameList");
		GameVO gameVO = (GameVO) args.get("gameVO");
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("nicknameList", nicknameList);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("reviewList", reviewList);
		int writedReviewId = 0;
		if (principal != null) {
			writedReviewId = reviewService.readWrited(gameId, principal.getName());
		}
		model.addAttribute("writedReviewId", writedReviewId);
	}

	private void paging(PageMaker pageMaker, PageCriteria criteria) {
		pageMaker.setPageData();
		if (criteria.getPage() > pageMaker.getEndPageNo()) {
			criteria.setPage(pageMaker.getEndPageNo());
		} else if (criteria.getPage() <= 0) {
			criteria.setPage(1);
		}
		pageMaker.setPageData();
	}
}
