package project.spring.guteam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.fileutil.FileUploadUtil;
import project.spring.guteam.fileutil.MediaUtil;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
import project.spring.guteam.service.GameService;

@Controller
@RequestMapping(value="/game")
public class GameController {
	private static final Logger logger = LoggerFactory.getLogger(GameController.class);
	
	@Autowired
	private GameService gameService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	@GetMapping("/list")
	public void list(Model model, Integer page, Integer numsPerPage, String keyword) {
		logger.info("list 호출");
		logger.info("page = " + page + ", numsPerPage = "+ numsPerPage);
		PageCriteria criteria = new PageCriteria();
		if(page != null) {
			criteria.setPage(page);
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		List<GameVO> list;
		if(keyword==null) {
			list = gameService.read(criteria);
		}else {
			list = gameService.read(keyword, criteria);
		}
		model.addAttribute("list",list);
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(gameService.getTotalCount());
		pageMaker.setPageData();
		model.addAttribute("pageMaker",pageMaker);
	}
	
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	@PostMapping("/register")
	public String registerPOST(GameVO vo, RedirectAttributes reAttr) {
		int result = gameService.create(vo);
		if(result==1) {
			reAttr.addFlashAttribute("insert_result","success");
			return "redirect:/game/list";   
		}else {
			return "redirect:/game/register";   
		}
	}
	
	@GetMapping("/detail")
	public void detail(Model model, int gameId, int page) {
		GameVO vo = gameService.read(gameId);
		model.addAttribute("vo",vo);
		model.addAttribute("page", page);
	}
	
	@GetMapping("/update")
	public void updateGET(Model model, int gameId, int page) {
		GameVO vo = gameService.read(gameId);
		model.addAttribute("vo", vo);
		model.addAttribute("page", page);
	}
	
	@PostMapping("/update")
	public String updatePOST(GameVO vo, RedirectAttributes reAttr, int page) {
		logger.info("updatePOST() 호출");
		logger.info(vo+"");
		int result = gameService.update(vo);
		if(result==1) {
			reAttr.addFlashAttribute("update_result", "success");
			return "redirect:/game/detail?gameId="+vo.getGameId()+"&page="+page;
		}else {
			return "redirect:/game/update?gameId="+vo.getGameId();
		}
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> display(String fileName){
		logger.info("display() 호출");
		
		ResponseEntity<byte[]> entity = null;
		
		InputStream in = null;
		
		if(!(fileName.charAt(0)=='/')) {
			fileName = "/"+fileName;
		}
		
		String filePath = uploadPath + fileName;
		
		try {
			in = new FileInputStream(filePath);
			// 파일 확장자
			String extension = filePath.substring(filePath.lastIndexOf(".")+1);
			logger.info(extension);
			
			// 응답 헤더(response header) 에 Content-Type 설정
			HttpHeaders httpHeaders = new HttpHeaders();
			httpHeaders.setContentType(MediaUtil.getMediaType(extension));
			// 데이터 전송
			entity = new ResponseEntity<byte[]>(
					IOUtils.toByteArray(in), // 파일에서 읽은 데이터
					httpHeaders, // 응답 헤더
					HttpStatus.OK
					);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return entity;
	}

	@PostMapping("/upload-ajax")
	public ResponseEntity<String> uploadAjaxPOST(MultipartFile[] files){
		logger.info("uploadAgaxPOST() 호출");
		// 파일 하나만 저장
		String result = ""; // result  : 파일 경로 및 썸네일 이미지 이름
		 for ( int i = 0 ; i < files.length; i++){
		try {
			result = FileUploadUtil.saveUploadedFile(uploadPath, files[i].getOriginalFilename(), files[i].getBytes());
		} catch (IOException e) {
			e.printStackTrace();
		}
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	private String saveUploadFile(MultipartFile file) {
		SimpleDateFormat sdf = new SimpleDateFormat("MMddhhmmss");
		String date = sdf.format(new Date());
		String savedName =  date+ "_" + file.getOriginalFilename();
		File target = new File(uploadPath, savedName);
		
		try {
			FileCopyUtils.copy(file.getBytes(), target);
			return savedName;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		} 
	}
}
