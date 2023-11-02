package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.ViewedVO;

@Repository
public class ViewedDAOImple implements ViewedDAO{
	private static final Logger logger = LoggerFactory.getLogger(ViewedDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.viewedMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(ViewedVO vo) {
		logger.info("viewed insert()호출 : vo = " + vo );
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<ViewedVO> select(String memberId) {
		logger.info("viewed select() 호출 : memberId = " + memberId);
		List<ViewedVO> list = null;
		list = sqlSession.selectList(NAMESPACE + ".select_today", memberId);
		return list;
	}

	@Override
	public int update(ViewedVO vo) {
		logger.info("viewed update() 호출 : vo = " + vo);
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

	@Override
	public ViewedVO selectRecently(String memberId, int gameId) {
		logger.info("viewed selectRecently() 호출 : memberId = " + memberId);
		Map<String, Object> args = new HashMap<>();
		args.put("memberId", memberId);
		args.put("gameId", gameId);
		return sqlSession.selectOne(NAMESPACE + ".select_recently_one", args);
	}

	@Override
	public int delete(int viewedId) {
		logger.info("viewed delete() 호출 : viewedId = " + viewedId);
		return sqlSession.delete(NAMESPACE + ".delete", viewedId);
	}

}
