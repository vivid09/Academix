package com.gdu.academix.service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.gdu.academix.dto.ChatroomDto;
import com.gdu.academix.dto.ChatroomParticipateDto;
import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.MessageDto;
import com.gdu.academix.mapper.ChatMapper;
import com.gdu.academix.mapper.UserMapper;
import com.gdu.academix.utils.MyPageUtils;

@Service
public class ChatServiceImpl implements ChatService {
  
  private ChatMapper chatMapper;
  private UserMapper userMapper;
  
  private MyPageUtils myPageUtils;

  public ChatServiceImpl(ChatMapper chatMapper, UserMapper userMapper, MyPageUtils myPageUtils) {
    super();
    this.chatMapper = chatMapper;
    this.userMapper = userMapper;
    this.myPageUtils = myPageUtils;
  }

  // 메시지 데이터 저장
  @Override
  public Map<String, Object> insertChatMessage(MessageDto message) {
    
    MessageDto chatMessage = MessageDto.builder()
                                  .messageType(message.getMessageType())
                                  .messageContent(message.getMessageContent())
                                  .isRead(message.getIsRead())
                                  .chatroomNo(message.getChatroomNo())
                                  .senderNo(message.getSenderNo())
                                .build();
    
    // DB에 메시지 저장
    int insertMessageCount = chatMapper.insertChatMessage(chatMessage);
    
    // 현재 시간만 추가해서 message에 넣기
    long currentTimeMillis = System.currentTimeMillis();
    Timestamp currentTimestamp = new Timestamp(currentTimeMillis); 
    chatMessage.setSendDt(currentTimestamp);
    
    // map 생성
    Map<String, Object> map = Map.of("insertMessageCount", insertMessageCount,
                                     "chatMessage", chatMessage);
    return map;
  }
  
  // 1:1 채팅방 여부 확인
  @Override
  public ChatroomDto isOneToOneChatroomExits(int loginUserNo, int chatUserNo) {
    Map<String, Object> map = Map.of("loginUserNo", loginUserNo, "chatUserNo", chatUserNo);
    
    ChatroomDto chatroom = chatMapper.isOneToOneChatroomExits(map);
    if(chatroom == null) {
      chatroom = new ChatroomDto();
    }
    return chatroom;
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> addOneToOneChatroom(Map<String, Object> params) {

    int loginUserNo = Integer.parseInt(String.valueOf(params.get("loginUserNo")));
    int chatUserNo = Integer.parseInt(String.valueOf(params.get("chatUserNo")));
    
    // 해당 유저 데이터 가져오기
    EmployeesDto loginUser = userMapper.getUserProfileByNo(loginUserNo);
    EmployeesDto chatUser = userMapper.getUserProfileByNo(chatUserNo);
    
    
    // 1. chatroomDto 생성.
    ChatroomDto chatroomDto = ChatroomDto.builder()
                                  .chatroomTitle(loginUser.getName() + ", " + chatUser.getName())
                                  .chatroomType("OneToOne")
                                .build();
    
    // 2. 생성한 chatroomDto를 chatMapper에 보냄.
    int insertOneToOneChatroomCount = chatMapper.insertNewOneToOneChatroom(chatroomDto);
    

    
    
    // 3. ChatroomParticipateDto 생성
    ChatroomParticipateDto chatroomParticipateDto1 = ChatroomParticipateDto.builder()
                                                              .chatroomNo(chatroomDto.getChatroomNo())
                                                              .participantNo(loginUserNo)
                                                          .build();
    ChatroomParticipateDto chatroomParticipateDto2 = ChatroomParticipateDto.builder()
                                                              .chatroomNo(chatroomDto.getChatroomNo())
                                                              .participantNo(chatUserNo)
                                                          .build();
    
    
    // 4. 순서대로 chatroom_participate_t 삽입
    int insertOneToOneParticipantCount = 0;
    insertOneToOneParticipantCount = chatMapper.insertNewOneToOneParticipate(chatroomParticipateDto1);
    insertOneToOneParticipantCount += chatMapper.insertNewOneToOneParticipate(chatroomParticipateDto2);
    
    // 5. 채팅방 여부 메소드를 통해 새로 넣은 객체 가져옴.
    Map<String, Object> map = Map.of("loginUserNo", loginUserNo, "chatUserNo", chatUserNo);
    ChatroomDto newChatroomDto = chatMapper.isOneToOneChatroomExits(map);
    
    // 6. 삽입 성공 여부를 담은 값과 새로 생성한 chatroomDto 객체를 보낸다.
    if(insertOneToOneChatroomCount == 1 && insertOneToOneParticipantCount == 2) {
      return ResponseEntity.ok(Map.of("insertOneToOneCount", 1,
                                      "chatroom", newChatroomDto));
    } else {
      return ResponseEntity.ok(Map.of("insertOneToOneCount", 0));
    }
    
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getChatMessageList(int chatroomNo, int page) {

    // 채팅방 메시지 전체 개수
    int total = chatMapper.getChatMessageCount(chatroomNo);
    
    // 한번에 가지고올 메시지 개수
    int display = 20;
    
    // 페이징 처리
    myPageUtils.setPaging(total, display, page);
    
    // DB에 필요한 map 생성
    Map<String, Object> map = Map.of("chatroomNo", chatroomNo,
                                     "begin", myPageUtils.getBegin(),
                                     "end", myPageUtils.getEnd());
    
    // 채팅 내역 리스트 가져오기
    List<MessageDto> chatMessageList = chatMapper.getChatMessageList(map);
    
    return ResponseEntity.ok(Map.of("chatMessageList", chatMessageList,
                                    "chatMessageTotalPage", myPageUtils.getTotalPage()));
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getChatList(int employeeNo) {
    List<ChatroomDto> chatroomList = chatMapper.getChatList(employeeNo);
    
    for(int i = 0; i < chatroomList.size(); i++) {
      int chatroomNo = chatroomList.get(i).getChatroomNo();
      int participantCount = chatMapper.getChatroomParticipantCount(chatroomNo);
      chatroomList.get(i).setParticipantCount(participantCount);
    }
    
    return ResponseEntity.ok(Map.of("chatroomList", chatroomList));
  }
  
  @Override
  public ResponseEntity<Map<String, Object>> getChatroomByChatroomNo(int chatroomNo) {
    return ResponseEntity.ok(Map.of("chatroom", chatMapper.getChatroomByChatroomNo(chatroomNo)));
  }
  
  /*
   * @Override public ResponseEntity<Map<String, Object>>
   * getChatTotalPageCount(int chatroomNo, int page) {
   * 
   * // 채팅방 메시지 전체 개수 int total = chatMapper.getChatMessageCount(chatroomNo);
   * 
   * // 한번에 가지고올 메시지 개수 int display = 20;
   * 
   * // 페이징 처리 myPageUtils.setPaging(total, display, page);
   * 
   * return ResponseEntity.ok(Map.of("chatMessageTotalPage",
   * myPageUtils.getTotalPage())); }
   */
  
  @Override
  public ResponseEntity<Map<String, Object>> getChatroomParticipantList(int chatroomNo) {
    List<ChatroomParticipateDto> employeeNoList = chatMapper.getChatroomParticipantList(chatroomNo);
    return ResponseEntity.ok(Map.of("employeeNoList", employeeNoList));
  }
  
  

}
