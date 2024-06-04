package com.gdu.academix.controller;

import java.util.Map;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.gdu.academix.dto.ChatroomDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.MessageDto;
import com.gdu.academix.service.ChatService;

@Controller
public class MessageController {
  
  private ChatService chatService;
  
  public MessageController(ChatService chatService) {
    super();
    this.chatService = chatService;
  }

  @MessageMapping("/{chatroomNo}") // 클라이언트가 해당 url로 메시지 보냄.
  @SendTo("/topic/{chatroomNo}")    // 해당 url 구독중인 클라이언트에게 메시지 보냄.
  public MessageDto chat(@DestinationVariable int chatroomNo, MessageDto message) {
    // MessageDto(messageType=CHAT, messageNo=0, isread=0, senderNo=14, chatroom=null, sendDt=null, messageContent=ㅎㅇ)
    
    // MESSAGE_T에 메시지 저장
    Map<String, Object> map = chatService.insertChatMessage(message);
    
    MessageDto chatMessage = (MessageDto) map.get("chatMessage");
    
    // 해당 메시지 반환 -> /topic/chatroomNo를 구독하는 유저에게 보내짐.
    return chatMessage;
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  /*
   * @MessageMapping("info")
   * 
   * @SendToUser("/queue/info") // 1:1로 메시지 보낼때 사용함. public String info(String
   * message, SimpMessageHeaderAccessor messageHeaderAccessor) { EmployeesDto
   * talker = (EmployeesDto)
   * messageHeaderAccessor.getSessionAttributes().get("user"); return message; }
   * 
   * @MessageMapping("chat") // 클라이언트가 chat 경로로 메시지 보낼 시..
   * 
   * @SendTo("/topic/message") // /topic/message라는 토픽을 구독하는 사용자들에게 메시지 전달 public
   * String chat(String message) { return message; }
   * 
   * @MessageMapping("bye")
   * 
   * @SendTo("/topic/bye") // 1:n으로 메시지 뿌릴때 사용 public EmployeesDto bye(String
   * message, SimpMessageHeaderAccessor messageHeaderAccessor) { EmployeesDto
   * talker = (EmployeesDto)
   * messageHeaderAccessor.getSessionAttributes().get("user"); return talker; }
   */
  
}
