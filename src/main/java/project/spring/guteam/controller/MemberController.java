package project.spring.guteam.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.fileutil.FileUploadUtil;
import project.spring.guteam.fileutil.MediaUtil;
import project.spring.guteam.service.MemberService;


@Controller // @Component
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	// 로그인 화면
	@GetMapping("/login")
	public void loginGET(HttpServletRequest request, Model model, String targetURL) {
		logger.info("loginGET() 호출");
		logger.info(targetURL);
		if(targetURL != null) {
			model.addAttribute("targetURL", targetURL);	
		}
		logger.info("referer = " + request.getHeader("referer"));
		String referer = request.getHeader("referer");
		model.addAttribute("referer", referer);
	}

	// 로그인
	@PostMapping("/login")
	public String loginPOST(String memberId, String password, String targetURL, HttpServletRequest request, RedirectAttributes reAttr) {
		logger.info("loginPOST() 호출");
		if(memberService.read(memberId, "checking")==1) {
			if(!passwordEncoder.matches(password, memberService.read(memberId).getPassword())) {		
				logger.info("로그인 실패 targetURL = " + targetURL);
				reAttr.addFlashAttribute("alert", "loginFail");
			}
		} else {
			reAttr.addFlashAttribute("alert", "loginFail");
		}
		return "redirect:/member/login?error=1&targetURL=" + targetURL ;
	} //end loginPOST()
		
	// id 중복체크
	@PostMapping("/checkId")
	@ResponseBody
	public String checkIdPOST(String memberId) {
		logger.info("checkIdPOST() 호출");
		int result = memberService.read(memberId, "check");
		logger.info("memberService.read(memberId, \"check\") 값 = " +result);
		if (result == 1) {
			logger.info("id 있음 " + result);
			return "success";
		} else {
			logger.info("id 없음 " + result);
			return "fail";
		}
	}
	
	// 닉네임 중복 확인
	@PostMapping("/checkNickname")
	@ResponseBody
	public String checkNicknamePOST(String nickname) {
		logger.info("checkNicknamePOST() 호출");
		int result = memberService.read(nickname, 1);
		logger.info("memberService.read(nickname, \"check\") 값 = " +result);
		if (result == 1) {
			logger.info("id 있음 " + result);
			return "dupl";
		} else {
			return "";
		}
	}

	// 회원가입 화면
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() 호출");
	}

	// 회원가입 등록
	@PostMapping("/register")
	public String registerPOST(MemberVO vo, RedirectAttributes reAttr) {
		logger.info("registerPOST() 호출");
		logger.info(vo.toString());

		int result = memberService.create(vo);
		logger.info(result + " 행 삽입");
		if (result == 1) {
			reAttr.addFlashAttribute("alert", "success");
			return "redirect:/member/login";
		} else {
			return "redirect:/member/register";
		}
	} //end registerPOST()
	
	
	// 마이페이지
	@GetMapping("/profiles")
	public void profilesGET(Model model, Principal principal) {
		logger.info("profilesGET() 호출");
		MemberVO vo = new MemberVO();
		String memberId = principal.getName();
		vo = memberService.read(memberId);
		model.addAttribute("vo", vo);
		logger.info(vo.toString());
	}
	
	// 회원정보 수정
	@GetMapping("/update")
	public void updateGET(Model model, Principal principal) {
		logger.info("updateGET() 호출");
		MemberVO vo = new MemberVO();
		String memberId = principal.getName();
		vo = memberService.read(memberId);
		model.addAttribute("vo", vo);
		logger.info(vo.toString());
		
	}
	
	@PostMapping("/update")
	public String updatePOST(MemberVO vo, MultipartFile file, RedirectAttributes reAttr) {	
		logger.info("updatePOST() 호출 : " + vo.toString());
		if(file.getOriginalFilename().equals("")) {
			
		}else {
			String savedFile = "";
			logger.info("파일 이름 : " + file.getOriginalFilename());
			try {
				savedFile = FileUploadUtil.saveUploadedFile(uploadPath, file.getOriginalFilename(), file.getBytes());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			logger.info("savedFile = " + savedFile);
			vo.setMemberImageName(savedFile);			
		}
		int result = memberService.update(vo, "N");
		
		if(result == 1) {
			reAttr.addFlashAttribute("udp_alert", "success");
			logger.info("수정 완료");
			return "redirect:/member/profiles";
		} else {
			logger.info("수정 실패");
			return "redirect:/member/update";
		}
		
	} //end updatePOST()
	
	// 회원 탈퇴
	@PostMapping("/delete")
	public String delete(String memberId, Principal principal, RedirectAttributes reAttr) {
		logger.info("delete() 호출 memberId = " + principal);
		
		int result = memberService.delete(memberId);
		if(result == 1) {
			logger.info("탈퇴 성공");
			reAttr.addFlashAttribute("alert", "success");
			SecurityContextHolder.clearContext();
			return "redirect:/";
		} else {
			logger.info("탈퇴 실패");
			reAttr.addFlashAttribute("alert", "fail");
			return "redirect:/";
		}
	} //end delete()
	
	// 미리보기
	@GetMapping("/display")
    public ResponseEntity<byte[]> display(String fileName) {
        logger.info("display() 호출 fileName = " + fileName);
        
        ResponseEntity<byte[]> entity = null;
        InputStream in = null;
        
        // 없을때 넣는 조건
        if(!(fileName.charAt(0) == '/')) {
        	fileName = "/" + fileName;
        }
        
        String filepath = uploadPath + fileName;
        logger.info("filepath 경로 = " + filepath);
        
        try {
            in = new FileInputStream(filepath); // InputStream에 넣어서
            
            // 파일 확장자
            String extension = 
                    filepath.substring(filepath.lastIndexOf(".") + 1);
            logger.info(extension);
            
            // 응답 헤더(response header)에 Content-type 설정
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.setContentType(MediaUtil.getMediaType(extension)); // 까지가 확장자 인식
            // 데이터 전송
            entity = new ResponseEntity<byte[]>( // ResponseEntity JSON에서 데이터 보낼때 씀
                    IOUtils.toByteArray(in), // 파일에서 읽은 데이터
                    httpHeaders, // 응답 헤더
                    HttpStatus.OK
                    );
            
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        return entity;
    } //end display()
	
    @PutMapping("/cash")
    public int updateCash(String memberId,int cash) {
    	int result=0;
    	return result;
    }
    
    @PostMapping("/{memberId}")
    public ResponseEntity<MemberVO> memberInfo(@PathVariable("memberId") String memberId){
    	MemberVO vo = memberService.read(memberId);
    	return new ResponseEntity<MemberVO>(vo,HttpStatus.OK);
    }

    @GetMapping("/findNickname")
    public ResponseEntity<List<MemberVO>> findNickName(String keyword){
    	logger.info("컨트롤러 findNickname 호출 keyword="+keyword);
    	List<MemberVO> list = memberService.findNickname(keyword);
    	return new ResponseEntity<List<MemberVO>>(list,HttpStatus.OK);
    }
} // end MemberController
