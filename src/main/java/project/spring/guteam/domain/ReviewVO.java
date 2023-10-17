package project.spring.guteam.domain;

import java.util.Date;

public class ReviewVO {
	private int reviewId;
	private int gameId;
	private String memberId;
	private String reviewTitle;
	private String reviewContent;
	private Date reviewDateCreated;
	private int rating;
	private int thumbUpCount;
	
	public ReviewVO() {}
	public ReviewVO(int reviewId, int gameId, String memberId, String reviewTitle, String reviewContent,
			Date reviewDateCreated, int rating, int thumbUpCount) {
		this.reviewId = reviewId;
		this.gameId = gameId;
		this.memberId = memberId;
		this.reviewTitle = reviewTitle;
		this.reviewContent = reviewContent;
		this.reviewDateCreated = reviewDateCreated;
		this.rating = rating;
		this.thumbUpCount = thumbUpCount;
	}
	
	public int getReviewId() {
		return reviewId;
	}
	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}
	public int getGameId() {
		return gameId;
	}
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getReviewTitle() {
		return reviewTitle;
	}
	public void setReviewTitle(String reviewTitle) {
		this.reviewTitle = reviewTitle;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public Date getReviewDateCreated() {
		return reviewDateCreated;
	}
	public void setReviewDateCreated(Date reviewDateCreated) {
		this.reviewDateCreated = reviewDateCreated;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	public int getThumbUpCount() {
		return thumbUpCount;
	}
	public void setThumbUpCount(int thumbUpCount) {
		this.thumbUpCount = thumbUpCount;
	}
	
	@Override
	public String toString() {
		return "ReviewVO [reviewId=" + reviewId + ", gameId=" + gameId + ", memberId=" + memberId + ", reviewTitle="
				+ reviewTitle + ", reviewContent=" + reviewContent + ", reviewDateCreated=" + reviewDateCreated
				+ ", rating=" + rating + ", thumbUpCount=" + thumbUpCount + "]";
	}

	
}
