package project.spring.guteam.authentication;

import java.io.IOException;

import javax.servlet.ServletException;
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
		logger.info("로그아웃 성공 핸들러 호출");
		logger.info("referer = " + request.getHeader("referer"));
		String referer = request.getHeader("referer");
		response.sendRedirect(referer);		
		
	}
	

}
