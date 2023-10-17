package project.spring.guteam.domain;

import java.util.Date;

public class MessageVO {
	int messageId;
	String receiveMemberId;
	String sendMemberId;
	String sendMemberNickname;
	String messageTitle;
	String messageContent;
	Date messageDateCreated;
	
	public MessageVO() {}
	
	public MessageVO(int messageId, String receiveMemberId, String sendMemberId, String sendMemberNickname,
			String messageTitle, String messageContent, Date messageDateCreated) {
		super();
		this.messageId = messageId;
		this.receiveMemberId = receiveMemberId;
		this.sendMemberId = sendMemberId;
		this.sendMemberNickname = sendMemberNickname;
		this.messageTitle = messageTitle;
		this.messageContent = messageContent;
		this.messageDateCreated = messageDateCreated;
	}
	
	public int getMessageId() {
		return messageId;
	}
	public void setMessageId(int messageId) {
		this.messageId = messageId;
	}
	public String getReceiveMemberId() {
		return receiveMemberId;
	}
	public void setReceiveMemberId(String receiveMemberId) {
		this.receiveMemberId = receiveMemberId;
	}
	public String getSendMemberId() {
		return sendMemberId;
	}
	public void setSendMemberId(String sendMemberId) {
		this.sendMemberId = sendMemberId;
	}
	public String getSendMemberNickname() {
		return sendMemberNickname;
	}
	public void setSendMemberNickname(String sendMemberNickname) {
		this.sendMemberNickname = sendMemberNickname;
	}
	public String getMessageTitle() {
		return messageTitle;
	}
	public void setMessageTitle(String messageTitle) {
		this.messageTitle = messageTitle;
	}
	public String getMessageContent() {
		return messageContent;
	}
	public void setMessageContent(String messageContent) {
		this.messageContent = messageContent;
	}
	public Date getMessageDateCreated() {
		return messageDateCreated;
	}
	public void setMessageDateCreated(Date messageDateCreated) {
		this.messageDateCreated = messageDateCreated;
	}
	
	@Override
	public String toString() {
		return "MessageVO [messageId=" + messageId + ", receiveMemberId=" + receiveMemberId + ", sendMemberId="
				+ sendMemberId + ", sendMemberNickname=" + sendMemberNickname + ", messageTitle=" + messageTitle
				+ ", messageContent=" + messageContent + ", messageDateCreated=" + messageDateCreated + "]";
	}
	
}
