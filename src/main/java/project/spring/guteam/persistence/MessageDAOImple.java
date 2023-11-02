package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.MessageVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository // @Component
public class MessageDAOImple implements MessageDAO {
	private static final Logger logger = LoggerFactory.getLogger(MessageDAOImple.class);
	
	public static final String NAMESPACE = "project.spring.guteam.MessageMapper";
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int insert(MessageVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	@Override
	public MessageVO select(int messageId) {
		logger.info("select() 호출 msgId? " + messageId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_message_id", messageId);
	}

	@Override
	public List<MessageVO> select(String receiveMemberId, PageCriteria criteria) {
		logger.info("paging-select() 호출");
		logger.info("start = " + criteria.getStart() + " / end = " + criteria.getEnd());
		Map<String, Object> args = new HashMap<>();
		args.put("receiveMemberId", receiveMemberId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".select_paging", args);
	}
	
	@Override
	public int delete(int messageId) {
		logger.info("delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", messageId);
	}

	@Override
	public int getTotalCounts() {
		logger.info("getTotalCount() 호출");
		return sqlSession.selectOne(NAMESPACE + ".total_count");
	}

}
