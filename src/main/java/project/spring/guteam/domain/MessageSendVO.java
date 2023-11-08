package project.spring.guteam.domain;

import java.util.Date;

public class MessageSendVO {
	int sendMessageId;
	String sendMemberId;
	String receiveMemberId;
	String receiveMemberNickname;
	String messageTitle;
	String messageContent;
	Date messageDateCreated;
	String messageSave;
	
	public MessageSendVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MessageSendVO(int sendMessageId, String sendMemberId, String receiveMemberId, String receiveMemberNickname,
			String messageTitle, String messageContent, Date messageDateCreated, String messageSave) {
		super();
		this.sendMessageId = sendMessageId;
		this.sendMemberId = sendMemberId;
		this.receiveMemberId = receiveMemberId;
		this.receiveMemberNickname = receiveMemberNickname;
		this.messageTitle = messageTitle;
		this.messageContent = messageContent;
		this.messageDateCreated = messageDateCreated;
		this.messageSave = messageSave;
	}

	public int getSendMessageId() {
		return sendMessageId;
	}

	public void setSendMessageId(int sendMessageId) {
		this.sendMessageId = sendMessageId;
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

	public String getReceiveMemberNickname() {
		return receiveMemberNickname;
	}

	public void setReceiveMemberNickname(String receiveMemberNickname) {
		this.receiveMemberNickname = receiveMemberNickname;
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

	public String getMessageSave() {
		return messageSave;
	}

	public void setMessageSave(String messageSave) {
		this.messageSave = messageSave;
	}

	@Override
	public String toString() {
		return "MessageSendVO [sendMessageId=" + sendMessageId + ", sendMemberId=" + sendMemberId + ", receiveMemberId="
				+ receiveMemberId + ", receiveMemberNickname=" + receiveMemberNickname + ", messageTitle="
				+ messageTitle + ", messageContent=" + messageContent + ", messageDateCreated=" + messageDateCreated
				+ ", messageSave=" + messageSave + "]";
	}
	
	
	
}
