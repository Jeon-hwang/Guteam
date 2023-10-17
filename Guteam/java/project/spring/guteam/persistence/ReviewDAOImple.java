package project.spring.guteam.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.LoggerFactory;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository
public class ReviewDAOImple implements ReviewDAO {
	private static final Logger logger = LoggerFactory.getLogger(ReviewDAOImple.class);

	private static final String NAMESPACE = "project.spring.guteam.reviewMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(ReviewVO vo) {
		logger.info("Review insert() 호출 : vo = " + vo );
		return sqlSession.insert(NAMESPACE + ".insert", vo);
	}

	@Override
	public List<ReviewVO> select(int gameId, PageCriteria criteria) {
		logger.info("Review select(paging) 호출 : gameId = " + gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".paging", args);
	}

	@Override
	public ReviewVO select(int reviewId) {
		logger.info("Review select() 호출 : reviewId = " + reviewId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_review_id", reviewId);
	}

	@Override
	public int update(ReviewVO vo) {
		logger.info("Review update() 호출 : vo = " + vo);
		return sqlSession.update(NAMESPACE + ".update", vo);
	}

	@Override
	public int delete(int reviewId) {
		logger.info("Review delete() 호출 : reviewId = " + reviewId);
		return sqlSession.delete(NAMESPACE + ".delete", reviewId);
	}

	@Override
	public int getTotalCount() {
		logger.info("Reveiw getTotal() 호출 ");
		return sqlSession.selectOne(NAMESPACE + ".total_count");
	}

	@Override
	public List<ReviewVO> selectByMemberId(int gameId, PageCriteria criteria, String keyword) {
		logger.info("Review selectByMemberId() 호출 : gameId = " + gameId + ", memberId like " + keyword);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		args.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".select_by_member_id", args);
	}

	@Override
	public List<ReviewVO> selectByKeyword(int gameId, PageCriteria criteria, String keyword) {
		logger.info("Review selectByKeyword() 호출 : gameId = " + gameId + ", keyword = " + keyword);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		args.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".select_by_keyword", args);
	}

	@Override
	public int update(int reviewId, int amount) {
		logger.info("Review updateThumbup() 호출");
		Map<String, Object> args = new HashMap<>();
		args.put("reviewId", reviewId);
		args.put("amount", amount);
		return sqlSession.update(NAMESPACE + ".update_thumb_up_count", args);
		
	}

}
