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
import project.spring.guteam.persistence.ThumbDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration
public class ThumbTest {
	private static final Logger logger = LoggerFactory.getLogger(ThumbTest.class);
	
	@Autowired
	private ThumbDAO dao;

	@Test
	public void test() {
//		insertTest();
//		selectTest();
//		updateTest();
//		deleteTest();
		
	}

	private void deleteTest() {
		dao.delete(new ThumbVO(5, "test", 1));
	}

	private void updateTest() {
		dao.update(new ThumbVO(5, "test", -1));
		
	}

	private void selectTest() {
		ThumbVO vo = new ThumbVO(3, "test", 1);
		vo = dao.select(vo);
		
		logger.info(vo.toString());
		
		
	}

	private void insertTest() {
		logger.info(dao.insert(new ThumbVO(3, "test", 1))+"");
		
	}
}
