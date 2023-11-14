package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface ReviewDAO {
	int insert(ReviewVO vo);
	List<ReviewVO> select(int gameId, PageCriteria criteria);
	// 게임아이디와 페이지 정보로 리뷰 정보들을 조회
	ReviewVO select(int reviewId);
	// 리뷰아이디로 리뷰 정보를 조회
	int update(ReviewVO vo);
	// 리뷰 정보 수정
	int delete(int reviewId);
	// 리뷰 정보 삭제
	int getTotalCount(int gameId);
	// 리뷰 총 수를 리턴(gameId)
	List<ReviewVO> selectByKeyword(int gameId, PageCriteria criteria, String keyword);
	// 키워드와 페이지 정보를 기준으로 리뷰 정보들을 조회
	int getTotalCount(int gameId, String keyword);
	// 키워드 정보를 기준으로 총 리뷰 수를 리턴
	int update(int reviewId, int amount);
	// 리뷰 추천수 수정
	int getRatingAvg(int gameId);
	// 게임의 평균 평점을 리턴
	int selectWrited(int gameId, String memberId);
	// 로그인 정보로 해당 게임에 쓴 리뷰 아이디를 리턴( 없으면 0 )
	List<ReviewVO> selectOrderBy(int gameId, PageCriteria criteria);
	// 페이지 정보로 추천 수를 기준으로 정렬하여 리뷰 정보들을 조회
	List<ReviewVO> selectByKeywordOrderBy(int gameId, PageCriteria criteria, String keyword);
	// 키워드와 페이지 정보로 추천 수를 기준으로 정렬하여 리뷰 정보들을 조회 
	List<ReviewVO> selectByMemberId(String memberId, PageCriteria criteria);
	// 로그인 정보와 페이지 정보를 기준으로 작성한 리뷰들을 조회
	int getTotalCntMyReview(String memberId);
	// 로그인 정보를 기준으로 작성한 리뷰의 총 수를 리턴
}
