package com.gdu.academix.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.academix.service.NotifyService;

@RequestMapping("/notification")
@Controller
public class NotificationController {
  
  private NotifyService notifyService;

  public NotificationController(NotifyService notifyService) {
    super();
    this.notifyService = notifyService;
  }
  
  @GetMapping(value="/getNotificationList.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> getNotificationList(@RequestParam int employeeNo) {
    return ResponseEntity.ok(Map.of("notificationList", notifyService.getNotificationList(employeeNo)));
  }
  
  // SeenStatus값 0에서 1로 변경
  @PatchMapping(value="/updateSeenStatus.do", produces = "application/json")
  public ResponseEntity<Map<String, Object>> updateSeenStatus(@RequestBody Map<String, List<Integer>> params) {
    return ResponseEntity.ok(Map.of("updateStatusCount", notifyService.updateSeenStatus(params.get("notificationNoList"))));
  }
  
}
