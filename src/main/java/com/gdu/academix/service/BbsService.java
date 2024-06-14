package com.gdu.academix.service;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;

public interface BbsService {
  int registerBbs(HttpServletRequest request);
  void loadBbsList(HttpServletRequest request, Model model);
  int registerReply(HttpServletRequest request);
  int removeBbs(int bbsNo);
  void loadBbsSearchList(HttpServletRequest request, Model model); 
}
