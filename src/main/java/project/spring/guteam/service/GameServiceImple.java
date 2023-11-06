package project.spring.guteam.service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.DiscountVO;
import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.ViewedVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.DiscountDAO;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.ReviewDAO;
import project.spring.guteam.persistence.ViewedDAO;

@Service
public class GameServiceImple implements GameService {
	private static final Logger logger = LoggerFactory.getLogger(GameServiceImple.class);
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private GameDAO gameDAO;
	
	@Autowired
	private ViewedDAO viewedDAO;
	
	@Autowired
	private DiscountDAO discountDAO;
		
	@Override
	public int create(GameVO vo) {
		logger.info("game create() 호출 : vo = " + vo);
		return gameDAO.insert(vo);
	}

	@Override
	public int getTotalCount() {
		logger.info("game getTotalCount() 호출");
		return gameDAO.getTotalCounts();
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readAll(PageCriteria criteria) {
		logger.info("game read() 호출 : criteria = " + criteria.toString());
		List<GameVO> gameVOList = gameDAO.selectAll(criteria);
		Map<String, Object> args = new HashMap<>();
		setRatingAndPrice(gameVOList, args);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readGame(int gameId, Principal principal) {
		if(principal!=null&&!principal.getName().equals("")) {
			String memberId = principal.getName();
			ViewedVO viewedVO = new ViewedVO(0, memberId, gameId, new Date());
			if(viewedDAO.selectToday(memberId, gameId)!=null&&viewedDAO.selectToday(memberId, gameId).getGameId()==gameId) {
				viewedDAO.update(viewedDAO.selectToday(memberId, gameId));
			}else {
				viewedDAO.insert(viewedVO);
			}
		}
		logger.info("game read(gameId) 호출 : gameId = " + gameId);
		GameVO vo = gameDAO.select(gameId);
		List<DiscountVO> discountList = discountDAO.selectAll();
		Map<String, Double> discounts = new HashMap<>();
		for(DiscountVO discountVO : discountList) {
			discounts.put(discountVO.getGenre(), (double) discountVO.getDiscountRate());
		}
		if(discounts.containsKey(vo.getGenre())) {
			vo.setPrice(vo.getPrice() - (int) (vo.getPrice()*discounts.get(vo.getGenre())));
		}
		int rating = reviewDAO.getRatingAvg(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("vo", vo);
		args.put("rating", rating);
		return args;
	}

	@Override
	public int update(GameVO vo) {
		logger.info("game update() 호출 : vo = " + vo);
		return gameDAO.update(vo);
	}

	@Override
	public int getTotalCountByKeyword(String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameDAO.getTotalCounts(keyword);
	}
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readByKeyword(String keyword, PageCriteria criteria) {
		logger.info("game read(keyword) 호출");
		List<GameVO> gameVOList = gameDAO.selectByNameOrGenre(keyword, criteria);
		Map<String, Object> args = new HashMap<>();
		setRatingAndPrice(gameVOList, args);
		return args;
	}

	@Override
	public int getTotalCountByPrice(int price) {
		logger.info("getTotalCount(price) 호출 : price = " + price);
		return gameDAO.getTotalCounts(price);
	}
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readByPrice(int price, PageCriteria criteria) {
		logger.info("game read(price) 호출");
		List<GameVO> gameVOList = gameDAO.selectByPrice(price, criteria);
		Map<String, Object> args = new HashMap<>();
		setRatingAndPrice(gameVOList, args);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria) {
		Map<String, Object> args = new HashMap<>();
		logger.info("read(orderBy)호출 : orderBy = " + orderBy);
		List<GameVO> gameVOList = gameDAO.selectOrderBy(keyword, keywordCriteria, orderBy, criteria);
		setRatingAndPrice(gameVOList, args);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> recentlyViewedGames(String memberId) {
		Map<String, Object> args = new HashMap<>();
		logger.info("game read(memberId)호출 : memberId = " + memberId );
		List<GameVO> recentlyViewedGameVOList = new ArrayList<>();
		List<Integer> recentlyViewedRatingList = new ArrayList<>();
		List<DiscountVO> discountList = discountDAO.selectAll();
		Map<String, Double> discounts = new HashMap<>();
		for(DiscountVO vo : discountList) {
			discounts.put(vo.getGenre(), (double) vo.getDiscountRate());
		}
		List<ViewedVO> recentlyViewed = viewedDAO.select(memberId);
		for(int i = 0 ; i < recentlyViewed.size(); i++) {
			GameVO vo = gameDAO.select(recentlyViewed.get(i).getGameId());
			if(!recentlyViewedGameVOList.contains(vo)) {
				if(discounts.containsKey(vo.getGenre())) {
					vo.setPrice(vo.getPrice() - (int) (vo.getPrice()*discounts.get(vo.getGenre())));
				}
			recentlyViewedGameVOList.add(vo);
			recentlyViewedRatingList.add(reviewDAO.getRatingAvg(vo.getGameId()));
			}
		}
		args.put("recentlyViewedGameVOList", recentlyViewedGameVOList);
		args.put("recentlyViewedRatingList", recentlyViewedRatingList);
		return args;
	}

	@Override
	public Map<String, Object> readInterestGames(String memberId, PageCriteria criteria) {
		Map<String, Object> args = new HashMap<>();
		List<GameVO> interestList = gameDAO.selectInterestGames(memberId);
		List<String> keywords = new ArrayList<>();
		for(int i = 0 ; i < interestList.size(); i++) {
			keywords.add(interestList.get(i).getGenre());
		}
		List<GameVO> gameVOList = gameDAO.selectByInterest(keywords, criteria);
		setRatingAndPrice(gameVOList, args);
		return args;
	}

	@Override
	public int getSeqNo() {
		int sequence = gameDAO.getSequenceNo();
		return sequence;
	}

	@Override
	public int getInterestKeywordCnt(String memberId) {
		int keywordCnt = gameDAO.selectInterestGames(memberId).size();
		return keywordCnt;
	}
	
	private void setRatingAndPrice(List<GameVO> gameVOList, Map<String, Object> args) {
		List<DiscountVO> discountList = discountDAO.selectAll();
		Map<String, Double> discounts = new HashMap<>();
		for(DiscountVO vo : discountList) {
			discounts.put(vo.getGenre(), (double) vo.getDiscountRate());
		}
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRatingAvg(gameVOList.get(i).getGameId()));
			if(discounts.containsKey(gameVOList.get(i).getGenre())) {
				gameVOList.get(i).setPrice(gameVOList.get(i).getPrice() - (int) (gameVOList.get(i).getPrice()*discounts.get(gameVOList.get(i).getGenre())));
			}
		}
		args.put("discountList", discountList);
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		
	}

}