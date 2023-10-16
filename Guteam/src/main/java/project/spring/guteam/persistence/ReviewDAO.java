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
	int getTotalCount();
	List<ReviewVO> selectByMemberId(int gameId, PageCriteria criteria, String keyword);
	List<ReviewVO> selectByKeyword(int gameId, PageCriteria criteria, String keyword);
	int update(int reviewId, int amount);
}
