package project.spring.guteam.domain;

public class ThumbVO {
	private int reviewId;
	private String memberId;
	private int upDown;
	
	public ThumbVO() {}
	public ThumbVO(int reviewId, String memberId, int upDown) {
		this.reviewId = reviewId;
		this.memberId = memberId;
		this.upDown = upDown;
	}
	
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getUpDown() {
		return upDown;
	}
	public void setUpDown(int upDown) {
		this.upDown = upDown;
	}
	@Override
	public String toString() {
		return "ThumbVO [reviewId=" + reviewId + ", memberId=" + memberId + ", upDown=" + upDown + "]";
	}
	
	
}
