package project.spring.guteam;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.guteam.persistence.MessageReceiveDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class MessageDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(MessageDAOTest.class);
	
	@Autowired
	private MessageReceiveDAO dao;
	
	@Test
	public void Test() {
		getBoxCounts();
		
	}

	private void getBoxCounts() {
		logger.info(dao.getBoxCounts("test")+"");	
		
	}
	

}
