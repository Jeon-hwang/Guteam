package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.ReviewDAO;
import project.spring.guteam.persistence.ThumbDAO;

@Service
public class ReviewServiceImple implements ReviewService {
	private static Logger logger = LoggerFactory.getLogger(ReviewServiceImple.class);

	@Autowired
	private ReviewDAO reviewDAO;	
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private GameDAO gameDAO;
	
	@Autowired
	private ThumbDAO thumbDAO;
	
	@Override
	public int create(ReviewVO vo) {
		logger.info("review create() 호출");
		return reviewDAO.insert(vo);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria) {
		logger.info("review read() 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.select(gameId, criteria);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.select(reviewList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int reviewId, String memberId) {
		logger.info("review read(reviewId) 호출 : reviewId = " + reviewId );
		Map<String, Object> args = new HashMap<>();
		ReviewVO reviewVO = reviewDAO.select(reviewId);
		logger.info(reviewVO.toString());
		GameVO gameVO = gameDAO.select(reviewVO.getGameId());
		ThumbVO thumbVO = thumbDAO.select(new ThumbVO(reviewId, memberId, 0));
		args.put("reviewVO", reviewVO);
		args.put("gameVO", gameVO);
		args.put("thumbVO",thumbVO);
		return args;
	}

	@Override
	public int update(ReviewVO vo) {
		logger.info("review update() 호출 : vo = " + vo);
		return reviewDAO.update(vo);
	}

	@Override
	public int delete(int reviewId) {
		logger.info("review delete() 호출 : reviewId = " + reviewId);
		return reviewDAO.delete(reviewId);
	}

	@Override
	public int update(int reviewId, int amount) {
		logger.info("review update(amount) 호출 : reviewId = " + reviewId);
		return reviewDAO.update(reviewId, amount);
	}

	@Override
	public int getTotalCount(int gameId) {
		logger.info("review totalCount() 호출");
		return reviewDAO.getTotalCount(gameId);
	}

	@Override
	public int getRating(int gameId) {
		logger.info("review getRating() 호출");
		return reviewDAO.getRating(gameId);
	}

	@Override
	public int readWrited(int gameId, String memberId) {
		logger.info("review readWrited() 호출");
		return reviewDAO.selectWrited(gameId, memberId);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria, String keyword) {
		logger.info("review read(keyword) 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.selectByKeyword(gameId, criteria, keyword);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.select(reviewList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Override
	public int getTotalCount(int gameId, String keyword) {
		logger.info("review getTotalCount(keyword) 호출");
		return reviewDAO.getTotalCount(gameId, keyword);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(String orderBy, PageCriteria criteria, String keyword, int gameId) {
		logger.info("review read(keyword, orderBy) 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.selectByKeywordOrderBy(gameId, criteria, keyword);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.select(reviewList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(String orderBy, int gameId, PageCriteria criteria) {
		logger.info("review read(orderBy) 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.selectOrderBy(gameId, criteria);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.select(reviewList.get(i).getMemberId()).getNickname());
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	}

	@Override
	public List<ReviewVO> readMyReview(String memberId, PageCriteria criteria) {
		logger.info("review readMyReview() 호출 : memberId = " + memberId);
		return reviewDAO.selectByMemberId(memberId, criteria);
	}

	@Override
	public int getCntMyReview(String memberId) {
		return reviewDAO.getTotalCntMyReview(memberId);
	}

}
