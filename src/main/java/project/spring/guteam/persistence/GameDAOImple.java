package project.spring.guteam.persistence;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

@Repository
public class GameDAOImple implements GameDAO {
	private static final Logger logger = LoggerFactory.getLogger(GameDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.gameMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(GameVO vo) {
		logger.info("Game insert() 호출 : vo = " + vo.toString());
		return sqlSession.insert(NAMESPACE+".insert",vo);
	}

	@Override
	public List<GameVO> select() {
		logger.info("Game select() 호출");
		return sqlSession.selectList(NAMESPACE+".select_all");
	}

	@Override
	public GameVO select(int gameId) {
		logger.info("Game select_by_game_id() 호출 : gameId = " + gameId);
		return sqlSession.selectOne(NAMESPACE + ".select_by_game_id", gameId);
	}

	@Override
	public int update(GameVO vo) {
		logger.info("Game update() 호출 : vo = " + vo.toString());
		return sqlSession.update(NAMESPACE+".update", vo);
	}

	@Override
	public List<GameVO> select(PageCriteria criteria) {
		logger.info("Game select(criteria) 호출 : criteria = " + criteria);
		return sqlSession.selectList(NAMESPACE + ".paging", criteria);
	}

	@Override
	public int getTotalCounts() {
		logger.info("Game getTotalCounts() 호출");
		return sqlSession.selectOne(NAMESPACE + ".total_count");
	}

	
	@Override
	public List<GameVO> selectByPrice(int price, PageCriteria criteria) {
		logger.info("Game select(price) 호출 : price = " + price);
		Map<String , Object> args = new HashMap<>();
		args.put("price", price);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE+ ".select_by_price", args);
	}

	@Override
	public List<GameVO> selectByNameOrGenre(String keyword, PageCriteria criteria) {
		logger.info("Game select by name or genre() 호출 : keyword = " + keyword);
		Map<String , Object> args = new HashMap<>();
		args.put("keyword", keyword);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		return sqlSession.selectList(NAMESPACE + ".select_by_keyword", args);
	}

	@Override
	public int getTotalCounts(String keyword) {
		logger.info("Game getTotalCounts(keyword) 호출 : keyword = " + keyword);
		return sqlSession.selectOne(NAMESPACE + ".total_count_by_keyword", keyword);
	}

	@Override
	public int getTotalCounts(int price) {
		logger.info("Game getTotalCounts(price)호출 : price = " + price);
		return sqlSession.selectOne(NAMESPACE+ ".total_count_by_price", price);
	}

	@Override
	public int getSequenceNo() {
		logger.info("Game getSeqNo()호출");
		return sqlSession.selectOne(NAMESPACE+".get_seq_no");
	}

	@Override
	public List<GameVO> selectOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria) {
		logger.info("Game selectOrderBy()호출");
		Map<String, Object> args = new HashMap<>();
		args.put("keyword", keyword);
		args.put("price", keyword);
		args.put("keywordCriteria", keywordCriteria);
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		logger.info(orderBy);
		if(keywordCriteria.equals("keyword")) {
			switch(orderBy) {
			case "price": return sqlSession.selectList(NAMESPACE + ".select_keyword_order_by_price", args);
			case "priceDesc": return sqlSession.selectList(NAMESPACE + ".select_keyword_order_by_price_desc", args);
			case "purchased": return sqlSession.selectList(NAMESPACE + ".select_keyword_order_by_purchased", args);
			case "wishlist": return sqlSession.selectList(NAMESPACE + ".select_keyword_order_by_wishlist", args);
		}
		}else if(keywordCriteria.equals("price")) {
			switch(orderBy) {
			case "price": return sqlSession.selectList(NAMESPACE + ".select_by_price", args);
			case "priceDesc": return sqlSession.selectList(NAMESPACE + ".select_by_price_order_by_price_desc", args);
			case "purchased": return sqlSession.selectList(NAMESPACE + ".select_by_price_order_by_purchased", args);
			case "wishlist": return sqlSession.selectList(NAMESPACE + ".select_by_price_order_by_wishlist", args);
			}
		}
		return sqlSession.selectList(NAMESPACE + ".select_keyword_order_by_price", args);
	}

	@Override
	public List<GameVO> selectInterest(String memberId) {
		logger.info("Game Interest() 호출 ");
		List<GameVO> list = sqlSession.selectList(NAMESPACE+".select_by_interest_point", memberId);
		List<GameVO> interestList = new ArrayList<>(); 
		for(GameVO vo : list) {
			interestList.add(select(vo.getGameId()));
		}
		return interestList;
	}

	@Override
	public List<GameVO> selectInterestByKeyword(List<String> keywords, PageCriteria criteria) {
		logger.info("Game Interest By Keyword() 호출");
		Map<String, Object> args = new HashMap<>();
		for(int i = 0; i < keywords.size(); i++) {
			int no = i+1;
			String string = "keyword"+no;
			args.put(string, keywords.get(i));
			logger.info(string+"="+keywords.get(i));
		}
		args.put("start", criteria.getStart());
		args.put("end", criteria.getEnd());
		List<GameVO> list = sqlSession.selectList(NAMESPACE+".select_by_interest_keyword", args);
		return list;
	}

	@Override
	public int getTotalCountsInterest(List<String> keywords) {
		Map<String, Object> args = new HashMap<>();
		for(int i = 0; i < keywords.size(); i++) {
			int no = i+1;
			String string = "keyword"+no;
			args.put(string, keywords.get(i));
		}
		return sqlSession.selectOne(NAMESPACE+".total_count_by_interest", args);
	}
	
	

}
