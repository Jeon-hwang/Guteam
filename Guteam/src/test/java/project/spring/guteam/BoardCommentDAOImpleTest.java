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

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.persistence.BoardCommentDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class BoardCommentDAOImpleTest {
	private static final Logger logger = LoggerFactory.getLogger(BoardCommentDAOImpleTest.class);
	
	@Autowired
	private BoardCommentDAO dao;
	
	@Test
	public void testCommentImple() {
//		insert();
//		selectAll();
//		update();
//		delete();
	}

	private void delete() {
		int result = dao.delete(2);
		if(result==1) {
			logger.info("delete 성공!");
		}
	}

	private void update() {
		int result = dao.update("변경됨!", 2);
		if(result==1) {
			logger.info("update 성공!");
		}
	}

	private void selectAll() {
		List<BoardCommentVO> list = dao.select(1);
		logger.info(list.size()+"");
		for(BoardCommentVO vo : list) {
			logger.info(vo.toString());
		}
	}

	private void insert() {
		BoardCommentVO vo = new BoardCommentVO(0, 1, "hwnag", "반갑습니다!", null, 0);
		int result = dao.insert(vo);
		if(result == 1) {
			logger.info("insert 성공!");
		}else {
			logger.info("insert 실패 ㅠㅠ");
		}
			
	}
}
