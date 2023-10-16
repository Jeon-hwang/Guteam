package project.spring.guteam.domain;

public class FriendVO {
	String memberId;
	String friendId;
	
	public FriendVO() {}
	
	
	public FriendVO(String memberId, String friendId) {
		super();
		this.memberId = memberId;
		this.friendId = friendId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getFriendId() {
		return friendId;
	}
	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}
	
	@Override
	public String toString() {
		return "FriendVO [memberId=" + memberId + ", friendId=" + friendId + "]";
	}
	
	
}
