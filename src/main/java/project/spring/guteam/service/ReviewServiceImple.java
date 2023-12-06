package project.spring.guteam.service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;
import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.PurchasedDAO;
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
	
	@Autowired
	private PurchasedDAO purchasedDAO;
	
	@Override
	public int create(ReviewVO vo, Principal principal) {
		logger.info("review create() 호출");
		if(vo.getMemberId().equals(principal.getName())) {
			if(purchasedDAO.find(principal.getName(),vo.getGameId())!=null) {
				return reviewDAO.insert(vo);							
			}
			logger.info("구매하지 않음");
			return 0;
		}
		logger.info("user 정보 불일치");
		return 0;
	} // end create()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria) {
		logger.info("review read() 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.select(gameId, criteria);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.selectByMemberId(reviewList.get(i).getMemberId()));
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int reviewId, String memberId) {
		logger.info("review read(reviewId) 호출 : reviewId = " + reviewId );
		Map<String, Object> args = new HashMap<>();
		ReviewVO reviewVO = reviewDAO.select(reviewId);
		logger.info(reviewVO.toString());
		String nickname = memberDAO.selectByMemberId(reviewVO.getMemberId());
		GameVO gameVO = gameDAO.select(reviewVO.getGameId());
		ThumbVO thumbVO = thumbDAO.select(new ThumbVO(reviewId, memberId, 0));
		args.put("nickname", nickname);
		args.put("reviewVO", reviewVO);
		args.put("gameVO", gameVO);
		args.put("thumbVO",thumbVO);
		return args;
	} // end read()

	@Override
	public int update(ReviewVO vo, Principal principal) {
		logger.info("review update() 호출 : vo = " + vo);
		if(vo.getMemberId().equals(principal.getName())) {
			if(purchasedDAO.find(principal.getName(),vo.getGameId())!=null) {
				if(readWrited(vo.getGameId(), principal.getName())>0) {
					return reviewDAO.update(vo);									
				}
				logger.info("리뷰없음");
				return 0;
			}
			logger.info("구매하지 않음");
			return 0;
		}
		logger.info("user정보 불일치");
		return 0;
	} // end update()

	@Override
	public int delete(int reviewId, Principal principal) {
		logger.info("review delete() 호출 : reviewId = " + reviewId);
		ReviewVO vo = reviewDAO.select(reviewId);
		if(vo.getMemberId().equals(principal.getName())) {
			if(purchasedDAO.find(principal.getName(),vo.getGameId())!=null) {
				if(readWrited(vo.getGameId(), principal.getName())>0) {
					return reviewDAO.delete(reviewId);					
				}
				logger.info("리뷰없음");
				return 0;
			}
			logger.info("구매하지 않음");
			return 0;
		}
		logger.info("user정보 불일치");
		return 0;
	} // end delete()

	@Override
	public int update(int reviewId, int amount) {
		logger.info("review update(amount) 호출 : reviewId = " + reviewId);
		return reviewDAO.update(reviewId, amount);
	} // end update()

	@Override
	public int getTotalCount(int gameId) {
		logger.info("review totalCount() 호출");
		return reviewDAO.getTotalCount(gameId);
	} // end getTotalCount()

	@Override
	public int getRating(int gameId) {
		logger.info("review getRating() 호출");
		return reviewDAO.getRatingAvg(gameId);
	} // end getRating()

	@Override
	public int readWrited(int gameId, String memberId) {
		logger.info("review readWrited() 호출");
		return reviewDAO.selectWrited(gameId, memberId);
	} // end readWrited()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, PageCriteria criteria, String keyword) {
		logger.info("review read(keyword) 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.selectByKeyword(gameId, criteria, keyword);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.selectByMemberId(reviewList.get(i).getMemberId()));
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Override
	public int getTotalCount(int gameId, String keyword) {
		logger.info("review getTotalCount(keyword) 호출");
		return reviewDAO.getTotalCount(gameId, keyword);
	} // end getTotalCount()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(String orderBy, PageCriteria criteria, String keyword, int gameId) {
		logger.info("review read(keyword, orderBy) 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.selectByKeywordOrderBy(gameId, criteria, keyword);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.selectByMemberId(reviewList.get(i).getMemberId()));
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(String orderBy, int gameId, PageCriteria criteria) {
		logger.info("review read(orderBy) 호출");
		Map<String, Object> args = new HashMap<>();
		List<ReviewVO> reviewList = reviewDAO.selectOrderBy(gameId, criteria);
		List<String> nicknameList = new ArrayList<>();
		for(int i = 0 ; i < reviewList.size(); i++) {
			nicknameList.add(memberDAO.selectByMemberId(reviewList.get(i).getMemberId()));
		}
		GameVO gameVO = gameDAO.select(gameId);
		args.put("reviewList", reviewList);
		args.put("nicknameList", nicknameList);
		args.put("gameVO", gameVO);
		return args;
	} // end read()

	@Override
	public List<ReviewVO> readMyReview(String memberId, PageCriteria criteria) {
		logger.info("review readMyReview() 호출 : memberId = " + memberId);
		return reviewDAO.selectByMemberId(memberId, criteria);
	} // end readMyReview()

	@Override
	public int getCntMyReview(String memberId) {
		return reviewDAO.getTotalCntMyReview(memberId);
	} // end getCntMyReview()

	@Override
	public int isPurchased(int gameId, String memberId) {
		PurchasedVO vo = purchasedDAO.find(memberId, gameId);
		if(vo==null) {
			return 0;
		}
		return 1;
	}

} // end ReviewServiceImple
