package project.spring.guteam;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.guteam.domain.ReplyVO;
import project.spring.guteam.persistence.ReplyDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class ReplyDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(ReplyDAOTest.class); 
	
	@Autowired
	private ReplyDAO dao;
	
	@Test
	public void testReplyDAO() {
//		insert();
	}

	
	private void insert() {
		ReplyVO vo = new ReplyVO(0, 1, "김씨", "하이요", null);
		int result = dao.insert(vo);
		if(result==1) {
			logger.info("insert 성공!");
		}
	}
}
