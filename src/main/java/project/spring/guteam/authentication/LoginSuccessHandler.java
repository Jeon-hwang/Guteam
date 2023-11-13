package project.spring.guteam.authentication;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	private static final Logger logger = LoggerFactory.getLogger(LoginSuccessHandler.class);

	private RequestCache requestCache = new HttpSessionRequestCache();
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	private String defaultUrl = "/";
	
	public void setDefaultURL(String defaultUrl) {
		this.defaultUrl=defaultUrl;
	}
	public String getDefaultURL() {
		return defaultUrl;
	}
	
	@Override
	public void onAuthenticationSuccess( HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
//		logger.info("로그인 성공 핸들러 호출");
		// 로그인 성공시
		SavedRequest savedRequest = requestCache.getRequest(request, response); // 캐시를 가져옴
		HttpSession session = request.getSession(false); // false => request에 세션이 없으면 null을 반환
        if(session!=null) {
//        	logger.info("로그인 실패 기록 삭제");
        	session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        	// 로그인 실패 기록을 삭제 
        }
        
		if(savedRequest!=null) {
			String targetURL = savedRequest.getRedirectUrl();
			 // 캐시에 저장된 redirectURL 이 있으면 해당 URL 로 redirect 실행
			redirectStrategy.sendRedirect(request, response, targetURL);
		}else if(request.getParameter("referer") != null && request.getParameter("referer").contains("login")||request.getParameter("referer").contains("register")){
			// 캐시에 저장된 url 이 없고 이전 페이지가 로그인 페이지이거나 회원가입 페이지일 때 
			String targetURL = request.getParameter("targetURL");
			if(targetURL!=null) {
				defaultUrl= request.getParameter("targetURL");
			}
			redirectStrategy.sendRedirect(request, response, defaultUrl);
		}else {
			redirectStrategy.sendRedirect(request, response, request.getParameter("referer"));
		}
		
	} // end onAuthenticationSuccess()

} // end LoginSuccessHandler - 로그인 성공시 실행되는 핸들러
