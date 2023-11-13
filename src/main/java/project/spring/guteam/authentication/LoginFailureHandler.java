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
		String referer = request.getParameter("referer");
		if(referer!=null&&!referer.contains("login")&&!referer.contains("register")) { 
			// 이전 페이지가 로그인 페이지나 회원가입 페이지가 아닌 경우 targetURL 에 이전 페이지를 저장
			String targetURL = referer;
			logger.info(targetURL);
			request.setAttribute("targetURL", targetURL);
		}
		request.getRequestDispatcher("login?error=1").forward(request, response);
		// 로그인 에러 페이지로 forward
	} // end onAuthenticationFailure()

} // end LoginFailureHandler - 로그인 실패시 실행되는 핸들러
