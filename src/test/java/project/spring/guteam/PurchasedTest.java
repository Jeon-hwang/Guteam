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

import project.spring.guteam.domain.PurchasedVO;
import project.spring.guteam.persistence.PurchasedDAO;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})  
@WebAppConfiguration 
public class PurchasedTest {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedTest.class);
	
	@Autowired
	private PurchasedDAO dao;
	
	@Test
	public void testPurchased() {
//		insert();
//		select();
	}

	private void select() {
		List<PurchasedVO> list =  dao.select("test");
		for(PurchasedVO vo : list) {
			logger.info(vo.toString());
		}
	}

	private void insert() {
		
		PurchasedVO vo = new PurchasedVO("test", 1, null);
		int result = dao.insert(vo);
		if(result == 1) {
			logger.info("insert 성공!");
		}
	}
}
