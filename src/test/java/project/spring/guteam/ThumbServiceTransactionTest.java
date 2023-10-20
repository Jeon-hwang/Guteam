package project.spring.guteam;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.service.ThumbService;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration
public class ThumbServiceTransactionTest {

	private static final Logger logger = LoggerFactory.getLogger(ThumbServiceTransactionTest.class);
	
	@Autowired
	private ThumbService service;

	@Test
	public void test() throws Exception {
		service.create(new ThumbVO(19, "테스트중", 1));
	}
}
