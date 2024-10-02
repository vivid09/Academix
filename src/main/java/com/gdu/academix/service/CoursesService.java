package com.gdu.academix.service;

import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gdu.academix.dto.CourseDto;

import jakarta.servlet.http.HttpServletRequest;

public interface CoursesService {
  boolean registerCourse(MultipartHttpServletRequest multipartRequest) throws Exception;
  ResponseEntity<Map<String, Object>> loadCourseList(HttpServletRequest request);
  CourseDto getCourseByNo(int courseNo);
  boolean modifyCourse(MultipartHttpServletRequest multipartRequest) throws Exception;
  boolean removeCourse(int courseNo);
}
