package com.gdu.academix.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.gdu.academix.dto.EmployeesDto;
import com.gdu.academix.dto.NotificationsDto;
import com.gdu.academix.mapper.NotifyMapper;
import com.gdu.academix.mapper.UserMapper;

@Service
public class NotifyServiceImpl implements NotifyService {

  private NotifyMapper notifyMapper;
  private UserMapper userMapper;

  public NotifyServiceImpl(NotifyMapper notifyMapper, UserMapper userMapper) {
    super();
    this.notifyMapper = notifyMapper;
    this.userMapper = userMapper;
  }

  // 알림 데이터 넣기
  @Override
  public int insertNotification(NotificationsDto notification) {
    int insertNotificationCount = notifyMapper.insertNotification(notification);
    return insertNotificationCount;
  }
  
  // 알림 데이터 가져오기
  @Override
  public List<NotificationsDto> getNotificationList(int employeeNo) {
    
    try {

      // 알람 데이터 담을 List 생성
      List<NotificationsDto> notificationList = notifyMapper.getNotificationList(employeeNo);
      
      // 중복 제거한 송신자 번호 리스트(notifierNoList)
      List<Integer> notifierNoList = notificationList.stream()
          .map(NotificationsDto::getNotifierNo)
          .distinct()
          .collect(Collectors.toList());
      
      // 중복 제거한 송신자 번호 리스트의 객체를 가져온다...
      List<EmployeesDto> notifierList = userMapper.getUserProfileList(notifierNoList);
      
      // employeeNo를 key로, name을 value로하는 map -> 이름을 미리 담아놓음.
      Map<Integer, String> employeeMap = new HashMap<>();
      
      for(int i=0, size=notifierList.size(); i < size; i++) {
        
        StringBuilder builder = new StringBuilder();
        builder.append(notifierList.get(i).getName());
        builder.append(" ");
        builder.append(notifierList.get(i).getRank().getRankTitle());
        
        // employeeNo를 key로 하고 builder값을 value로 하는 map 생성 후 여기다 넣기
        employeeMap.put(notifierList.get(i).getEmployeeNo(), builder.toString());
      }
      
      // List를 돌면서 해당 유저의 이름 가져와서 넣어줌.
      for(NotificationsDto notification: notificationList) {
        // notification.getNotifierNo()와 employeeMap의 key값을 비교해서 같은건
        //notification.setNotifierName() 에 value값 넣기
        int notifierNo = notification.getNotifierNo();
        if(employeeMap.containsKey(notifierNo)) {
          notification.setNotifierName(employeeMap.get(notifierNo));
        }
      }
      
      return notificationList;
      
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    return null;
    
  }

}
