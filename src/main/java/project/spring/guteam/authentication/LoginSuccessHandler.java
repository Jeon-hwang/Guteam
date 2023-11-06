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
		logger.info("로그인 성공 핸들러 호출");
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);
		HttpSession session = request.getSession(false);
        if(session!=null) {
        	logger.info("로그인 실패 기록 삭제");
        	session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        }
        
		if(savedRequest!=null) {
			String targetURL = savedRequest.getRedirectUrl();
			redirectStrategy.sendRedirect(request, response, targetURL);
		}else if(request.getParameter("referer") != null && request.getParameter("referer").contains("login")||request.getParameter("referer").contains("register")){
			logger.info(request.getParameter("targetURL"));
			redirectStrategy.sendRedirect(request, response, request.getParameter("targetURL"));
		}else {
			redirectStrategy.sendRedirect(request, response, request.getParameter("referer"));
		}
		
		
		
	}

}
