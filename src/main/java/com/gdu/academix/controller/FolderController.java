package com.gdu.academix.controller;

import java.util.List;
import java.util.Map;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gdu.academix.service.FolderService;

import jakarta.servlet.http.HttpServletRequest;


@RequestMapping("/drive")
@Controller
public class FolderController {
	
  private final FolderService folderService;
  
  public FolderController(FolderService folderService) {
    this.folderService = folderService;
  }
  
  @GetMapping("/main.page")
  public String main() {
    return "redirect:/drive/main.do";
  }
  
  // 드라이브 - 최근 파일(메인 화면) / 모든 목록 불러오기 구현 후 -> 최근 목록 불러오기 구현
  @GetMapping("/main.do")
  public String main(HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    folderService.loadUploadList(model);
    return "drive/main";
  }
  
  @GetMapping(value="/checkDrive.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> checkDrive(@RequestParam int employeeNo) {
    return folderService.checkDrive(employeeNo);
  }

  @PostMapping(value="/createDrive.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> createDrive(@RequestBody Map<String, Object> params) {
    return ResponseEntity.ok(Map.of("insertCount", folderService.createDrive(params)));
  }
  
  @GetMapping(value="/getFileList.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> getFileList() {
    return folderService.getFileList();
  }
  
  // 파일 업로드
  @PostMapping("/register.do")
  public String register(MultipartHttpServletRequest multipartRequest, RedirectAttributes redirectAttributes) {
    redirectAttributes.addFlashAttribute("inserted", folderService.registerUpload(multipartRequest));
    //return "redirect:/drive/main.page";
    return "redirect:/drive/main.do";
  }
  
  // 폴더 추가
  @PostMapping(value="/addFolder.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> addFolder(@RequestBody Map<String, Object> params) {
    return ResponseEntity.ok(Map.of("insertCount", folderService.addFolder(params)));
  }
  
  // 파일 다운로드
  @GetMapping(value="/download.do", produces="application/octet-stream")
  public ResponseEntity<Resource> download(HttpServletRequest request) {
    return folderService.download(request);
  }
  
  // 파일 삭제
  @PostMapping(value="/removeFile.do", produces="application/json")
  public ResponseEntity<Map<String, Object>> removeFile(@RequestBody Map<String, List<Integer>> params) {
    return folderService.removeFile(params);
  }
  

}
