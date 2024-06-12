package com.gdu.academix.service;

import java.util.ArrayList;
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
  
  // 읽지 않은 알림 데이터 가져오기
  @Override
  public List<NotificationsDto> getNotificationList(int employeeNo) {
    try {
      int seenStatus = 0; // 읽지 않은 상태
      // 알람 데이터 담을 List 생성
      List<NotificationsDto> notificationList = notifyMapper.getNotificationList(employeeNo, seenStatus);
      return notificationList;
    } catch (Exception e) {
      e.printStackTrace();
    }
    return null;
  }
  
  @Override
  public int updateSeenStatus(List<Integer> notificationNoList) {
    return notifyMapper.updateSeenStatus(notificationNoList);
  }

}
