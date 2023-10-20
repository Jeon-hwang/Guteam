package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.BoardCommentVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository //component
public class BoardCommentDAOImple implements BoardCommentDAO {
	private static final Logger logger = LoggerFactory.getLogger(BoardCommentDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.BoardCommentMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(BoardCommentVO vo) {
		logger.info("B.Comment insert() 수행");
		return sqlSession.insert(NAMESPACE+".insert",vo);
	}

	@Override
	public List<BoardCommentVO> select(int gameBoardId) {
		logger.info("B.Comment select() 수행");
		return sqlSession.selectList(NAMESPACE+".select_all_by_board_id",gameBoardId);
	}

	@Override
	public int update(String commentContent, int commentId) {
		logger.info("B.Comment update() 수행");
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("commentId", commentId);
		args.put("commentContent", commentContent);
		return sqlSession.update(NAMESPACE+".update",args);
	}

	@Override
	public int delete(int commentId) {
		logger.info("B.Comment delete 수행");
		return sqlSession.update(NAMESPACE+".delete",commentId);
	}

	@Override
	public List<BoardCommentVO> select(int gameBoardId, PageCriteria criteria) {
		logger.info("paging select 수행");
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("gameBoardId", gameBoardId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE+".select_and_paging",args);
	}

	@Override
	public int getTotalCount(int gameBoardId) {
		logger.info("getTotalNum 실행");
		return sqlSession.selectOne(NAMESPACE+".total_count",gameBoardId);
	}
	
	

}
