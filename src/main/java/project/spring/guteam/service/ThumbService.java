package project.spring.guteam.service;

import project.spring.guteam.domain.ThumbVO;

public interface ThumbService {
	int create(ThumbVO vo) throws Exception;
	ThumbVO read(ThumbVO vo);
	int update(ThumbVO vo) throws Exception;
	int delete(ThumbVO vo) throws Exception;
}
