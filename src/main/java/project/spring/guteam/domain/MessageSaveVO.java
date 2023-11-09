package project.spring.guteam.domain;

import java.util.Date;

public class MessageSaveVO {
	private int messageId;
	private String memberId;
	private String fromToId;
	private String fromToNickname;
	private String fromTo;
	private String title;
	private String content;
	private Date dateCreated;
	
	public MessageSaveVO() {}
	
	public MessageSaveVO(int messageId, String memberId, String fromToId, String fromToNickname, 
			String fromTo,String title, String content, Date dateCreated) {
		this.messageId = messageId;
		this.memberId = memberId;
		this.fromToId = fromToId;
		this.fromTo = fromTo;
		this.title = title;
		this.content = content;
		this.dateCreated = dateCreated;
	}
	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getFromToId() {
		return fromToId;
	}
	public void setFromToId(String fromToId) {
		this.fromToId = fromToId;
	}
	public String getFromToNickname() {
		return fromToNickname;
	}
	public void setFromToNickname(String fromToNickname) {
		this.fromToNickname = fromToNickname;
	}
	public String getFromTo() {
		return fromTo;
	}
	public void setFromTo(String fromTo) {
		this.fromTo = fromTo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDateCreated() {
		return dateCreated;
	}
	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}
	@Override
	public String toString() {
		return "SaveMessageVO [messageId=" + messageId + ", memberId=" + memberId + ", fromToId=" + fromToId
				+ ", fromToNickname=" + fromToNickname + ", fromTo=" + fromTo + ", title=" + title + ", content="
				+ content + ", dateCreated=" + dateCreated + "]";
	}
	
}
