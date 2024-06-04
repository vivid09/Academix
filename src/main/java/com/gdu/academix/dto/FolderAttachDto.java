package com.gdu.academix.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Builder
public class FolderAttachDto {
	
  /**
   * 
   * @author 장윤수
   * 
   * @param folderAttachNo   : 첨부 번호
   * @param uploadPath       : 업로드 경로
   * @param filesystemName   : 파일 이름
   * @param originalFilename : 원본 이름
   * @param uploadDt         : 업로드 날짜
   * @param folderNo         : 폴더 번호
   * @param EmployeesDto employee -> employeeNo (ownerNo) : 파일 소유 직원 번호
   */
  
  private int folderAttachNo, folderNo, ownerNo;
  private String uploadPath, filesystemName, originalFilename;
  private Timestamp uploadDt;
  
}
