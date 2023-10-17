package project.spring.guteam.domain;

public class WishListVO {
	String memberId;
	int gameId;
	
	public WishListVO() {}
	
	public WishListVO(String memberId, int gameId) {
		super();
		this.memberId = memberId;
		this.gameId = gameId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getGameId() {
		return gameId;
	}
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	
	@Override
	public String toString() {
		return "WishListVO [memberId=" + memberId + ", gameId=" + gameId + "]";
	}
	
}
