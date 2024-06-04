package com.gdu.academix.controller;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.gdu.academix.service.FolderService;

import jakarta.servlet.http.HttpServletRequest;


@RequestMapping("/drive")
@Controller
public class FolderController {
	
  private final FolderService folderService;
  
  public FolderController(FolderService folderService) {
    super();
    this.folderService = folderService;
  }
  
  @GetMapping("/main.page")
  public String main() {
    return "drive/main";
  }
  
  @GetMapping(value="/checkDrive.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> checkDrive(@RequestParam int employeeNo) {
    return folderService.checkDrive(employeeNo);
  }

  @PostMapping(value="/createFolder.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> createFolder(HttpServletRequest request) {
    return ResponseEntity.ok(Map.of("insertCount", folderService.createFolder(request)));
  }

  
  
  
  
  
  
  
  
}
