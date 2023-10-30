package project.spring.guteam.authentication;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailureHandler implements AuthenticationFailureHandler{
	private static final Logger logger = LoggerFactory.getLogger(LoginFailureHandler.class);

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		logger.info("로그인 실패 핸들러 호출");
		String targetURL = request.getParameter("referer");
		logger.info(targetURL);
		request.setAttribute("targetURL", targetURL);
		request.getRequestDispatcher("login?error=1").forward(request, response);
		
	}

}
