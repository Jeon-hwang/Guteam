package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.ThumbVO;

@Repository
public class ThumbDAOImple implements ThumbDAO{
	
	private static final Logger logger = LoggerFactory.getLogger(ThumbDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.thumbMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(ThumbVO vo) {
		logger.info("Thumb insert() 호출 : vo = " + vo);
		return sqlSession.insert(NAMESPACE+".insert", vo);
	}

	@Override
	public List<Integer> select(String memberId, int upDown) {
		logger.info("Thumb select() 호출  : memberId = " + memberId);
		Map<String, Object> args = new HashMap<>();
		args.put("memberId", memberId);
		args.put("upDown", upDown);
		return sqlSession.selectList(NAMESPACE + ".select_by_member_id", args);
	}

	@Override
	public int delete(ThumbVO vo) {
		logger.info("Thumb delete() 호출 : vo = " + vo);
		return sqlSession.delete(NAMESPACE + ".delete", vo);
	}

	@Override
	public int update(ThumbVO vo) {
		logger.info("Thumb update() 호출 : vo = " + vo);
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

}
