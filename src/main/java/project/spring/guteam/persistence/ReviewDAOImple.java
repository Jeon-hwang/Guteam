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
	} // end select()

	@Override
	public ReviewVO select(int reviewId) {
		logger.info("Review select() 호출 : reviewId = " + reviewId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_review_id", reviewId);
	} // end select()

	@Override
	public int update(ReviewVO vo) {
		logger.info("Review update() 호출 : vo = " + vo);
		return sqlSession.update(NAMESPACE + ".update", vo);
	} // end update()

	@Override
	public int delete(int reviewId) {
		logger.info("Review delete() 호출 : reviewId = " + reviewId);
		return sqlSession.delete(NAMESPACE + ".delete", reviewId);
	} // end delete()

	@Override
	public int getTotalCount(int gameId) {
		logger.info("Reveiw getTotal() 호출 ");
		return sqlSession.selectOne(NAMESPACE + ".total_count", gameId);
	} // end getTotalCount()

	
	@Override
	public List<ReviewVO> selectByKeyword(int gameId, PageCriteria criteria, String keyword) {
		logger.info("Review selectByKeyword() 호출 : gameId = " + gameId + ", keyword = " + keyword);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		args.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".select_by_keyword", args);
	} // end selectByKeyword()

	@Override
	public int update(int reviewId, int amount) {
		logger.info("Review updateThumbup() 호출");
		Map<String, Object> args = new HashMap<>();
		args.put("reviewId", reviewId);
		args.put("amount", amount);
		return sqlSession.update(NAMESPACE + ".update_thumb_up_count", args);
		
	} // end update()

	@Override
	public int getRatingAvg(int gameId) {
		logger.info("Review getRating() 호출 : gameId = " + gameId);
		Integer rating = sqlSession.selectOne(NAMESPACE+".get_rating_avg", gameId);
		if(rating==null) {
			rating = 0;
		}
		logger.info("rating = " + rating);
		return rating;
	} // end getRatingAvg()

	@Override
	public int selectWrited(int gameId, String memberId) {
		logger.info("Review selectWrited() 호출 : gameId = " + gameId + ", memberId = " + memberId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("memberId", memberId);
		Integer result = sqlSession.selectOne(NAMESPACE + ".reveiw_writed", args);
		if(result == null) {
			return 0;
		}
		return result;
	} // end selectWrited()

	@Override
	public int getTotalCount(int gameId, String keyword) {
		logger.info("Reveiw getTotalCount(keyword) 호출 : keyword = " + keyword + ", gameId = " + gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("keyword", keyword);
		return sqlSession.selectOne(NAMESPACE+".total_count_by_keyword", args);
	} // end getTotalCount()

	@Override
	public List<ReviewVO> selectOrderBy(int gameId, PageCriteria criteria) {
		logger.info("Review select(orderBy) 호출 : gameId = " + gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".order_by_thumbUpCnt", args);
	} // end selectOrderBy()

	@Override
	public List<ReviewVO> selectByKeywordOrderBy(int gameId, PageCriteria criteria, String keyword) {
		logger.info("Review selectByKeyword(orderBy) 호출 : gameId = " + gameId + ", keyword = " + keyword);
		Map<String, Object> args = new HashMap<>();
		args.put("gameId", gameId);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		args.put("keyword", keyword);
		return sqlSession.selectList(NAMESPACE + ".select_by_keyword_order_by_thumbUpCnt", args);
	} // end selectByKeywordOrderBy()

	@Override
	public List<ReviewVO> selectByMemberId(String memberId, PageCriteria criteria) {
		logger.info("Review selectByMemberId() 호출 : memberId = " + memberId);
		Map<String, Object> args = new HashMap<>();
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		args.put("memberId", memberId);
		return sqlSession.selectList(NAMESPACE+".select_my_review",args);
	} // end selectByMemberId()

	@Override
	public int getTotalCntMyReview(String memberId) {
		logger.info("Review getTotalCountMyReview() 호출");
		return sqlSession.selectOne(NAMESPACE+".total_cnt_my_review", memberId);
	} // end getTotalCntMyReview()

} // end ReviewDAOImple
