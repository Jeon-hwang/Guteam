package project.spring.guteam.authentication;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

public class LogoutSuccessHandlerImple implements LogoutSuccessHandler{
	private static final Logger logger = LoggerFactory.getLogger(LogoutSuccessHandlerImple.class);

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
//		logger.info("로그아웃 성공 핸들러 호출");
//		logger.info("referer = " + request.getHeader("referer"));
		
		Cookie[] cookies =  request.getCookies();
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("wishListGameId")) {
				logger.info("gameId 쿠키 찾음");
				cookie.setMaxAge(0);
				cookie.setPath("/");
				logger.info(cookie.getName()+":" +cookie.getMaxAge()+"");
				response.addCookie(cookie);
			}
		}
		
		String referer = request.getHeader("referer");
		response.sendRedirect(referer);
		// 이전 페이지로 redirect
		
	} // end onLogoutSuccess()
	
} // end LogoutSuccessHandlerImple - 로그아웃 성공시 실행되는 핸들러
