package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.persistence.MemberDAO;

@Service // @Component
public class MemberServiceImple implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImple.class);
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public int create(MemberVO vo) {
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
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
		logger.info("read -chkId() 호출 memberId = " + memberId);
		return dao.checkId(memberId);
	}
	
	@Override
	public int read(String nickname, int checking) {
		logger.info("read-chkNick() 호출 nickname = " + nickname);
		return dao.checkNickname(nickname);
	}
	
	
	@Override
	public int update(MemberVO vo, String isCash) {
		if(isCash.equals("Y")) {
			logger.info("updateCash() 호출 vo = " + vo.toString());
			return dao.updateCash(vo.getCash(), vo.getMemberId());
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

	@Override
	public int update(String memberId, int amount) {
		logger.info("update() 호출 amount = "+amount+" memberId= "+memberId);
		return dao.updateCash(amount, memberId);
	}

	@Override
	public List<MemberVO> findNickname(String keyword) {
		keyword = keyword.replace("@", "");
		if(keyword.isEmpty()) {
			return null;
		}
		logger.info("findNickname 호출 getKeyword = "+keyword);
		return dao.findNickname(keyword);
	}
}
