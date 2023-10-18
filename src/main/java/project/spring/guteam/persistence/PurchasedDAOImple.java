package project.spring.guteam.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.PurchasedVO;

@Repository
public class PurchasedDAOImple implements PurchasedDAO {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedDAOImple.class);
	private static final String NAMESPACE = "project.spring.guteam.PurchasedMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insert(PurchasedVO vo) {
		logger.info("insert 호출");
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}

	@Override
	public List<PurchasedVO> select(String memberId) {
		logger.info("select 호출");
		return sqlSession.selectList(NAMESPACE+".select",memberId);
	}

}
