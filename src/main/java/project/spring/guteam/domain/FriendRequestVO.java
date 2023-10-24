package project.spring.guteam.domain;

import java.util.Date;

public class FriendRequestVO {
	String sendMemberId;
	String receiveMemberId;
	Date sendDate;
	
	public FriendRequestVO() {}

	public FriendRequestVO(String sendMemberId, String receiveMemberId, Date sendDate) {
		super();
		this.sendMemberId = sendMemberId;
		this.receiveMemberId = receiveMemberId;
		this.sendDate = sendDate;
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

	public Date getSendDate() {
		return sendDate;
	}

	public void setSendDate(Date sendDate) {
		this.sendDate = sendDate;
	}

	@Override
	public String toString() {
		return "FriendRequestVO [sendMemberId=" + sendMemberId + ", receiveMemberId=" + receiveMemberId + ", sendDate="
				+ sendDate + "]";
	}
	
	
}
