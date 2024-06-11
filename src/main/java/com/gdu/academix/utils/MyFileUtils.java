package com.gdu.academix.utils;

import java.io.File;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class MyFileUtils {
  @Value("${service.file.uploadurl}")
  public String UP_DIR;
  
  // 현재 날짜
  public static final LocalDate TODAY = LocalDate.now();
  
  // CoursePlan 업로드 경로 반환
  public String getCoursePlanPath() {
    return UP_DIR + "/coursePlan" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 업로드 경로 반환
  public String getUploadPath() {
    return   UP_DIR+"/upload" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 저장될 파일명 반환
  public String getFilesystemName(String originalFilename) {
    String extName = null;
    if(originalFilename.endsWith(".tar.gz")) {
      extName = ".tar.gz";
    } else {
      extName = originalFilename.substring(originalFilename.lastIndexOf("."));
    }
    return UUID.randomUUID().toString().replace("-", "") + extName;
  }
  
  // 임시 파일 경로 반환
  public String getTempPath() {
    return UP_DIR + "/temporary";
  }
  
  // 임시 파일 이름 반환 (확장자 제외)
  public String getTempFilename() {
    return System.currentTimeMillis() + "";
  }
  
  // 블로그 작성시 사용된 이미지가 저장될 경로 반환하기
  public String getBlogImageUploadPath() {
    return "/blog" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
  }
  
  // 블로그 이미지가 저장된 어제 경로를 반환
  public String getBlogImageUploadPathInYesterday() {
    return "/blog" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY.minusDays(1));
  }
  
  
//미니 프로필 경로 반환
 public String getMiniProfilePath() {
   return "/profile/mini" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
 }
 
 // 메인 프로필 경로 반환
 public String getMainProfilePath() {
   return UP_DIR +"/profile/main" + DateTimeFormatter.ofPattern("/yyyy/MM/dd").format(TODAY);
 }
 
 public String updateProfilePicture(MultipartHttpServletRequest multipartRequest, String paramName) {
	    
	    MultipartFile profile = multipartRequest.getFile(paramName);
	    
	    String profilePicturePath = "";
	    
	    if(profile != null && !profile.isEmpty() && profile.getSize() > 0) {
	      StringBuilder builder = new StringBuilder();
	      String uploadPath = null;
	      if(paramName == "miniProfilePicturePath") {
	        uploadPath = getMiniProfilePath();
	      } else {
	        uploadPath = getMainProfilePath();
	      }
	      File dir = new File(uploadPath);
	      if(!dir.exists()) {
	        dir.mkdirs();
	      }
	      String originalFilename = profile.getOriginalFilename();
	      
	      System.out.println(originalFilename);
	      
	      String filesystemName = getFilesystemName(originalFilename);
	      // UP_DIR을 제거하고 상대 경로만 사용
          String relativePath = uploadPath.substring(UP_DIR.length());
	      profilePicturePath = builder.append("<img src=\"").append(multipartRequest.getContextPath()).append(relativePath).append("/") .append(filesystemName).append("\">").toString();
	      builder.setLength(0);
	      
	      File file = new File(dir, filesystemName);
	      
	      try {
	        profile.transferTo(file);
	        
	      } catch (Exception e) {
	        e.printStackTrace();
	      }
	    }
	    
	    return profilePicturePath;
	  }
  
  
  
}