package project.spring.guteam;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.guteam.domain.FriendRequestVO;
import project.spring.guteam.persistence.FriendRequestDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class FriendRequestDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(FriendRequestDAOTest.class);
	
	@Autowired
	private FriendRequestDAO dao;
	
	@Test
	public void testDAO() {
//		testInsert();
//		testSelect();
//		testDelete();
	}

	private void testDelete() {
		int result = dao.delete("test22", "test");
		if(result == 1) {
			logger.info("삭제 성공");
		} else {
			logger.info("삭제 실패");
		}
		
	}

	private void testSelect() {
		List<String> list = dao.selectTo("test");
		for(String vo : list) {
			logger.info(vo.toString());
		}
		
	}

	private void testInsert() {
		FriendRequestVO vo = new FriendRequestVO("test", "test", null);
		int result = dao.insert(vo);
		if(result == 1) {
			logger.info("testInsert() 성공");
		} else {
			logger.info("testInsert() 실패");
		}
	}
	
	
}
