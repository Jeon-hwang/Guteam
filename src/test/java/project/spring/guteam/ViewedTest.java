package project.spring.guteam;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.guteam.domain.ViewedVO;
import project.spring.guteam.persistence.ViewedDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration
public class ViewedTest {
	private static final Logger logger = LoggerFactory.getLogger(ViewedTest.class);
	
	@Autowired
	private ViewedDAO viewedDAO;
	
	@Test
	public void Test() {
//		insert();
//		update();
		select();
//		selectOne();
//		delete();
	}

	private void selectOne() {
		ViewedVO vo = viewedDAO.selectToday("test",80);
		logger.info(vo.toString());
		
	}

	private void delete() {
		for(int i = 1; i<10; i++) {
			logger.info(viewedDAO.delete(i)+"삭제");
		}
		
	}

	private void select() {
		String memberId="test";
		List<ViewedVO> list = viewedDAO.select(memberId);
		for(ViewedVO vo : list) {
			logger.info(vo.toString());
		}
		
	}

	private void update() {
		viewedDAO.update(new ViewedVO(1, "test", 25, new Date()));
		
	}

	private void insert() {
		viewedDAO.insert(new ViewedVO(1, "test", 34, new Date()));
		viewedDAO.insert(new ViewedVO(2, "test", 48, new Date()));
	}

}
