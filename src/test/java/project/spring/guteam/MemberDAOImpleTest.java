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

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.persistence.MemberDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
@WebAppConfiguration
public class MemberDAOImpleTest {
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpleTest.class);
	
	@Autowired
	private MemberDAO dao;
	
	@Test
	public void testDAO() {
//		testInsert();
//		testSelectAll();
//		testSelectOne();
//		testUpdateMem();
//		testUpdateCach();
//		testDelete();
	}

	private void testDelete() {
		int result = dao.delete("test3");
		if(result == 1) {
			logger.info("delete() 성공");
		} else {
			logger.info("delete() 실패");
		}
	}

	private void testUpdateCach() {
		MemberVO vo = new MemberVO("test2", "1234", "테스트", "test", "00", 999999, "test", "N");
		int result = dao.updateCash(vo);
		if(result == 1) {
			logger.info("updateCash() 성공");
		}else {
			logger.info("updateCash() 실패");
		}
	}

	private void testUpdateMem() {
		MemberVO vo = new MemberVO("", "1234", "테스트", "test", "00", 0, "test", "N");
		int result = dao.updateMem(vo);
		if(result == 1) {
			logger.info("update 성공");
		} else {
			logger.info("update 실패");
		}
	}

	private void testSelectOne() {
		MemberVO vo = dao.select("test");
		logger.info(vo.toString());		
	}

	private void testSelectAll() {
		List<MemberVO> list = dao.select();
		for(MemberVO vo : list) {
			logger.info(vo.toString());
		}
		
	}

	private void testInsert() {
		MemberVO vo = new MemberVO("test3", "1234", "테스트", "test", "0000", 500, "test", "N");
		int result = dao.insert(vo);
		if(result == 1) {
			logger.info("insert() 성공");			
		} else {
			logger.info("insert() 실패");
		}
	}

}
