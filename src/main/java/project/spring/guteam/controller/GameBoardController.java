package project.spring.guteam.controller;

import java.util.ArrayList;
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

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.GameBoardService;

@Controller
@RequestMapping(value="/gameBoard")
public class GameBoardController {
	private static final Logger logger = LoggerFactory.getLogger(GameBoardController.class);
	
	@Autowired
	private GameBoardService gameBoardService;
		
	@GetMapping("/list")
	public void list(Model model, int gameId, Integer page, Integer numsPerPage, String keywordCriteria, String keyword, String orderBy) {
		if(orderBy==null) {
			orderBy="";
		}
		logger.info("gameBoard list 호출");
		logger.info("page = " + page + ", numsPerPage = "+ numsPerPage);
		readListsAndSetModel(model, gameId, page, numsPerPage, keyword, keywordCriteria, orderBy);		
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
	public void detail(Model model, int gameBoardId, Integer page, int gameId) {
		if(page==null) {
			page=1;
		}
		GameBoardVO vo = (GameBoardVO) gameBoardService.read(gameBoardId).get("gameBoardVO");
		String nickname = (String) gameBoardService.read(gameBoardId).get("nickname");
		model.addAttribute("nickname", nickname);
		model.addAttribute("vo", vo);
		model.addAttribute("page",page);
		model.addAttribute("gameId", gameId);
	}
	
	@GetMapping("/update")
	public void update(Model model, int gameBoardId, Integer page, int gameId) {
		if(page==null) {
			page=1;
		}
		GameBoardVO vo = (GameBoardVO) gameBoardService.read(gameBoardId).get("gameBoardVO");
		model.addAttribute("vo", vo);
		model.addAttribute("page",page);
		model.addAttribute("gameId", gameId);
	}
	
	@PostMapping("/update")
	public String update(GameBoardVO vo, RedirectAttributes reAttr, Integer page, int gameId) {
		if(page==null) {
			page=1;
		}
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
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/gameBoard/list?gameId="+((GameBoardVO)gameBoardService.read(gameBoardId).get("gameBoardVO")).getGameId();
		}else {
			return "redirect:/gameBoard/detail?gameId="+((GameBoardVO)gameBoardService.read(gameBoardId).get("gameBoardVO")).getGameId()+"&gameBoardId="+gameBoardId;
		}
	}
	
	@GetMapping("/list-ajax/{memberId}")
	public ResponseEntity<Map<String, Object>> readMyBoard(@PathVariable("memberId") String memberId, Integer page){	
		logger.info("내가 쓴 게시글 조회하기");
		Map<String, Object> args = new HashMap<>();
		PageCriteria criteria = new PageCriteria();
		logger.info(page+"페이지");
		if(page != null) {
			criteria.setPage(page);	
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(gameBoardService.getCntMyBoard(memberId));
		paging(pageMaker, criteria);
		List<GameBoardVO> list = gameBoardService.readMyBoard(memberId, criteria);
		args.put("list", list);
		args.put("pageMaker", pageMaker);
		return new ResponseEntity<Map<String, Object>>(args, HttpStatus.OK);
	}

	private void readListsAndSetModel(Model model, int gameId, Integer page, Integer numsPerPage,
			String keyword, String keywordCriteria, String orderBy) {
		PageCriteria criteria = new PageCriteria();
		if(page != null) {
			criteria.setPage(page);	
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		List<GameBoardVO> gameBoardVOList = new ArrayList<>();
		List<String> nicknameList = new ArrayList<>();
		Map<String, Object> args = new HashMap<>();
		if(orderBy.equals("commentCnt")) {
			if(keyword==null||keyword.equals("")) {
				pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId));
				paging(pageMaker, criteria);
				args=gameBoardService.read(gameId, criteria, orderBy);
			}else {
				pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId, criteria, keywordCriteria, keyword));
				paging(pageMaker, criteria);
				args=gameBoardService.read(gameId, criteria, keywordCriteria, keyword, orderBy);
				if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
					model.addAttribute("keywordCriteria", keywordCriteria);
				}
			}
		} else if(keyword==null||keyword.equals("")) {
			pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId));
			paging(pageMaker, criteria);
			args = gameBoardService.read(gameId, criteria);
			
		} else{
			pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId, criteria, keywordCriteria, keyword));
			paging(pageMaker, criteria);
			args = gameBoardService.read(gameId, criteria, keywordCriteria, keyword);
			model.addAttribute("keyword", keyword);
			if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
				model.addAttribute("keywordCriteria", keywordCriteria);
			}
		}
		gameBoardVOList = (List<GameBoardVO>) args.get("gameBoardVOList");
		nicknameList = (List<String>) args.get("nicknameList");
		GameVO gameVO = (GameVO) args.get("gameVO");
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("nicknameList", nicknameList);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("list",gameBoardVOList);
		
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
