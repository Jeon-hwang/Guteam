package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.FriendRequestVO;

@Repository // @Component
public class FriendRequestDAOImple implements FriendRequestDAO {
	public static final Logger logger = LoggerFactory.getLogger(FriendRequestDAOImple.class);
	
	public static final String NAMESPACE = "project.spring.guteam.FriendRequestMapper";
	
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public int insert(FriendRequestVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	@Override
	public int select(String sendMemberId, String receiveMemberId) {
		logger.info("select_all() 호출 receiveMemberId " + receiveMemberId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sendMemberId", sendMemberId);
		map.put("receiveMemberId", receiveMemberId);
		return sqlSession.selectOne(NAMESPACE + ".select_all", map);
	}

	@Override
	public List<String> selectTo(String sendMemberId) {
		logger.info("selectTo() 호출 sendMemberId = " + sendMemberId);
		return sqlSession.selectList(NAMESPACE + ".select_to_request", sendMemberId);
	}

	@Override
	public List<String> selectFrom(String receiveMemberId) {
		logger.info("selectFrom() 호출 receiveMemberId = " + receiveMemberId);
		return sqlSession.selectList(NAMESPACE + ".select_from_request", receiveMemberId);
	}

	@Override
	public int delete(String sendMemberId, String receiveMemberId) {
		logger.info("delete() 호출");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sendMemberId", sendMemberId);
		map.put("receiveMemberId", receiveMemberId);
		return sqlSession.delete(NAMESPACE + ".delete", map);
	}

}
