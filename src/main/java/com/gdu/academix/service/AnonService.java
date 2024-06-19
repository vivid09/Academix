package com.gdu.academix.service;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.gdu.academix.dto.AnonDto;

public interface AnonService {
  ResponseEntity<Map<String, Object>> summernoteImageUpload(MultipartFile multipartFile);
  int registerAnon(HttpServletRequest request);
  ResponseEntity<Map<String, Object>> getAnonList(HttpServletRequest request);
  int updateHit(int postNo);
  AnonDto getAnonByNo(int postNo);
  List<String> getEditorImageList(String content);
  int modifyAnon(HttpServletRequest request);
  int removeAnon(int postNo);
  int updatePostStatus(HttpServletRequest request);
  
  int registerComment(HttpServletRequest request);
  Map<String, Object> getCommentList(HttpServletRequest request);
  int registerReply(HttpServletRequest request);
  int removeComment(int commentNo);
  void removeAnonImageNotOnTheTable();
  
  // 게시글상세 조회수
  int getHitCountByPostNo(int postNo);
  
  
}
