package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository // @Component
public class MessageReceiveDAOImple implements MessageReceiveDAO {
	private static final Logger logger = LoggerFactory.getLogger(MessageReceiveDAOImple.class);
	
	public static final String NAMESPACE = "project.spring.guteam.MessageReceiveMapper";
	
	@Autowired
	public SqlSession sqlSession;

	@Override
	public int insert(MessageReceiveVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}
	
	@Override
	public MessageReceiveVO select(int receiveMessageId) {
		logger.info("select() 호출 receiveMessageId? " + receiveMessageId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_message_id", receiveMessageId);
	}

	@Override
	public List<MessageReceiveVO> select(String receiveMemberId, PageCriteria criteria) {
		logger.info("paging-select() 호출");
		logger.info("start = " + criteria.getStart() + " / end = " + criteria.getEnd());
		Map<String, Object> args = new HashMap<>();
		args.put("receiveMemberId", receiveMemberId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".select_paging", args);
	}
	
//	@Override
//	public List<MessageReceiveVO> selectTo(String sendMemberId, PageCriteria criteria) {
//		logger.info("paging-select() 호출");
//		logger.info("start = " + criteria.getStart() + " / end = " + criteria.getEnd());
//		Map<String, Object> args = new HashMap<>();
//		args.put("sendMemberId", sendMemberId);
//		args.put("start", criteria.getStart());
//		args.put("end", criteria.getEnd());
//		return sqlSession.selectList(NAMESPACE + ".select_to_paging", args);
//	}
	
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
