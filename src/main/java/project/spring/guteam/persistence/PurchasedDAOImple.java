package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<PurchasedVO> select(String memberId) { // 구매 내역에 보여줄 리스트
		logger.info("select 호출");
		return sqlSession.selectList(NAMESPACE+".select",memberId);
	}
	
	@Override
	public PurchasedVO find(String memberId, int gameId) {
		
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("memberId", memberId);
		args.put("gameId", gameId);
		
		return sqlSession.selectOne(NAMESPACE+".find",args);
	}

	@Override
	public List<String> findFriends(String memberId, int gameId) {
		logger.info("findFriends호출");
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("memberId", memberId);
		args.put("gameId", gameId);
		return sqlSession.selectList(NAMESPACE+".find_friend",args);
	}

}
