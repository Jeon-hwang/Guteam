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

import project.spring.guteam.domain.FriendVO;
import project.spring.guteam.persistence.FriendDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class FriendDAOImpleTest {
	private static final Logger logger = LoggerFactory.getLogger(FriendDAOImpleTest.class);
	
	@Autowired
	private FriendDAO dao;
	
	@Test
	public void testDao() {
//		testInsert();
//		testSelect();
		testFriendSel();
		
	}

	private void testFriendSel() {
		int result = dao.select("test", "test22");
		if(result == 1) {
			logger.info("친구다");
		}else{
			logger.info("친구 아님");
		}
		
	}

	private void testSelect() {
		List<String> list = dao.select("test");
		for(String vo : list) {
			logger.info(vo.toString());
		}
		
	}

	private void testInsert() {
		FriendVO vo = new FriendVO("test", "test12");
		int result = dao.insert(vo);
		if(result == 1) {
			logger.info("insert 성공");
		} else {
			logger.info("insert 실패");
		}
		
	}
}





