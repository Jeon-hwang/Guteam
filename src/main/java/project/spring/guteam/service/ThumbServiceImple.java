package project.spring.guteam.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.ThumbVO;
import project.spring.guteam.persistence.ReviewDAO;
import project.spring.guteam.persistence.ThumbDAO;

@Service
public class ThumbServiceImple implements ThumbService {
	private static final Logger logger = LoggerFactory.getLogger(ThumbServiceImple.class);

	@Autowired
	private ThumbDAO thumbDAO;

	@Autowired
	private ReviewDAO reviewDAO;

	@Transactional(value = "transactionManager")
	@Override
	public int create(ThumbVO vo) throws Exception {
		int result = 0;
		if (read(vo)==null) {
			logger.info("thumb create() 호출 ");
			int amount = vo.getUpDown();
			if(amount<0) {
				amount=0;
			}
			result = reviewDAO.update(vo.getReviewId(), amount);
			if (result == 1) {
				thumbDAO.insert(vo);
			}
		}
		return result;
	}

	@Override
	public ThumbVO read(ThumbVO vo) {
		logger.info("thumb read() 호출 ");
		return thumbDAO.select(vo);
	}

	@Transactional(value = "transactionManager")
	@Override
	public int update(ThumbVO vo) throws Exception{
		int result = 0;
		if (read(vo)!=null) {
			logger.info("thumb update() 호출 ");
			result = thumbDAO.update(vo);
			if(result==1) {
				reviewDAO.update(vo.getReviewId(), vo.getUpDown());
			}
		}
		return result;
	}

	@Transactional(value = "transactionManager")
	@Override
	public int delete(ThumbVO vo) throws Exception{
		int result = 0;
		if (read(vo)!=null) {
			logger.info("thumb delete() 호출 ");
			result = thumbDAO.delete(vo);
			if(vo.getUpDown()==1) {
				reviewDAO.update(vo.getReviewId(), -1);
			}
		}
		return result;
	}

}
