package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository // @Component
public class MessageSendDAOImple implements MessageSendDAO {
	private static final Logger logger = LoggerFactory.getLogger(MessageSendDAOImple.class);
	
	public static final String NAMESPACE = "project.spring.guteam.MessageSendMapper";
	
	@Autowired
	public SqlSession sqlSession;
	
	@Override
	public int insert(MessageSendVO vo) {
		logger.info("insert() 호출");
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public MessageSendVO select(int sendMessageId) {
		logger.info("select() 호출 receiveMessageId? " + sendMessageId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_message_id", sendMessageId);
	}

	@Override
	public List<MessageSendVO> select(String sendMemberId, PageCriteria criteria) {
		logger.info("paging-select() 호출");
		logger.info("start = " + criteria.getStart() + " / end = " + criteria.getEnd());
		Map<String, Object> args = new HashMap<>();
		args.put("sendMemberId", sendMemberId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".select_paging", args);
	}
	
	@Override
	public int update(String messageBox, int sendMessageId) {
		logger.info("update(보낸쪽지보관) 호출");
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("messageBox", messageBox);
		args.put("sendMessageId", sendMessageId);
		return sqlSession.update(NAMESPACE + ".update_box", args);
	}

	@Override
	public int delete(int sendMessageId) {
		logger.info("delete() 호출");
		return sqlSession.delete(NAMESPACE + ".delete", sendMessageId);
	}
	
	@Override
	public int getTotalCounts() {
		logger.info("getTotalCount() 호출");
		return sqlSession.selectOne(NAMESPACE + ".total_count");
	}

}
