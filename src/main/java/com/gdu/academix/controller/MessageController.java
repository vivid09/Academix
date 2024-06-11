package com.gdu.academix.controller;

import java.awt.print.Printable;
import java.security.Principal;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;

import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessageType;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.messaging.simp.user.SimpSession;
import org.springframework.messaging.simp.user.SimpUser;
import org.springframework.messaging.simp.user.SimpUserRegistry;
import org.springframework.messaging.support.MessageHeaderAccessor;
import org.springframework.stereotype.Controller;

import com.gdu.academix.dto.ChatroomDto;
import com.gdu.academix.dto.CustomPrincipal;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.MessageDto;
import com.gdu.academix.dto.MessageDto.MessageType;
import com.gdu.academix.dto.NotificationsDto;
import com.gdu.academix.service.ChatService;
import com.gdu.academix.service.NotifyService;
import com.gdu.academix.service.UserService;

@Controller
public class MessageController {
  
  private ChatService chatService;
  private UserService userService;
  private NotifyService notifyService;
  
  private SimpMessagingTemplate messagingTemplate;
  
  //private SimpUserRegistry simpUserRegistry;
  
  public MessageController(ChatService chatService, UserService userService, NotifyService notifyService,
      SimpMessagingTemplate messagingTemplate) {
    super();
    this.chatService = chatService;
    this.userService = userService;
    this.notifyService = notifyService;
    this.messagingTemplate = messagingTemplate;
  }

  // 1:1
  @MessageMapping("/one/{chatroomNo}") // 클라이언트가 해당 url로 메시지 보냄.
  @SendTo("/topic/{chatroomNo}")    // 해당 url 구독중인 클라이언트에게 메시지 보냄.
  public MessageDto OneToOneChat(@DestinationVariable int chatroomNo, MessageDto message) {
    
    System.out.println("받은 메시지: " + message);
    
    try {
      if(message.getMessageType().equals(MessageType.CHAT)) {
        // MESSAGE_T에 메시지 저장
        Map<String, Object> map = chatService.insertChatMessage(message);
        
        MessageDto chatMessage = (MessageDto) map.get("chatMessage");

        return chatMessage;
        
      } else if(message.getMessageType().equals(MessageType.LEAVE)){
        
        return message;

      } else {
        // 메시지를 받으면 chatroom_participate_t의 participate_status 변경해주어야 함.
        // DB로 보낼 map 생성
        Map<String, Object> params = Map.of("chatroomNo", message.getChatroomNo(), "participantNo", message.getSenderNo(), "participateStatus", Integer.parseInt(message.getMessageContent()));
        
        // db update 해주기
        int updateCount = chatService.updateParticipateStatus(params);
        if(updateCount == 1) {
          return message;
        } else {
          return message;
        }
        
        
      }
      

       
      
      // 해당 메시지 반환 -> /topic/chatroomNo를 구독하는 유저에게 보내짐.
      
      
    } catch (Exception e) {
      e.printStackTrace();
      throw new RuntimeException("Error handling one-to-one chat message");
    }
  }
  
  // 단체
  @MessageMapping("/group/{chatroomNo}") // 클라이언트가 해당 url로 메시지 보냄.
  @SendTo("/queue/{chatroomNo}")    // 해당 url 구독중인 클라이언트에게 메시지 보냄.
  public MessageDto GroupChat(@DestinationVariable int chatroomNo, MessageDto message) {
    
    System.out.println("받은 메시지: " + message);
    
    try {
      
      if(message.getMessageType().equals(MessageType.CHAT)) {
        // MESSAGE_T에 메시지 저장
        Map<String, Object> map = chatService.insertChatMessage(message);
        
        MessageDto chatMessage = (MessageDto) map.get("chatMessage");
        
        return chatMessage;
        
      } else if(message.getMessageType().equals(MessageType.JOIN)){
        // MESSAGE_T에 메시지 저장
        Map<String, Object> map = chatService.insertChatMessage(message);
        
        MessageDto chatMessage = (MessageDto) map.get("chatMessage");
        
        return chatMessage;
       
      } else if(message.getMessageType().equals(MessageType.LEAVE)){
        
        // MESSAGE_T에 메시지 저장
        Map<String, Object> map = chatService.insertChatMessage(message);
        
        MessageDto chatMessage = (MessageDto) map.get("chatMessage");
        
        return message;
      
      } else {
        
        // 메시지를 받으면 chatroom_participate_t의 participate_status 변경해주어야 함.
        // DB로 보낼 map 생성
        Map<String, Object> params = Map.of("chatroomNo", message.getChatroomNo(), "participantNo", message.getSenderNo(), "participateStatus", Integer.parseInt(message.getMessageContent()));
        
        // db update 해주기
        int updateCount = chatService.updateParticipateStatus(params);
        if(updateCount == 1) {
          return message;
        } else { // 이부분이 의미가 없네....
          return message;
        }
      }

      
      /*
       * for(Integer recipientNo : chatMessage.getRecipientNoList()) {
       * if(!recipientNo.equals(message.getSenderNo())) {
       * messagingTemplate.convertAndSendToUser(String.valueOf(recipientNo),
       * "/queue/notifications", chatMessage); } }
       */
      
      // 해당 메시지 반환 -> /queue/chatroomNo를 구독하는 유저에게 보내짐.
      
      
    } catch (Exception e) {
      e.printStackTrace();
      throw new RuntimeException("Error handling one-to-one chat message");
    }
  }
  
  
/*
  if (chatMessage.getRecipientNoList() == null) {
    chatMessage.setRecipientNoList(new ArrayList<>()); 
  }
  
  for(Integer recipientNo : chatMessage.getRecipientNoList()) { // 본인 제외
    if(!recipientNo.equals(message.getSenderNo())) {
      messagingTemplate.convertAndSendToUser(String.valueOf(recipientNo), "/queue/notifications", chatMessage); 
    } 
  }
*/  
  

  @MessageMapping("/notify")
  public void notifyUser(MessageDto message, CustomPrincipal customPrincipal) {
    
    System.out.println("받은 알림 메시지: " + message);
    
      if(message.getRecipientNoList() == null) {
        message.setRecipientNoList(new ArrayList<>());
      }
      
      // 메시지 송신자의 이름 가져옴.
      int notifierNo = message.getSenderNo();
      EmployeesDto employee = userService.getUserProfileByNo(notifierNo);
      
      String notifierName = employee.getName() + " " + employee.getRank().getRankTitle();
      
      for(Integer recipientNo : message.getRecipientNoList()) {
        if(!recipientNo.equals(message.getSenderNo())) {
          System.out.println("전송된 알림 메시지: " + message + "to user: " + recipientNo);
          
          // senderNo에 해당하는 사용자 객체 가져와서 이름 추가
          
          try {
            
            // NotificationsDto 생성
            NotificationsDto notification = NotificationsDto.builder()
                                                   .message(message.getMessageContent())
                                                   .notificationType("CHAT")
                                                   .notifierNo(notifierNo)
                                                   .seenStatus(0)
                                                   .employeeNo(recipientNo)
                                                   .chatroomNo(message.getChatroomNo())
                                                 .build();
            
            
            // NotificationsDto DB에 저장
            int insertNotificationCount = notifyService.insertNotification(notification);
            
            
            // 보낸 객체에서 timestamp랑 송신자 이름 dto에 같이 실어서 보내기
            Instant now = Instant.now();
            Timestamp timestamp = Timestamp.from(now);
            
            notification.setNotificationDate(timestamp);
            notification.setNotifierName(notifierName);
            
            
            // 수신자에게 메시지 전송
            String username = "user-" + recipientNo;
            messagingTemplate.convertAndSendToUser(username, "/queue/notifications", notification);
            
          } catch (Exception e) {
            
            e.printStackTrace();
          }
          

          
          // 메시지 수신자의 세션 ID를 가져오기
          //Set<SimpUser> users = simpUserRegistry.getUsers();
          /*
           * for(SimpUser user : users) {
           * if(user.getName().equals(recipientNo.toString())) { for(SimpSession session :
           * user.getSessions()) { try { System.out.println("session.getId(): " +
           * session.getId()); // 특정 사용자에게 메시지 전송
           * messagingTemplate.convertAndSendToUser(user.getName(),
           * "/queue/notifications", message.getMessageContent());
           * 
           * } catch (Exception e) { e.printStackTrace(); } } } }
           */
          /*
           * try { //messagingTemplate.convertAndSendToUser(recipientNo.toString(),
           * "/queue/notifications", message.getMessageContent());
           * System.out.println("customPrincipal.getName(): " +
           * customPrincipal.getName());
           * messagingTemplate.convertAndSendToUser(recipientNo.toString(),
           * "/queue/notifications", message.getMessageContent()); } catch (Exception e) {
           * e.printStackTrace(); }
           */
        }
      }
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
