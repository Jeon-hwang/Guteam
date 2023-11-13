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
	} // end create()

	@Override
	public int getTotalCount() {
		logger.info("game getTotalCount() 호출");
		return gameDAO.getTotalCounts();
	} // end getTotalCount()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readAll(PageCriteria criteria) {
		logger.info("game read() 호출 : criteria = " + criteria.toString());
		List<GameVO> gameVOList = gameDAO.selectAll(criteria);
		Map<String, Object> args = new HashMap<>();
		setRatingAndPrice(gameVOList, args);
		return args;
	} // end readAll()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readGame(int gameId, Principal principal) {
		if(principal!=null&&!principal.getName().equals("")) {
			String memberId = principal.getName();
			ViewedVO viewedVO = new ViewedVO(0, memberId, gameId, new Date());
			if(viewedDAO.selectOneToday(memberId, gameId)!=null&&viewedDAO.selectOneToday(memberId, gameId).getGameId()==gameId) {
				// 오늘 조회한 정보가 있으면 조회정보를 수정
				viewedDAO.update(viewedDAO.selectOneToday(memberId, gameId));
			}else {
				// 오늘 조회한 정보가 없으면 조회정보를 입력
				viewedDAO.insert(viewedVO);
			}
		}
//		logger.info("game read(gameId) 호출 : gameId = " + gameId);
		GameVO vo = gameDAO.select(gameId);
		List<DiscountVO> discountList = discountDAO.selectAll();
		Map<String, Double> discounts = new HashMap<>();
		for(DiscountVO discountVO : discountList) {
			discounts.put(discountVO.getGenre(), (double) discountVO.getDiscountRate());
		}
		if(discounts.containsKey(vo.getGenre())) {
			// 할인 정보에 있는 장르이면 가격을 할인 가격으로 재설정
			vo.setPrice(vo.getPrice() - (int) (vo.getPrice()*discounts.get(vo.getGenre())));
		}
		int rating = reviewDAO.getRatingAvg(gameId);
		 // 게임의 평균 평점을 조회
		Map<String, Object> args = new HashMap<>();
		args.put("vo", vo);
		args.put("rating", rating);
		return args;
	} // end readGame()

	@Override
	public int update(GameVO vo) {
		logger.info("game update() 호출 : vo = " + vo);
		return gameDAO.update(vo);
	} // end update()

	@Override
	public int getTotalCountByKeyword(String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameDAO.getTotalCounts(keyword);
	} // end getTotalCountByKeyword()
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readByKeyword(String keyword, PageCriteria criteria) {
		logger.info("game read(keyword) 호출");
		List<GameVO> gameVOList = gameDAO.selectByNameOrGenre(keyword, criteria);
		Map<String, Object> args = new HashMap<>();
		setRatingAndPrice(gameVOList, args);
		return args;
	} // end readByKeyword()

	@Override
	public int getTotalCountByPrice(int price) {
		logger.info("getTotalCount(price) 호출 : price = " + price);
		return gameDAO.getTotalCounts(price);
	} // end getTotalCountByPrice()
	
	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readByPrice(int price, PageCriteria criteria) {
		logger.info("game read(price) 호출");
		List<GameVO> gameVOList = gameDAO.selectByPrice(price, criteria);
		Map<String, Object> args = new HashMap<>();
		setRatingAndPrice(gameVOList, args);
		return args;
	} // end readByPrice()

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> readOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria) {
		Map<String, Object> args = new HashMap<>();
		logger.info("read(orderBy)호출 : orderBy = " + orderBy);
		List<GameVO> gameVOList = gameDAO.selectOrderBy(keyword, keywordCriteria, orderBy, criteria);
		setRatingAndPrice(gameVOList, args);
		return args;
	} // end readOrderBy()

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
		List<ViewedVO> recentlyViewed = viewedDAO.selectToday(memberId);
		for(int i = 0 ; i < recentlyViewed.size(); i++) {
			// 오늘 조회한 게임 id 값으로 게임 정보들을 조회
			GameVO vo = gameDAO.select(recentlyViewed.get(i).getGameId());
			if(!recentlyViewedGameVOList.contains(vo)) {
				if(discounts.containsKey(vo.getGenre())) {
					// 할인 정보에 있는 장르이면 가격을 할인 가격으로 재설정
					vo.setPrice(vo.getPrice() - (int) (vo.getPrice()*discounts.get(vo.getGenre())));
				}
			recentlyViewedGameVOList.add(vo);
			recentlyViewedRatingList.add(reviewDAO.getRatingAvg(vo.getGameId()));
			}
		}
		args.put("recentlyViewedGameVOList", recentlyViewedGameVOList);
		args.put("recentlyViewedRatingList", recentlyViewedRatingList);
		return args;
	} // end recentlyViewedGames()

	@Override
	public Map<String, Object> readInterestGames(String memberId, PageCriteria criteria) {
		Map<String, Object> args = new HashMap<>();
		List<GameVO> interestList = gameDAO.selectInterestGames(memberId);
		List<String> keywords = new ArrayList<>();
		for(int i = 0 ; i < interestList.size(); i++) {
			keywords.add(interestList.get(i).getGenre());
			keywords.add(interestList.get(i).getGameName().substring(0, 2));
		}
		List<GameVO> gameVOList = gameDAO.selectByInterest(keywords, criteria);
		setRatingAndPrice(gameVOList, args);
		return args;
	} // end readInterestGames()

	@Override
	public int getSeqNo() {
		int sequence = gameDAO.getSequenceNo();
		return sequence;
	} // end getSeqNo()

	@Override
	public int getInterestKeywordCnt(String memberId) {
		int keywordCnt = gameDAO.selectInterestGames(memberId).size();
		return keywordCnt;
	} // end getInterestKeywordCnt()
	
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
				// 할인 테이블에 장르가 있다면 해당 할인 정보로 가격을 재설정
				gameVOList.get(i).setPrice(gameVOList.get(i).getPrice() - (int) (gameVOList.get(i).getPrice()*discounts.get(gameVOList.get(i).getGenre())));
			}
		}
		args.put("discountList", discountList);
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		
	} // end setRatingAndPrice()

} // end GameServiceImple