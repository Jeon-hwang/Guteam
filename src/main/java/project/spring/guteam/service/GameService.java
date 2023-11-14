package project.spring.guteam.service;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameService {
	// CRUD(Create, Read, Update, Delete)
	int create(GameVO vo); // 게임 생성
	Map<String, Object> readAll(PageCriteria criteria); // 게임 정보들을 조회(할인율 / 평점 등등을 함께 조회)
	Map<String, Object> readGame(int gameId, Principal principal); 
	// 게임 정보를 조회(할인율 / 평점 등을 함께 조회) => 로그인 정보가 있다면 조회 정보에 추가/수정 
	int update(GameVO vo); // 게임 수정
	int getTotalCount(); // 게임의 총 수 리턴
	int getTotalCountByPrice(int price); // [0 <= $(price) <= #(price)] 의 게임 수를 리턴
	Map<String, Object> readByPrice(int price, PageCriteria criteria);// 게임 정보들을 조회( price 기준 )
	Map<String, Object> readByKeyword(String keyword, PageCriteria criteria); // 게임 정보들을 조회( keyword 기준 )
	int getTotalCountByKeyword(String keyword); // [ like %||keyword||% ] 게임 수를 리턴
	int getSeqNo(); // 게임 아이디 시퀀스를 조회하여 다음 등록될 게임 아이디 값을 가져옴
	Map<String, Object> readOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria);
	// 정렬 기준으로 게임 정보를 가져옴
	Map<String, Object> recentlyViewedGames(String memberId);
	// 최근 조회한 게임들(today)을 가져옴
	Map<String, Object> readInterestGames(String memberId, PageCriteria criteria);
	// 여러 정보들을 기준으로 게임들을 정렬하여 가져옴
	int getInterestKeywordCnt(String memberId);
	// 로그인 정보를 기반으로 하는 데이터가 얼마나 있는지 리턴
	List<String> findKeywords(String keyword);
	// 키워드 입력시 키워드추천
}