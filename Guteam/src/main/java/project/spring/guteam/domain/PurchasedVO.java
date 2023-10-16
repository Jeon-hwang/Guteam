package project.spring.guteam.domain;

import java.util.Date;

public class PurchasedVO {
	String memberId;
	int gameId;
	Date purchaseDate;
	
	public PurchasedVO() {}
	
	public PurchasedVO(String memberId, int gameId, Date purchaseDate) {
		super();
		this.memberId = memberId;
		this.gameId = gameId;
		this.purchaseDate = purchaseDate;
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
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	
	@Override
	public String toString() {
		return "PurchasedVO [memberId=" + memberId + ", gameId=" + gameId + ", purchaseDate=" + purchaseDate + "]";
	}
	
	
}
