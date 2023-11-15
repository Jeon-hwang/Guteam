package project.spring.guteam.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.apache.tomcat.util.buf.UriUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.URIEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.fileutil.GameImageUploadUtil;
import project.spring.guteam.fileutil.MediaUtil;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.GameService;

@Controller
@RequestMapping(value = "/game")
public class GameController {
	private static final Logger logger = LoggerFactory.getLogger(GameController.class);

	@Autowired
	private GameService gameService;

	@Resource(name = "uploadPath")
	private String uploadPath;

	@GetMapping("/list")
	public void list(Model model, Integer page, Integer numsPerPage, String keyword, String keywordCriteria, String orderBy, Principal principal) {
		logger.info("list 호출");
//		logger.info("page = " + page + ", numsPerPage = " + numsPerPage);
		PageCriteria criteria = new PageCriteria(1, 10);
		if (page != null) {
			criteria.setPage(page);
		}
		if (numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);		
		readListsAndSetModel(keyword, keywordCriteria, pageMaker, criteria, model, orderBy, principal);
	} // end list()

	@GetMapping("/register")
	public void registerGET() {} // end registerGET()

	@PostMapping("/register")
	public String registerPOST(GameVO vo, MultipartFile file, RedirectAttributes reAttr) {
		logger.info("registerPOST 호출 file = " + file);
		if (vo.getGameImageName().equals("basic.png") 
				&& file != null && !file.getOriginalFilename().equals("")) { // ajax 가 아닌 input[type="file"]을 통해 등록 한 경우
			int gameId = gameService.getSeqNo(); // 등록될 게임의 id 를 sequence 조회를 통해 먼저 가져와서 imageName 에 이용
			String extension = "." + file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
			String gameImageName = gameId+extension;
			saveImage(file, vo, gameImageName); // 이미지 파일을 저장
		}
		encodeName(vo); // 이미지 이름을 변환
		int result = gameService.create(vo); // 게임 정보를 등록
		if (result == 1) {
			reAttr.addFlashAttribute("insert_result", "success");
			return "redirect:/game/list";
		} else {
			return "redirect:/game/register";
		}
	} // end registerPOST()

	@GetMapping("/detail")
	public void detail(Model model, int gameId, Principal principal, String prevListUrl) {
		Map<String, Object> args = gameService.readGame(gameId, principal); 
		// 게임 id 로 게임정보를 조회하고 로그인된 아이디가 있다면 viewed 테이블에 정보를 update
		GameVO vo = (GameVO) args.get("vo");
		model.addAttribute("vo", vo);
		int rating = (int) args.get("rating");
		model.addAttribute("rating", rating);
		model.addAttribute("prevListUrl", prevListUrl);
	} // end detail()

	@GetMapping("/update")
	public void updateGET(Model model, int gameId, String prevListUrl, Principal principal) {
		Map<String, Object> args = gameService.readGame(gameId, principal);
		GameVO vo = (GameVO) args.get("vo");
		model.addAttribute("vo", vo);
		try {
			prevListUrl = URLEncoder.encode(prevListUrl, "UTF-8"); // 페이지 정보를 인코딩
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			model.addAttribute("prevListUrl", prevListUrl);
		}
	} // end updateGET()

	@PostMapping("/update")
	public String updatePOST(GameVO vo, RedirectAttributes reAttr, String prevListUrl, MultipartFile file, Principal principal) {
		logger.info("updatePOST() 호출");
//		logger.info(vo + "");
		if (file != null && !file.getOriginalFilename().equals("")) { // input [type="file"] 이 있는 경우
			int gameId = vo.getGameId();
			String extension = "."+file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".")+1);
			String gameImageName = gameId+extension;
			// 확장자와 게임 id 를 통해 파일 명을 지정
			saveImage(file, vo, gameImageName); // 파일을 저장
			encodeName(vo); // 이름을 변환
		}
		if(!vo.getGameImageName().contains("%")) {
			encodeName(vo);
		}
		int result = gameService.update(vo); // 게임 정보를 update
		if (result == 1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/game/detail?gameId=" + vo.getGameId() + "&prevListUrl=" + prevListUrl;
		} else {
			return "redirect:/game/update?gameId=" + vo.getGameId() + "&prevListUrl=" + prevListUrl;
		}
	} // end updatePOST()

	private void readListsAndSetModel(String keyword, String keywordCriteria, PageMaker pageMaker, PageCriteria criteria,
			Model model, String orderBy, Principal principal) {
		Map<String, Object> args = new HashMap<>();
		if(principal!=null&&(keyword==null||keyword.equals(""))&&(keywordCriteria==null||keywordCriteria.equals(""))) {
			// 로그인 정보가 있고, 특정 조건이 없는 경우 회원 정보에 기반하여 게임 정보를 정렬하여 보여줌
			String memberId = principal.getName();
			pageMaker.setTotalCount(gameService.getTotalCount());
			paging(pageMaker, criteria);
			int interestingCount = gameService.getInterestKeywordCnt(memberId);
			if(interestingCount>=3) { // 로그인 정보를 바탕으로 수집한 게임 데이터가 3 이상이면 해당 정렬을 실행 
				args = gameService.readInterestGames(memberId, criteria);
			}else { // 정보가 부족하면 
				if(orderBy==null||orderBy.equals("")) { // 게임 아이디 순서로 내림차순
					args = gameService.readAll(criteria);
				}else { // 정렬 기준 기반 조회
					args = gameService.readOrderBy(keyword, keywordCriteria, orderBy, criteria);
				}
			}
		}else if(keyword==null||keyword.equals("")) { // 로그아웃 상태에서 특정 keyword 조건이 없는 경우 readAll
			pageMaker.setTotalCount(gameService.getTotalCount());
			paging(pageMaker, criteria);
			if(orderBy==null||orderBy.equals("")) {
				args = gameService.readAll(criteria);
			}else { // 정렬 기준만 있는 경우
				args = gameService.readOrderBy(keyword, keywordCriteria, orderBy, criteria);
			}
		}else if(keywordCriteria!=null&&keywordCriteria.equals("keyword")) { // 검색 기준이 keyword 인 경우
			if(orderBy==null||orderBy.equals("")) { // 정렬 기준이 없는 경우
				pageMaker.setTotalCount(gameService.getTotalCountByKeyword(keyword));
				paging(pageMaker, criteria);
				args = gameService.readByKeyword(keyword, criteria);
			}else { // 정렬 기준이 있는 경우
				pageMaker.setTotalCount(gameService.getTotalCountByKeyword(keyword));
				paging(pageMaker, criteria);
				args = gameService.readOrderBy(keyword, keywordCriteria, orderBy, criteria);
			}
		}else if(keywordCriteria!=null&&keywordCriteria.equals("price")) { // 검색 기준이 price 인 경우
			if(orderBy==null||orderBy.equals("")) { // 정렬 기준이 없는 경우 
				int price = Integer.parseInt(keyword);
				pageMaker.setTotalCount(gameService.getTotalCountByPrice(price));
				paging(pageMaker, criteria);
				args = gameService.readByPrice(price, criteria);
			}else { // 정렬 기준이 있는 경우
				pageMaker.setTotalCount(gameService.getTotalCountByPrice(Integer.parseInt(keyword)));
				paging(pageMaker, criteria);
				args = gameService.readOrderBy(keyword, keywordCriteria, orderBy, criteria);
			}
		}else {
			model.addAttribute("targetURL", "/guteam/game/list");
			
			//에러 페이지
		}
		List<GameVO> gameVOList = (List<GameVO>) args.get("gameVOList");
		List<Integer> ratingList = (List<Integer>) args.get("ratingList");
		model.addAttribute("gameVOList", gameVOList);
		model.addAttribute("ratingList", ratingList);
		model.addAttribute("orderBy", orderBy);
		model.addAttribute("keywordCriteria", keywordCriteria);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("keyword", keyword);
//		logger.info(model.toString());
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

	private void encodeName(GameVO vo) {
		// 파일 이름을 변환
		String gameImageName = vo.getGameImageName();
		try {
			gameImageName = URLEncoder.encode(gameImageName, "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		vo.setGameImageName(gameImageName);
	} // end encodeName()

	private void saveImage(MultipartFile file, GameVO vo, String gameImageName) {
		// 파일을 저장
		try {
			logger.info(file.getOriginalFilename());
			vo.setGameImageName(
					GameImageUploadUtil.saveUploadedFile(uploadPath, gameImageName, file.getBytes()));
		} catch (IOException e) {
			e.printStackTrace();
		}
	} // end saveImage()

	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName) {
//		logger.info("display() 호출");
		ResponseEntity<byte[]> entity = null;
		InputStream in = null;
		try {
			fileName = URLDecoder.decode(fileName, "utf-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		if (!(fileName.charAt(0) == '/')) {
			fileName = "/" + fileName;
		}
		String filePath = uploadPath + fileName;
		try {
			in = new FileInputStream(filePath);
			// 파일 확장자
			String extension = filePath.substring(filePath.lastIndexOf(".") + 1);
			// 응답 헤더(response header) 에 Content-Type 설정
			HttpHeaders httpHeaders = new HttpHeaders();
			httpHeaders.setContentType(MediaUtil.getMediaType(extension));
			// 데이터 전송
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), // 파일에서 읽은 데이터
					httpHeaders, // 응답 헤더
					HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	} // end display()
	
	@GetMapping("/list-ajax/{memberId}")
	public ResponseEntity<Map<String, Object>> recentlyViewed(@PathVariable("memberId") String memberId){	
		logger.info("최근 조회한 게임 불러오기");
		Map<String, Object> args = gameService.recentlyViewedGames(memberId);
		return new ResponseEntity<Map<String, Object>>(args, HttpStatus.OK);
	} // end recentlyViewed()
	
	@GetMapping("/{keyword}")
	public ResponseEntity<List<String>> keywords(@PathVariable("keyword") String keyword){
		List<String> keywords = gameService.findKeywords(keyword);
		return new ResponseEntity<List<String>>(keywords, HttpStatus.OK);
	}

	@PostMapping("/upload-ajax")
	public ResponseEntity<String> uploadAjaxPOST(MultipartFile[] files, String gameId) {
		logger.info("uploadAgaxPOST() 호출");
		
		String result = ""; 
		
		for (int i = 0; i < files.length; i++) {
			try {
				String fileName = "";
				if(gameId!=null) { // update에서 등록하는 경우
					fileName=gameId;
				}else { // register에서 등록하는 경우
					fileName = gameService.getSeqNo()+"";
				}
				result = GameImageUploadUtil.saveUploadedFile(uploadPath, fileName+"."+files[i].getOriginalFilename().substring(files[i].getOriginalFilename().lastIndexOf(".")+1),
						files[i].getBytes());
				result = URLEncoder.encode(result, "utf-8");
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	} // end uploadAjaxPOST()

} // end GameController