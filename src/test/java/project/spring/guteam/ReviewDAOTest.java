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

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.ReviewDAO;import org.springframework.test.context.web.WebAppConfiguration;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class ReviewDAOTest {
	private static final Logger logger = LoggerFactory.getLogger(ReviewDAOTest.class);
	
	@Autowired
	private ReviewDAO dao;
	
	@Test
	public void test() {
//		insertTest();
//		selectTest();
//		selectReviewIdTest();
//		updateTest();
//		deleteTest();
//		getTotalTest();
//		selectByKeywordTest();
//		updateAmountTest();
	}

	private void updateAmountTest() {
		dao.update(5, 1);
		logger.info(dao.select(5)+"");
		
	}

	private void selectByKeywordTest() {
		List<ReviewVO> list = dao.selectByKeyword(5, new PageCriteria(1, 3), "4");
		for(ReviewVO vo : list) {
			logger.info(vo.toString());
		}
	}


	private void getTotalTest() {
		logger.info(dao.getTotalCount(5)+"");
		
	}

	private void deleteTest() {
		logger.info(dao.delete(9)+"");
		
	}

	private void updateTest() {
		ReviewVO vo = new ReviewVO(9, 5, "test", "changeTitle", "changeContent", null, 9, 0);
		logger.info(dao.update(vo)+"");
	}

	private void selectReviewIdTest() {
		ReviewVO vo = dao.select(9);
		logger.info(vo+"");
	}

	private void selectTest() {
		List<ReviewVO> list = dao.select(5, new PageCriteria());
		for(ReviewVO vo : list) {
			logger.info(vo.toString());
		}
	}

	private void insertTest() {
		ReviewVO vo = new ReviewVO(0, 5, "test", "1", "1", new Date(), 5, 0);
		logger.info(dao.insert(vo)+"");
	}

}
