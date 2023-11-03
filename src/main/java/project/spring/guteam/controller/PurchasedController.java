package project.spring.guteam.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.service.PurchasedService;

@Controller
@RequestMapping(value="/purchased")
public class PurchasedController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedController.class);
	
	@Autowired
	PurchasedService purchasedService;
	
	@Resource(name = "downloadPath")
	private String downloadPath;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@GetMapping("/myPurchased")
	public void myPurchased() {}
	
	/*@PostMapping("/myWishList")
	public String wishListPOST(int[] gameIds, int totalPriceInput, Principal principal) {
		logger.info(totalPriceInput + "원");
		logger.info(principal.getName()+ "유저가 고름");
		return "redirect:/purchased/purchaseWindow";
	}*/
	
	  @GetMapping("/purchaseWindow")
	  public void purchaseWindow(Model model,String gameIds, Principal principal) {
		  	logger.info(principal.getName()); // 로그인 되 어있는 아이디
			logger.info(gameIds + "게임"); // 체크해둔 게임들
			
			Map<String, Object> data = purchasedService.readBuyGame(gameIds, principal.getName());
			List<GameVO> list = (List<GameVO>) data.get("list");
			int cash = (int) data.get("cash");
			
			model.addAttribute("list", list);
			model.addAttribute("cash", cash);
  }
	  @GetMapping("/download/{firstDirectory}/{secondDirectory}/{thirdDirectory}/{fileName:.+}") // :.+ <-- 확장자까지 입력
	    public void downloadFile(@PathVariable("fileName") String fileName,
	    		@PathVariable("firstDirectory") String firstDirectory,
	    		@PathVariable("secondDirectory") String secondDirectory,
	    		@PathVariable("thirdDirectory") String thirdDirectory,HttpServletResponse response) throws IOException {
			
			logger.info("1.파일 이름:"+fileName);
			Path sourceFilePath = Paths.get(uploadPath+"/"+firstDirectory+"/"+secondDirectory+"/"+thirdDirectory).resolve(fileName); // Paths.get(경로(String)) 파일 절대 경로 
																		 // resolve(String) String 부분 덧붙이기
	        File sourceFile = sourceFilePath.toFile(); // toFIle : 해당 경로의 파일화
	        logger.info(sourceFilePath.toString());
	        
	        String directoryPath = downloadPath; // 생성하려는 디렉토리 경로
	        Path directory = Paths.get(directoryPath);
	        
	        if (!Files.exists(directory)) {
	            try {
	                Files.createDirectories(directory); // 디렉토리 생성
	                logger.info("다운로드 디렉토리 생성 성공"+directoryPath);
	            } catch (IOException e) {
	                System.err.println("디렉토리 생성 실패: " + e.getMessage());
	            }
	        }
	        
	        if (sourceFile.exists()) { // 소스파일이 업로드 경로에 존재한다면?
	            Path destinationFilePath = Paths.get(downloadPath).resolve(fileName); 
	            File destinationFile = destinationFilePath.toFile();
	          
	            if (!destinationFile.exists()) {
	                Files.copy(sourceFile.toPath(), destinationFile.toPath());
	            }
	            
	            response.setContentType("application/octet-stream");
	            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
	            
	            try (InputStream is = new FileInputStream(destinationFile); // 내용을 출력할 파일
	                 OutputStream os = response.getOutputStream()) {
	                byte[] buffer = new byte[1024];
	                int bytesRead;
	                while ((bytesRead = is.read(buffer)) != -1) {
	                    os.write(buffer, 0, bytesRead);
	                }
	            }//end try
	        }//end if(sourceFile.exists)
	      
	    }
/*	public void purchaseWindow(Model model,int gameId,String memberId) {
		logger.info("구매창으로 이동 게임아디 : , 멤버 아디 : "+gameId+", "+memberId);
		GameVO gameVO = gameService.read(gameId);
		MemberVO memberVO = memberService.read(memberId);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("gameVO", gameVO);
	}*/
}
