package project.spring.guteam;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.persistence.WishListDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class WishListTest {
	private static final Logger logger = LoggerFactory.getLogger(WishListTest.class);
	
	@Autowired
	WishListDAO dao;
	
	@Test
	public void testWish() {
//		insert();
//		select();
//		delete();
	}

	private void delete() {
		logger.info("delete 수행");
		WishListVO vo = new WishListVO("test",2);
		int result = dao.delete(vo);
		if(result == 1) {
			logger.info("delete 성공");
		}
	}

//	private void select() {
//		List<WishListVO> list = dao.select("test");
//		for(WishListVO vo : list) {
//			logger.info(vo.toString());
//		}
//	}

	private void insert() { // 따로 게임 페이지에서 추가하도록하자
		logger.info("insert 수행");
		String memberId = "test";
		WishListVO vo = new WishListVO(memberId, 3);
		int result = dao.insert(vo);
		if(result == 1) {
			logger.info("insert 성공");
		}
	}
	
	
}
