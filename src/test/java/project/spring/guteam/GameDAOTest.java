package project.spring.guteam;

import java.util.ArrayList;
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
//		updateTest();
//		selectCriTest();
//		getTotalTest();
//		selectByPriceTest();
//		selectByNameOrGenretest();
//		selectByInterestPoint();
//		selectInterestPoint();
	}

	private void selectInterestPoint() {
		List<GameVO>list=dao.selectInterestGames("test");
		List<String>keywords=new ArrayList<>();
		for(GameVO vo : list) {
			keywords.add(vo.getGenre());
			logger.info(vo.getGenre());
		}
		PageCriteria criteria = new PageCriteria();
		List<GameVO>gameList=dao.selectByInterest(keywords, criteria);
		for(GameVO vo : gameList) {
			logger.info(vo.toString());
		}
	}

	private void selectByInterestPoint() {
		List<GameVO>list=dao.selectInterestGames("test");
		for(GameVO vo : list) {
			logger.info(vo.toString());
		}
		
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
		List<GameVO> list = dao.selectAll(criteria);
		for(int i = 0 ; i < list.size(); i++) {
			logger.info(list.get(i).toString());
		}
		
	}


	private void updateTest() {
		GameVO vo = new GameVO(8, "changeGame", 2000, "changeGenre", null, null, "", "N");
		dao.update(vo);
		
	}

	private void insertTest() {
		Date date = new Date();
		logger.info(date.toString());
		GameVO vo = new GameVO(0, "testGame2", 1000, "rpg", new Date(), null, null, "N");
		logger.info(vo.toString());
		int result = dao.insert(vo);
		if(result == 1 ) {
			logger.info("성공");
		}else {
			logger.info("실패");
		}
		
	}

}