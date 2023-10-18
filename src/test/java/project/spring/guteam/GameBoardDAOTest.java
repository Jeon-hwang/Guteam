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

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameBoardDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class GameBoardDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(GameBoardDAOTest.class);
	
	@Autowired
	private GameBoardDAO dao;
	
	@Test
	public void GameBoardTest(){
//		insertTest();
//		selectTest();
//		selectByBoardIdTest();
//		updateTest();
//		deleteTest();
//		getTotalTest();
//		selectByMemberIdTest();
//		selectByKeywordTest();
//		updateCommentCntTest();
	}

	private void updateCommentCntTest() {
		int result = dao.updateCommentCnt(4, -1);
		logger.info(result+"행 수정 성공 comcnt="+dao.selectByBoardId(4).getCommentCnt());
	}

	private void selectByKeywordTest() {
		List<GameBoardVO>list = dao.selectByKeyword(5,"se");
		for(GameBoardVO vo : list) {
			logger.info(vo.toString());
		}
	}

	private void selectByMemberIdTest() {
		List<GameBoardVO>list = dao.selectByMemberId(5,"test");
		for(GameBoardVO vo : list) {
			logger.info(vo.toString());
		}
		
	}

	private void getTotalTest() {
		logger.info(dao.getTotalCounts(5)+"");
		
	}

	private void deleteTest() {
		dao.delete(3);
		
	}

	private void updateTest() {
		GameBoardVO vo = new GameBoardVO(3, 0, "change", "changeTitle", "changed", null, 0);
		dao.update(vo);
	}

	private void selectByBoardIdTest() {
		GameBoardVO vo = dao.selectByBoardId(3);
		logger.info(vo+"");
	}

	private void selectTest() {
		PageCriteria criteria = new PageCriteria(1,2);
		List<GameBoardVO>list = dao.select(5, criteria);
		for(GameBoardVO vo : list) {
			logger.info(vo.toString());
		}
		
	}

	private void insertTest() {
		GameBoardVO vo  = new GameBoardVO(0, 5, "test2", "tset2", "test2", new Date(), 0);
		int result = dao.insert(vo);
		if(result==1) {
			logger.info("success");
		}else {
			logger.info("fail");
		}
	}

}

