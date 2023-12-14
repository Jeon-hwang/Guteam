package project.spring.guteam.service;

import java.net.URI;
import java.net.URISyntaxException;
import java.security.Principal;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;

import project.spring.guteam.domain.KakaoPayApprovalVO;
import project.spring.guteam.domain.KakaoPayReadyVO;

@Service
public class KakaoPayService {
	 private static final Logger logger= LoggerFactory.getLogger(KakaoPayService.class);			 
	
	 private static final String HOST = "https://kapi.kakao.com";
	    
	    private Map<String, KakaoPayReadyVO> payMap = new ConcurrentHashMap<String, KakaoPayReadyVO>();
	    
	    public String kakaoPayReady(String memberId, Integer cash, String URI) {
	 
	        RestTemplate restTemplate = new RestTemplate();
	 
	        // 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "KakaoAK " + "2e7146bdfd1c57aff884a560be0d3af7");
	        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	        
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", "TC0ONETIME");
	        params.add("partner_order_id", "guteam");
	        params.add("partner_user_id", memberId);
	        params.add("item_name", "캐쉬 충전");
	        params.add("quantity", "1");
	        params.add("total_amount", cash+"");
	        params.add("tax_free_amount", cash/10+"");
	        params.add("approval_url", URI+"/payment/kakaoPaySuccess?cash="+cash);
	        params.add("cancel_url", URI+"/member/profiles");
	        params.add("fail_url", URI+"/member/profiles");
	 
	         HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	 
	        try {
	            KakaoPayReadyVO kakaoPayReadyVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/ready"), body, KakaoPayReadyVO.class);
	            payMap.put(memberId, kakaoPayReadyVO);
	            logger.info("" + kakaoPayReadyVO);
	            
	            return kakaoPayReadyVO.getNext_redirect_pc_url();
	 
	        } catch (RestClientException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (URISyntaxException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        
	        return "/pay";
	        
	    }
	    
	    
	    public KakaoPayApprovalVO kakaoPayInfo(String pg_token, String memberId, String cash) {
	    	 
	        logger.info("KakaoPayInfoVO............................................");
	        logger.info("-----------------------------");
	        KakaoPayReadyVO kakaoPayReadyVO=payMap.get(memberId);
	        payMap.remove(memberId);
	        RestTemplate restTemplate = new RestTemplate();
	 
	        // 서버로 요청할 Header
	        HttpHeaders headers = new HttpHeaders();
	        headers.add("Authorization", "KakaoAK " + "2e7146bdfd1c57aff884a560be0d3af7");
	        headers.add("Accept", MediaType.APPLICATION_JSON_UTF8_VALUE);
	        headers.add("Content-Type", MediaType.APPLICATION_FORM_URLENCODED_VALUE + ";charset=UTF-8");
	 
	        // 서버로 요청할 Body
	        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
	        params.add("cid", "TC0ONETIME");
	        params.add("tid", kakaoPayReadyVO.getTid());
	        params.add("partner_order_id", "guteam");
	        params.add("partner_user_id", memberId);
	        params.add("pg_token", pg_token);
	        params.add("total_amount", cash);
	        
	        HttpEntity<MultiValueMap<String, String>> body = new HttpEntity<MultiValueMap<String, String>>(params, headers);
	        
	        try {
	        	KakaoPayApprovalVO kakaoPayApprovalVO = restTemplate.postForObject(new URI(HOST + "/v1/payment/approve"), body, KakaoPayApprovalVO.class);
	            logger.info("" + kakaoPayApprovalVO);
	          
	            return kakaoPayApprovalVO;
	        
	        } catch (RestClientException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        } catch (URISyntaxException e) {
	            // TODO Auto-generated catch block
	            e.printStackTrace();
	        }
	        
	        return null;
	    }

}
