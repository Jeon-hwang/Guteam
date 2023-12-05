package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameDAO {
	int insert(GameVO vo);
	// 게임 정보를 입력
	GameVO select(int gameId);
	// 게임 정보를 조회 
	int update(GameVO vo);
	// 게임 정보를 수정
	List<GameVO> selectAll(PageCriteria criteria);
	// 게임 정보들을 페이지 정보를 기반으로 가져옴
	int getTotalCounts();
	// 게임 수를 리턴
	int getTotalCounts(String keyword);
	// 게임 수를 리턴(keyword 기준)
	int getTotalCounts(int price);
	// 게임 수를 리턴(price 기준)
	List<GameVO> selectByPrice(int price, PageCriteria criteria);
	// 게임 정보들을 페이지 정보를 기반으로 조회 ( price 기준 )
	List<GameVO> selectByNameOrGenre(String keyword, PageCriteria criteria);
	// 게임 정보들을 페이지 정보를 기반으로 조회 ( keyword 기준 )
	int getSequenceNo();
	// 게임 id 시퀀스 정보를 가져와서 리턴
	List<GameVO> selectOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria);
	// 게임 정보들을 정렬하여 조회
	List<GameVO> selectInterestGames(String memberId);
	// 게임 정보들을 로그인 정보를 기반으로 조회
	List<GameVO> selectByInterest(List<String> keywords, PageCriteria criteria);
	// 게임 정보들을 로그인 정보로 조회한 데이터를 기반으로 정렬하여 페이지 정보를 기반으로 조회
	List<String> selectKeywords(String keyword);
	// 키워드 정보로 키워드를 찾기
	int updateEndService(int gameId);
	// 게임 서비스 종료
}