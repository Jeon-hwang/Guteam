package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.persistence.MemberDAO;

@Service // @Component
public class MemberServiceImple implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImple.class);
	
	@Autowired
	private MemberDAO dao;

	@Override
	public int create(MemberVO vo) {
		logger.info("create() 호출 성공 : vo = " + vo.toString());
		return dao.insert(vo);
	}

	@Override
	public List<MemberVO> read() {
		logger.info("read() 호출");
		return dao.select();
	}

	@Override
	public MemberVO read(String memberId) {
		logger.info("read() 호출 memberId = " + memberId);
		return dao.select(memberId);
	}
	
	@Override
	public int read(String memberId, String checking) {
		logger.info("checkId() 호출 memberId = " + memberId);
		return dao.checkId(memberId);
	}
	
	
	@Override
	public int update(MemberVO vo, String isCash) {
		if(isCash.equals("Y")) {
			logger.info("updateCash() 호출 vo = " + vo.toString());
			return dao.updateCash(vo);
		}else {
		logger.info("updateMem() 호출 vo = " + vo.toString());
		return dao.updateMem(vo);
		}
	}

	@Override
	public int delete(String memberId) {
		logger.info("delete() 호출 memberId = " + memberId);
		return dao.delete(memberId);
	}

	

}
