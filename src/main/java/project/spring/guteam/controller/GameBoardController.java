package project.spring.guteam.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.GameBoardService;
import project.spring.guteam.service.GameService;
import project.spring.guteam.service.MemberService;

@Controller
@RequestMapping(value="/gameBoard")
public class GameBoardController {
	private static final Logger logger = LoggerFactory.getLogger(GameBoardController.class);
	
	@Autowired
	private GameBoardService gameBoardService;
	
	@Autowired
	private GameService gameService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/list")
	public void list(Model model, int gameId,Integer page, Integer numsPerPage, String keywordCriteria, String keyword) {
		logger.info("gameBoard list 호출");
		logger.info("page = " + page + ", numsPerPage = "+ numsPerPage);
		PageCriteria criteria = new PageCriteria();
		if(page != null) {
			criteria.setPage(page);	
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		List<GameBoardVO> list;
		if(keyword==null) {
			list = gameBoardService.read(gameId, criteria);
			pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId));
		}else{
			list = gameBoardService.read(gameId, criteria, keywordCriteria, keyword);
			pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId, keywordCriteria, keyword));
		}
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
	public String registerPOST(GameBoardVO vo, RedirectAttributes reAttr) {
		int result = gameBoardService.create(vo);
		if(result == 1) {
			reAttr.addFlashAttribute("insert_result","success");
			return "redirect:/gameBoard/list?gameId="+vo.getGameId();   
		}else {
			return "redirect:/gameBoard/register?gameId="+vo.getGameId();
		}
	}
	
	@GetMapping("/detail")
	public void detail(Model model, int gameBoardId, int page, int gameId) {
		GameBoardVO vo = gameBoardService.read(gameBoardId);
		model.addAttribute("vo", vo);
		model.addAttribute("page",page);
		model.addAttribute("gameId", gameId);
	}
	
	@GetMapping("/update")
	public void update(Model model, int gameBoardId, int page, int gameId) {
		GameBoardVO vo = gameBoardService.read(gameBoardId);
		model.addAttribute("vo", vo);
		model.addAttribute("page",page);
		model.addAttribute("gameId", gameId);
	}
	
	@PostMapping("/update")
	public String update(GameBoardVO vo, RedirectAttributes reAttr, int page, int gameId) {
		int result = gameBoardService.update(vo);
		if(result == 1) {
			reAttr.addFlashAttribute("update_result","success");
			return "redirect:/gameBoard/detail?gameBoardId="+vo.getGameBoardId()+"&page="+page+"&gameId="+gameId;   
		}else {
			return "redirect:/gameBoard/update?gameBoardId="+vo.getGameBoardId()+"&page="+page+"&gameId="+gameId;
		}
	}
	
	@PostMapping("/updateDeleted")
	public String updateDeleted(int gameBoardId, RedirectAttributes reAttr) {
		logger.info("gameBoard updateDeleted() 호출 : gameBoardId = " + gameBoardId);
		int result = gameBoardService.update(gameBoardId);
		if(result==1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/gameBoard/list?gameId="+gameBoardService.read(gameBoardId).getGameId();
		}else {
			return "redirect:/gameBoard/detail?gameId="+gameBoardService.read(gameBoardId).getGameId()+"&gameBoardId="+gameBoardId;
		}
	}

}
