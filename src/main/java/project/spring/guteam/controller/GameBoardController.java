package project.spring.guteam.controller;

import java.security.Principal;
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
//		logger.info("gameBoard list 호출");
//		logger.info("page = " + page + ", numsPerPage = "+ numsPerPage);
		readListsAndSetModel(model, gameId, page, numsPerPage, keyword, keywordCriteria, orderBy);		
	} // end list() - [getMapping "/gameBoard/list"]
	
	@GetMapping("/register")
	public void registerGET(Model model, int gameId) {
		model.addAttribute("gameId", gameId);
	} // end registerGET() - [getMapping "/gameBoard/register"]
	
	@PostMapping("/register")
	public String registerPOST(GameBoardVO vo, RedirectAttributes reAttr) {
		int result = gameBoardService.create(vo);
		if(result == 1) {
			reAttr.addFlashAttribute("insert_result","success");
			return "redirect:/gameBoard/list?gameId="+vo.getGameId();   
		}else {
			return "redirect:/gameBoard/register?gameId="+vo.getGameId();
		}
	} // end registerPOST() - [postMapping "/gameBoard/register" => "/gameBoard/list" or "/gameBoard/register"]
	
	@GetMapping("/detail")
	public void detail(Model model, int gameBoardId, Integer page, int gameId, Principal principal) {
		Map<String, Object> args = new HashMap<>();
		if(principal!=null) {
			String memberId = principal.getName(); // 접속한 유저 아이디
			args = gameBoardService.read(gameBoardId, memberId); 			
			// gameBoardId 로 글 정보를 가져오고, memberId 로 댓글에 사용될 회원 정보를 가져옴
		}else {
			args = gameBoardService.read(gameBoardId, "");
		}
		GameBoardVO vo = (GameBoardVO) args.get("gameBoardVO"); 
		String nickname = (String) args.get("nickname");
		// nickname 은 게시판 작성자의 닉네임
		String memberImageName = (String) args.get("memberImageName");
		// memberImageName 은 댓글에 사용될 로그인 한 회원의 프로필 사진 이름
		// 비 로그인시 memberImageName 은 null 값
		model.addAttribute("memberImageName", memberImageName);
		model.addAttribute("nickname", nickname);
		model.addAttribute("vo", vo);
		model.addAttribute("page",page);
		model.addAttribute("gameId", gameId);
	} // end detail() - [getMapping "/gameBoard/detail"]
	
	@GetMapping("/update")
	public void updateGET(Model model, int gameBoardId, Integer page, int gameId) {
		GameBoardVO vo = (GameBoardVO) gameBoardService.read(gameBoardId,"").get("gameBoardVO");
		model.addAttribute("vo", vo);
		model.addAttribute("page",page);
		model.addAttribute("gameId", gameId);
	} // end updateGET() - [getMapping "/gameBoard/update"]
	
	@PostMapping("/update")
	public String updatePOST(GameBoardVO vo, RedirectAttributes reAttr, Integer page, int gameId) {
		int result = gameBoardService.update(vo);
		if(page==null) {
			page=1;
		}
		if(result == 1) {
			reAttr.addFlashAttribute("update_result","success");
			return "redirect:/gameBoard/detail?gameBoardId="+vo.getGameBoardId()+"&page="+page+"&gameId="+vo.getGameId();   
		}else {
			return "redirect:/gameBoard/update?gameBoardId="+vo.getGameBoardId()+"&page="+page+"&gameId="+vo.getGameId();
		}
	} // end updatePOST() - [postMapping "/gameBoard/update" => "/gameBoard/detail" or "/gameBoard/update"]
	
	@PostMapping("/updateDeleted")
	public String updateToDeleted(int gameBoardId, RedirectAttributes reAttr) {
//		logger.info("gameBoard updateDeleted() 호출 : gameBoardId = " + gameBoardId);
		int result = gameBoardService.updateToDeleted(gameBoardId);
		if(result==1) {
			reAttr.addFlashAttribute("delete_result", "success");
			return "redirect:/gameBoard/list?gameId="+((GameBoardVO)gameBoardService.read(gameBoardId,"").get("gameBoardVO")).getGameId();
		}else {
			return "redirect:/gameBoard/detail?gameId="+((GameBoardVO)gameBoardService.read(gameBoardId,"").get("gameBoardVO")).getGameId()+"&gameBoardId="+gameBoardId;
		}
	} // end updateToDeleted() - [postMapping "/gameBoard/updateDeleted" => "/gameBoard/list" or "/gameBoard/detail"]
	
	@GetMapping("/list-ajax/{memberId}")
	public ResponseEntity<Map<String, Object>> readMyBoard(@PathVariable("memberId") String memberId, Integer page){	
//		logger.info("내가 쓴 게시글 조회하기");
		Map<String, Object> args = new HashMap<>();
		PageCriteria criteria = new PageCriteria();
//		logger.info(page+"페이지");
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
	} // end readMyBoard()

	private void readListsAndSetModel(Model model, int gameId, Integer page, Integer numsPerPage,
			String keyword, String keywordCriteria, String orderBy) {
		PageCriteria criteria = new PageCriteria();
		if(page != null) {
			criteria.setPage(page);	
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		if(orderBy==null) {
			orderBy="";
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		List<GameBoardVO> gameBoardVOList = new ArrayList<>();
		List<String> nicknameList = new ArrayList<>();
		Map<String, Object> args = new HashMap<>();
		if(orderBy.equals("commentCnt")) { // 댓글 많은 순서로 정렬
			if(keyword==null||keyword.equals("")) { // 키워드가 없는 경우
				pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId));
				paging(pageMaker, criteria);
				args=gameBoardService.read(gameId, criteria, orderBy);
			}else { // 검색 키워드가 있는 경우
				pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId, criteria, keywordCriteria, keyword));
				paging(pageMaker, criteria);
				args=gameBoardService.read(gameId, criteria, keywordCriteria, keyword, orderBy);
				if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
					model.addAttribute("keywordCriteria", keywordCriteria);
				}
			}
		} else if(keyword==null||keyword.equals("")) { // 정렬 기준이 없고 검색 키워드가 없으면
			pageMaker.setTotalCount(gameBoardService.getTotalCount(gameId));
			paging(pageMaker, criteria);
			args = gameBoardService.read(gameId, criteria);
		} else{ // 정렬 기준이 없고 검색 키워드가 있는 경우
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
		// 조회한 게시판 정보와 작성자 닉네임을 list로 가져와서 model에 add
		GameVO gameVO = (GameVO) args.get("gameVO");
		model.addAttribute("pageMaker",pageMaker);
		model.addAttribute("nicknameList", nicknameList);
		model.addAttribute("gameVO", gameVO);
		model.addAttribute("list",gameBoardVOList);
		
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

} // end GameBoardController
