package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.ReplyVO;

@Repository //@Component
public class ReplyDAOImple implements ReplyDAO {
	private static final Logger logger = LoggerFactory.getLogger(ReplyDAOImple.class);
	
	private static final String NAMESPACE="project.spring.guteam.ReplyMapper";
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int insert(ReplyVO vo) {
		logger.info("Reply insert 실행!");
		return sqlSession.insert(NAMESPACE+".insert",vo);
	}

	@Override
	public List<ReplyVO> select(int commentId) {
		logger.info("Reply select 실행!");
		return sqlSession.selectList(NAMESPACE+".select_all_by_comment_id",commentId);
	}

	@Override
	public int update(String replyContent, int replyId) {
		logger.info("Reply update 실행!");
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("replyContent", replyContent);
		args.put("replyId",replyId);
		return sqlSession.update(NAMESPACE+".update",args);
	}

	@Override
	public int delete(int replyId) {
		logger.info("Reply delete 실행!");
		return sqlSession.delete(NAMESPACE+".delete",replyId);
	}

	@Override
	public List<ReplyVO> select(String memberId) {
		logger.info("reply select by memberId 실행");
		return sqlSession.selectList(NAMESPACE+".select_all_by_member_id",memberId);
	}

}
