package com.gdu.academix.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class MessageDto {
	
	public enum MessageType{
		ENTER, TALK, LEAVE;
	}
	
	private MessageType messageType;
	private int messageNo, isread, chatroomNo, senderNo;
	private String messageContent; 

}
