package project.spring.guteam.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Writer;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.service.MemberService;

@Controller // @Component
@RequestMapping(value="/payment")
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	private Map<String, Map<String, Integer>> paymentToken = new ConcurrentHashMap<String, Map<String, Integer>>();
	// 카카오페이 결제
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/kakaoPay")
	@ResponseBody
	public String kakaoPay(Integer cash, Principal principal) {
		try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			// 클라 요청과 요청받는 카카오페이 서버를 연결하는 역할
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 2e7146bdfd1c57aff884a560be0d3af7");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true); //서버에 줄것
			String pg_token = "";
			String parameter = 
					"cid=TC0ONETIME" // 가맹점 코드
					+ "&partner_order_id="+pg_token // 가맹점 주문번호
					+ "&partner_user_id="+principal.getName()// 가맹점 회원 id
					+ "&item_name=cash" // 상품명
					+ "&quantity=1" // 상품 수량
					+ "&total_amount="+cash // 총 금액
					+ "&vat_amount="+cash/10 // 부가세
					+ "&tax_free_amount="+(cash-cash/10) // 상품 비과세 금액
					+ "&approval_url=http://localhost:8080/guteam/payment/success" // 결제 성공 시
					+ "&fail_url=http://localhost:8080/guteam/member/profiles" // 결제 실패 시
					+ "&cancel_url=http://localhost:8080/guteam/member/profiles"; // 결제 취소 시
			// 파라미터 주는 역할(byte 형식으로)
			Map<String, Integer> token = new HashMap<>();
			token.put(principal.getName(), cash);
			paymentToken.put(pg_token, token);
			OutputStream sender = conn.getOutputStream();
			DataOutputStream data = new DataOutputStream(sender);
			
			data.writeBytes(parameter); // data에 넣기
			
//			data.flush(); // 넣은 값 보내고 비우기
			data.close(); // .close();로 flush() 자동 실행
			
			// 보낸 결과
			int result = conn.getResponseCode();
			logger.info("보낸 결과 = "+result);
			
			// 받는 역할
			InputStream receiver;
			
			if(result == 200) { // http:200 정상
				receiver = conn.getInputStream();
			} else { // 에러
				receiver = conn.getErrorStream();
			}
			
			// 읽는 역할
			InputStreamReader reader = new InputStreamReader(receiver);
			logger.info(reader.toString());
			// byte인 값 형변환
			BufferedReader bfr = new BufferedReader(reader);
			logger.info("bfr ? " + bfr);
			
			return bfr.readLine();
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "";
		
	}
		
	
	@RequestMapping("/success")
	public String paymentSuccess(Principal principal, Integer cash, String pg_token, RedirectAttributes reAttr) {
		if(paymentToken.get(pg_token).containsKey(principal.getName())) {
			memberService.update(principal.getName(), cash);
			reAttr.addFlashAttribute("chargeResult", "success");
			return "redirect:/member/profiles";
		}
		return "redirect:/member/profiles";
	}
	
	
	
	
	
	
	
	
	
//	@GetMapping("/kakaoPay")
//	@ResponseBody
//	public String kakaopay() {
//		logger.info("kakaopay() - get 호출");
//		try {
//			// 보내는 부분
//			URL address = new URL("https://kapi.kakao.com/v1/payment/ready");
//			HttpURLConnection connection = (HttpURLConnection) address.openConnection(); // 서버연결
//			connection.setRequestMethod("POST");
//			connection.setRequestProperty("Authorization", "KakaoAK 2e7146bdfd1c57aff884a560be0d3af7"); // 어드민 키
//			connection.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
//			connection.setDoOutput(true); // 서버한테 전달할게 있는지 없는지
//			String parameter = "cid=TC0ONETIME" // 가맹점 코드
//					+ "&partner_order_id=partner_order_id" // 가맹점 주문번호
//					+ "&partner_user_id=partner_user_id" // 가맹점 회원 id
//					+ "&item_name=초코파이" // 상품명
//					+ "&quantity=1" // 상품 수량
//					+ "&total_amount=5000" // 총 금액
//					+ "&vat_amount=200" // 부가세
//					+ "&tax_free_amount=0" // 상품 비과세 금액
//					+ "&approval_url=http://localhost:8080/" // 결제 성공 시
//					+ "&fail_url=http://localhost:8080/" // 결제 실패 시
//					+ "&cancel_url=http://localhost:8080/"; // 결제 취소 시
//			OutputStream send = connection.getOutputStream(); // 이제 뭔가를 를 줄 수 있다.
//			DataOutputStream dataSend = new DataOutputStream(send); // 이제 데이터를 줄 수 있다.
//			dataSend.writeBytes(parameter); // OutputStream은 데이터를 바이트 형식으로 주고 받기로 약속되어 있다. (형변환)
//			dataSend.close(); // flush가 자동으로 호출이 되고 닫는다. (보내고 비우고 닫다)
//			
//			int result = connection.getResponseCode(); // 전송 잘 됐나 안됐나 번호를 받는다.
//			InputStream receive; // 받다
//			
//			if(result == 200) {
//				receive = connection.getInputStream();
//			}else {
//				receive = connection.getErrorStream(); 
//			}
//			// 읽는 부분
//			InputStreamReader read = new InputStreamReader(receive); // 받은걸 읽는다.
//			BufferedReader change = new BufferedReader(read); // 바이트를 읽기 위해 형변환 버퍼리더는 실제로 형변환을 위해 존제하는 클레스는 아니다.
//			// 받는 부분
//			return change.readLine(); // 문자열로 형변환을 알아서 해주고 찍어낸다 그리고 본인은 비워진다.
//			
//		} catch (MalformedURLException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		return "";
//	}
	
}
