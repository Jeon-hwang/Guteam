package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository
public class WishListDAOImple implements WishListDAO {
	private final static Logger logger = LoggerFactory.getLogger(WishListDAOImple.class);
	private final static String NAMESPACE ="project.spring.guteam.WishList";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(WishListVO vo) {
		logger.info("insert 수행");
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}

	@Override
	public List<WishListVO> select(String memberId) {
		logger.info("select 수행(memberId)");		
		return sqlSession.selectList(NAMESPACE+".select_by_memberId",memberId);
	}

	@Override
	public int delete(WishListVO vo) {
		logger.info("delete 수행");
		
		return sqlSession.delete(NAMESPACE+".delete",vo);
	}

	@Override
	public List<String> select(int gameId) {
		logger.info("select 수행(gameId)");
		return sqlSession.selectList(NAMESPACE+".select_by_gameId",gameId);
	}

	@Override
	public WishListVO select(String memberId, int gameId) {
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("memberId", memberId);
		args.put("gameId", gameId);		
		return sqlSession.selectOne(NAMESPACE+".find",args);
	}

	@Override
	public int deleteAll(String memberId) {
		logger.info("deleteAll 수행");
		return sqlSession.delete(NAMESPACE+".delete_all_by_memberId",memberId);
	}

}
