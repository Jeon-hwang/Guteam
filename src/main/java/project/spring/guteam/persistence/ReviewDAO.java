package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.ReviewVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface ReviewDAO {
	int insert(ReviewVO vo);
	List<ReviewVO> select(int gameId, PageCriteria criteria);
	ReviewVO select(int reviewId);
	int update(ReviewVO vo);
	int delete(int reviewId);
	int getTotalCount(int gameId);
	List<ReviewVO> selectByKeyword(int gameId, PageCriteria criteria, String keyword);
	int getTotalCount(int gameId, String keyword);
	int update(int reviewId, int amount);
	int getRatingAvg(int gameId);
	// 게임의 평균 평점을 리턴
	int selectWrited(int gameId, String memberId);
	List<ReviewVO> selectOrderBy(int gameId, PageCriteria criteria);
	List<ReviewVO> selectByKeywordOrderBy(int gameId, PageCriteria criteria, String keyword);
	List<ReviewVO> selectByMemberId(String memberId, PageCriteria criteria);
	int getTotalCntMyReview(String memberId);
}
