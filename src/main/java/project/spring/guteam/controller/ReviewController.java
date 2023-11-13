package project.spring.guteam.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.ReviewService;

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
	} // end list()

	@GetMapping("/register")
	public void registerGET(Model model, int gameId) {
		model.addAttribute("gameId", gameId);
	} // end registerGET()

	@PostMapping("/register")
	public String registerPOST(ReviewVO vo, RedirectAttributes reAttr) {
		int result = reviewService.create(vo);
		if (result == 1) {
			reAttr.addFlashAttribute("insert_result", "success");
			return "redirect:list?gameId=" + vo.getGameId();
		} else {
			return "redirect:register?gameId=" + vo.getGameId();
		}
	} // end registerPOST()

	@GetMapping("/detail")
	public void detail(Model model, int reviewId, Integer page, Principal principal) {
		Map<String, Object> args = new HashMap<>();
		// 로그인 정보가 있으면 로그인 정보로 해당 리뷰에 추천을 하였는지 조회
		if (principal != null) {
			args = reviewService.read(reviewId, principal.getName());
			ThumbVO thumbVO = (ThumbVO) args.get("thumbVO");
			if (thumbVO != null) {
				// thumbVO = 로그인 한 유저가 해당 리뷰에 대해 thumb up / down 한 정보
//				logger.info(thumbVO.toString());
				model.addAttribute("thumbVO", thumbVO);
			}
		} else {
			args = reviewService.read(reviewId, "");
		}
		ReviewVO reviewVO = (ReviewVO) args.get("reviewVO");
		// reviewVO = 리뷰 정보
		String nickname = (String) args.get("nickname");
		// nickname = 작성자 닉네임
		GameVO gameVO = (GameVO) args.get("gameVO");
//		logger.info(reviewVO.toString());
		model.addAttribute("nickname", nickname);
		model.addAttribute("reviewVO", reviewVO);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("page", page);
	} // end detail()

	@GetMapping("/update")
	public void updateGET(Model model, int reviewId, Integer page) {
		ReviewVO reviewVO = (ReviewVO) reviewService.read(reviewId, "").get("reviewVO");
		model.addAttribute("reviewVO", reviewVO);
		model.addAttribute("page", page);
	} // end updateGET()

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

	} // end updatePOST()

	@PostMapping("/delete")
	public String delete(int reviewId, int gameId, RedirectAttributes reAttr) {
		int result = reviewService.delete(reviewId);
		if (result == 1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/review/list?gameId=" + gameId;
		} else {
			return "redirect:/review/detail?reviewId=" + reviewId + "&gameId=" + gameId;
		}
	} // end delete()
	
	@GetMapping("/list-ajax/{memberId}")
	public ResponseEntity<Map<String, Object>> readMyReview(@PathVariable("memberId") String memberId, Integer page){
		logger.info("내가 쓴 리뷰 조회하기");
		Map<String, Object> args = new HashMap<>();
		PageCriteria criteria = new PageCriteria();
//		logger.info(page+"페이지");
		if(page != null) {
			criteria.setPage(page);	
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(reviewService.getCntMyReview(memberId));
		paging(pageMaker, criteria);
		List<ReviewVO> list = reviewService.readMyReview(memberId, criteria);
		args.put("list", list);
		args.put("pageMaker", pageMaker);
		return new ResponseEntity<Map<String, Object>>(args, HttpStatus.OK);
	} // end readMyReview()

	private void readListsAndSetModel(Model model, int gameId, PageCriteria criteria, PageMaker pageMaker,
			Principal principal, String keyword, String orderBy) {
		Map<String, Object> args=null;
		if(orderBy!=null&&orderBy.equals("thumbUpCnt")) { // 추천많은 순 정렬일 경우
			if (keyword != null && !keyword.equals("")) { // 검색 키워드가 있는 경우
				pageMaker.setTotalCount(reviewService.getTotalCount(gameId, keyword));
				paging(pageMaker, criteria);
				args = reviewService.read(orderBy, criteria, keyword, gameId);
			} else { // 검색 키워드가 없는 경우
				pageMaker.setTotalCount(reviewService.getTotalCount(gameId));
				paging(pageMaker, criteria);
				args = reviewService.read(orderBy, gameId, criteria);
			}
		}else if (keyword != null && !keyword.equals("")) { // 정렬이 없고 검색 키워드만 있는 경우
			pageMaker.setTotalCount(reviewService.getTotalCount(gameId, keyword));
			paging(pageMaker, criteria);
			args = reviewService.read(gameId, criteria, keyword);
		} else { // 정렬이 없고 검색 키워드도 없는 경우
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
		// 로그인 정보가 있으면 리뷰를 썼는지 확인하여 리뷰 id 를 리턴(리뷰를 쓴 기록이 없으면 null)
		int writedReviewId = 0;
		if (principal != null) { 
			writedReviewId = reviewService.readWrited(gameId, principal.getName());
			model.addAttribute("writedReviewId", writedReviewId);
		}
	} // end readListsAndSetModel()

	private void paging(PageMaker pageMaker, PageCriteria criteria) {
		// 페이지 정보를 바탕으로 페이지의 한계를 벗어날 경우 한계로 페이지를 재설정
		pageMaker.setPageData();
		if (criteria.getPage() > pageMaker.getEndPageNo()) {
			criteria.setPage(pageMaker.getEndPageNo());
		} else if (criteria.getPage() <= 0) {
			criteria.setPage(1);
		}
		pageMaker.setPageData();
	} // end paging()
} // end ReviewController
