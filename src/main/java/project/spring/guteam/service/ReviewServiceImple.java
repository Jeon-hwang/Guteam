package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.ReviewDAO;

@Service
public class ReviewServiceImple implements ReviewService {
	private static Logger logger = LoggerFactory.getLogger(ReviewServiceImple.class);

	@Autowired
	private ReviewDAO reviewDAO;	
	
	@Override
	public int create(ReviewVO vo) {
		logger.info("review create() 호출");
		return reviewDAO.insert(vo);
	}

	@Override
	public List<ReviewVO> read(int gameId, PageCriteria criteria) {
		logger.info("review read() 호출");
		return reviewDAO.select(gameId, criteria);
	}

	@Override
	public ReviewVO read(int reviewId) {
		logger.info("review read(reviewId) 호출 : reviewId = " + reviewId );
		return reviewDAO.select(reviewId);
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

}
