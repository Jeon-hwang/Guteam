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

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.ViewedVO;
import project.spring.guteam.pageutil.PageCriteria;
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
		
	@Override
	public int create(GameVO vo) {
		logger.info("game create() 호출 : vo = " + vo);
		return gameDAO.insert(vo);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(PageCriteria criteria) {
		logger.info("game read() 호출 : criteria = " + criteria.toString());
		List<GameVO> gameVOList = gameDAO.select(criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		Map<String, Object> args = new HashMap<>();
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int gameId, Principal principal) {
		if(principal!=null&&!principal.getName().equals("")) {
			String memberId = principal.getName();
			ViewedVO viewedVO = new ViewedVO(0, memberId, gameId, new Date());
			if(viewedDAO.selectRecently(memberId, gameId)!=null&&viewedDAO.selectRecently(memberId, gameId).getGameId()==gameId) {
				viewedDAO.update(viewedDAO.selectRecently(memberId, gameId));
			}else {
				viewedDAO.insert(viewedVO);
			}
		}
		logger.info("game read(gameId) 호출 : gameId = " + gameId);
		GameVO vo = gameDAO.select(gameId);
		int rating = reviewDAO.getRating(gameId);
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
	public int getTotalCount() {
		logger.info("game getTotalCount() 호출");
		return gameDAO.getTotalCounts();
	}

	@Override
	public int getTotalCount(String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameDAO.getTotalCounts(keyword);
	}
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(int price, PageCriteria criteria) {
		logger.info("game read(price) 호출");
		List<GameVO> gameVOList = gameDAO.selectByPrice(price, criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		Map<String, Object> args = new HashMap<>();
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(String keyword, PageCriteria criteria) {
		logger.info("game read(keyword) 호출");
		List<GameVO> gameVOList = gameDAO.selectByNameOrGenre(keyword, criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		Map<String, Object> args = new HashMap<>();
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Override
	public int getTotalCount(int price) {
		logger.info("getTotalCount(price) 호출 : price = " + price);
		return gameDAO.getTotalCounts(price);
	}

	@Override
	public int getSeqNo() {
		int sequence = gameDAO.getSequenceNo();
		return sequence;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> read(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria) {
		Map<String, Object> args = new HashMap<>();
		logger.info("read(orderBy)호출 : orderBy = " + orderBy);
		List<GameVO> gameVOList = gameDAO.selectOrderBy(keyword, keywordCriteria, orderBy, criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> recentlyViewedGames(String memberId) {
		Map<String, Object> args = new HashMap<>();
		logger.info("game read(memberId)호출 : memberId = " + memberId );
		List<GameVO> recentlyViewedGameVOList = new ArrayList<>();
		List<Integer> recentlyViewedRatingList = new ArrayList<>();
		List<ViewedVO> recentlyViewed = viewedDAO.select(memberId);
		for(int i = 0 ; i < recentlyViewed.size(); i++) {
			if(!recentlyViewedGameVOList.contains(gameDAO.select(recentlyViewed.get(i).getGameId()))) {
			recentlyViewedGameVOList.add(gameDAO.select(recentlyViewed.get(i).getGameId()));
			recentlyViewedRatingList.add(reviewDAO.getRating(recentlyViewed.get(i).getGameId()));
			}
		}
		args.put("recentlyViewedGameVOList", recentlyViewedGameVOList);
		args.put("recentlyViewedRatingList", recentlyViewedRatingList);
		return args;
	}

	@Override
	public int getTotalCountInterest(String memberId) {
		List<GameVO> interestList = gameDAO.selectInterest(memberId);
		List<String> keywords = new ArrayList<>();
		for(int i = 0 ; i < interestList.size(); i++) {
			keywords.add(interestList.get(i).getGenre());
		}
		if(keywords.size()<3) {
			return 0;
		}
		return gameDAO.getTotalCountsInterest(keywords);
	}

	@Override
	public Map<String, Object> getInterestGames(String memberId, PageCriteria criteria) {
		Map<String, Object> args = new HashMap<>();
		List<GameVO> interestList = gameDAO.selectInterest(memberId);
		List<String> keywords = new ArrayList<>();
		for(int i = 0 ; i < interestList.size(); i++) {
			keywords.add(interestList.get(i).getGenre());
		}
		List<GameVO> gameVOList = gameDAO.selectInterestByKeyword(keywords, criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

}