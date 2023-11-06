package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.DiscountVO;
import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.DiscountDAO;
import project.spring.guteam.persistence.GameDAO;

@Service
public class DiscountServiceImple implements DiscountService {
	private static Logger logger = LoggerFactory.getLogger(DiscountServiceImple.class);
	
	@Autowired
	private DiscountDAO discountDAO;
	
	@Autowired
	private GameDAO gameDAO;

	@Override
	public List<String> readAllGenre() {
		List<String> genreList = new ArrayList<>();
		Set<String> genres = new HashSet<>(); 
		int gameCnt = gameDAO.getTotalCounts();
		PageCriteria criteria = new PageCriteria(1, gameCnt);
		List<GameVO> gameList = gameDAO.selectAll(criteria);
		for(int i = 0 ; i < gameList.size(); i++) {
			genres.add(gameList.get(i).getGenre());
		}
		for(String genre : genres) {
			genreList.add(genre);
		}
		return genreList;
	}

	@Transactional(value = "transactionManager")
	@Override
	public int update(DiscountVO vo) {
		int result = 0 ;
		if(discountDAO.select(vo.getGenre())==null) { // 할인 적용된 것이 없다면 입력
			result = discountDAO.insert(vo);
		}else { // 있다면 수정, 0이면 삭제
			if(vo.getDiscountRate()==0) {
				result = discountDAO.delete(vo.getGenre());
			}else {
				result = discountDAO.update(vo);
			}
		}
		return result;
	}

	@Override
	public List<DiscountVO> read() {
		logger.info("discount read() 호출");
		return discountDAO.selectAll();
	}

	@Override
	public int delete(String genre) {
		logger.info("discount delete() 호출 : genre = " + genre);
		return discountDAO.delete(genre);
	}

}
