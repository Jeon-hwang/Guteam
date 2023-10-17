package project.spring.guteam.domain;

public class FriendRequestVO {
	String sendMemberId;
	String receiveMemberId;
	
	public FriendRequestVO() {}
	
	public FriendRequestVO(String sendMemberId, String receiveMemberId) {
		super();
		this.sendMemberId = sendMemberId;
		this.receiveMemberId = receiveMemberId;
	}
	public String getSendMemberId() {
		return sendMemberId;
	}
	public void setSendMemberId(String sendMemberId) {
		this.sendMemberId = sendMemberId;
	}
	public String getReceiveMemberId() {
		return receiveMemberId;
	}
	public void setReceiveMemberId(String receiveMemberId) {
		this.receiveMemberId = receiveMemberId;
	}
	
	@Override
	public String toString() {
		return "FriendRequestVO [sendMemberId=" + sendMemberId + ", receiveMemberId=" + receiveMemberId + "]";
	}
	
}
