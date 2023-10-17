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

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class GameDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(GameDAOTest.class);
	
	@Autowired
	private GameDAO dao;
	
	@Test
	public void testGameDAO() {
//		insertTest();
//		selectTest();
//		updateTest();
//		selectCriTest();
//		getTotalTest();
//		selectByPriceTest();
//		selectByNameOrGenretest();
	}

	private void selectByNameOrGenretest() {
		String keyword = "즐";
		List<GameVO> list = dao.selectByNameOrGenre(keyword, new PageCriteria());
		for(int i = 0 ; i < list.size(); i++) {
			logger.info(list.get(i).toString());
		}
		
	}

	private void selectByPriceTest() {
		int price = 1500;
		List<GameVO> list = dao.selectByPrice(price, new PageCriteria());
		for(int i = 0 ; i < list.size(); i++) {
			logger.info(list.get(i).toString());
		}
		
	}

	private void getTotalTest() {
		int result = dao.getTotalCounts();
		logger.info(result+"");
	}

	private void selectCriTest() {
		PageCriteria criteria = new PageCriteria(1, 2);
		List<GameVO> list = dao.select(criteria);
		for(int i = 0 ; i < list.size(); i++) {
			logger.info(list.get(i).toString());
		}
		
	}


	private void updateTest() {
		GameVO vo = new GameVO(8, "changeGame", 2000, "changeGenre", null, null, "");
		dao.update(vo);
		
	}

	private void selectTest() {
		List<GameVO> list = dao.select();
		for(int i = 0 ; i < list.size(); i++) {
			logger.info(list.get(i).toString());
		}
	}

	private void insertTest() {
		Date date = new Date();
		logger.info(date.toString());
		GameVO vo = new GameVO(0, "testGame2", 1000, "rpg", new Date(), null, null);
		logger.info(vo.toString());
		int result = dao.insert(vo);
		if(result == 1 ) {
			logger.info("성공");
		}else {
			logger.info("실패");
		}
		
	}

}
