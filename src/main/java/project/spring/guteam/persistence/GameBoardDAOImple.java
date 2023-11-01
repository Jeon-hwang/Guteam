package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository
public class GameBoardDAOImple implements GameBoardDAO {
	private static final Logger logger = LoggerFactory.getLogger(GameBoardDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.gameBoardMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(GameBoardVO vo) {
		logger.info("GameBoard insert() 호출 : vo = " + vo.toString());
		return sqlSession.insert(NAMESPACE+ ".insert", vo);
	}

	@Override
	public List<GameBoardVO> select(int gameId, PageCriteria criteria) {
		logger.info("GameBoard select(paging)호출 : gameId = " + gameId );
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".paging", args);
	}

	@Override
	public GameBoardVO selectByBoardId(int gameBoardId) {
		logger.info("GameBoard selectByBoardId() 호출 : gameBoardId = " + gameBoardId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_game_board_id", gameBoardId);
	}

	@Override
	public int update(GameBoardVO vo) {
		logger.info("GameBoard update() 호출 : vo = " + vo.toString());
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

	@Override
	public int delete(int gameBoardId) {
		logger.info("GameBoard delete() 호출 : gameBoardId = " + gameBoardId);
		return sqlSession.delete(NAMESPACE + ".delete", gameBoardId);
	}
	
	@Override
	public int getTotalCounts(int gameId) {
		logger.info("GameBoard getTotal() 호출 " );
		return sqlSession.selectOne(NAMESPACE + ".total_count", gameId);
	}

	@Override
	public List<GameBoardVO> selectByNickname(int gameId, String keyword, PageCriteria criteria) {
		logger.info("GameBoard selectByNickname() 호출 gameId = " + gameId + ", keyword = " + keyword);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("keyword", keyword);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".select_by_member_id", args);
	}

	@Override
	public List<GameBoardVO> selectByKeyword(int gameId, String keyword, PageCriteria criteria) {
		logger.info("GameBoard selectByKeyword() 호출 : gameId = " + gameId + ", keyword = " + keyword);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("keyword", keyword);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".select_by_keyword", args);
	}

	@Override
	public int updateCommentCnt(int gameBoardId, int amount) {
		logger.info("GameBoard updateCommentCnt() 호출");
		Map<String, Object> args = new HashMap<>();
		args.put("gameBoardId", gameBoardId);
		args.put("amount", amount);
		return sqlSession.update(NAMESPACE + ".update_comment_cnt", args);
	}

	@Override
	public int updateDeleted(int gameBoardId) {
		logger.info("GameBoard updateDeleted() 호출 : gameBoardId = " + gameBoardId);
		return sqlSession.update(NAMESPACE + ".update_deleted", gameBoardId);
	}

	@Override
	public int getTotalCounts(int gameId, PageCriteria criteria,String keywordCriteria, String keyword) {
		logger.info(keywordCriteria);
		int result = 0;
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("keyword", keyword);
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
			result = sqlSession.selectOne(NAMESPACE+".total_count_by_member_id",args);
		}else {
			result = sqlSession.selectOne(NAMESPACE+".total_count_by_keyword",args);
		}
		return result;
	}

	@Override
	public List<GameBoardVO> select(int gameId, PageCriteria criteria, String orderBy) {
		logger.info("GameBoard select(order) 호출 : gameId = " + gameId );
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE+".select_all_order_by_comment_cnt",args);
	}

	@Override
	public List<GameBoardVO> selectByNickname(int gameId, String keyword, PageCriteria criteria, String orderBy) {
		logger.info("GameBoard selectByNickname(order) 호출 : gameId = " + gameId + ", memberNickname = " + keyword);
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("keyword", keyword);
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE+".select_by_member_id_order_by_comment_cnt", args);
	}

	@Override
	public List<GameBoardVO> selectByKeyword(int gameId, String keyword, PageCriteria criteria, String orderBy) {
		logger.info("GameBoard selectByKeyword(order) 호출 : gameId = " + gameId + ", keyword = " + keyword);
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("keyword", keyword);
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE+".select_by_keyword_order_by_comment_cnt", args);
	}

	@Override
	public List<GameBoardVO> selectByMemberId(String memberId, PageCriteria criteria) {
		logger.info("GameBoard selectByMemberId()호출 : memberId = " + memberId);
		Map<String, Object> args = new HashMap<>();
		args.put("memberId", memberId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE+".select_my_board",args);
	}

	@Override
	public int getCntMyBoard(String memberId) {
		logger.info("GameBoard getCntMyBoard() 호출");
		return sqlSession.selectOne(NAMESPACE+".total_cnt_my_board", memberId);
	}

}
