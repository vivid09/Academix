package com.gdu.academix.service;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;

import com.gdu.academix.dto.UserDto;

public interface UserService {

  // 가입 및 탈퇴
  ResponseEntity<Map<String, Object>> checkEmail(Map<String, Object> params);
  ResponseEntity<Map<String, Object>> sendCode(Map<String, Object> params);
  void signup(HttpServletRequest request, HttpServletResponse response);  
  void leave(HttpServletRequest request, HttpServletResponse response);

  // 로그인 및 로그아웃
  String getRedirectURLAfterSignin(HttpServletRequest request);  
  void signin(HttpServletRequest request, HttpServletResponse response);
  void signout(HttpServletRequest request, HttpServletResponse response);
  
  // 네이버 로그인
  String getNaverLoginURL(HttpServletRequest request);
  String getNaverLoginAccessToken(HttpServletRequest request);
  UserDto getNaverLoginProfile(String accessToken);
  boolean hasUser(UserDto user);
  void naverSignin(HttpServletRequest request, UserDto naverUser);
  
  
  
}
